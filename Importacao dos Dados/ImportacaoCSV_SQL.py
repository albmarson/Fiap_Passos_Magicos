import os
import pandas as pd
import pyodbc

# Caminho base
base_path = r"C:\Users\Alberto Marson\Downloads\Base de dados - Passos Mágicos\Base de dados - Passos Mágicos"

# Configuração do banco de dados
server = 'localhost'
database = 'FIAP'
connection_string = (
    f"DRIVER={{ODBC Driver 17 for SQL Server}};"
    f"SERVER={server};"
    f"DATABASE={database};"
    f"Trusted_Connection=yes;"
)

# Conectar ao banco de dados
try:
    conn = pyodbc.connect(connection_string)
    print("Conexão bem-sucedida ao banco de dados.")
except Exception as e:
    print("Erro ao conectar ao banco de dados:", e)
    exit()

# Função para ajustar tipos do DataFrame ao SQL Server
def adjust_types(df):
    for col in df.columns:
        if df[col].dtype == 'float64':
            df[col] = df[col].fillna(0).astype(float)
        elif df[col].dtype == 'int64':
            df[col] = df[col].fillna(0).astype(int)
        else:
            df[col] = df[col].fillna("").astype(str)
    return df

# Função para criar tabelas e importar CSV
def import_csv_to_sql(file_path, table_name, connection):
    try:
        # Ler o CSV
        df = pd.read_csv(file_path)
        df = adjust_types(df)  # Ajustar tipos de dados

        # Importar para o SQL Server
        with connection.cursor() as cursor:
            # Criar tabela, se não existir
            create_table_query = f"""
            IF NOT EXISTS (
                SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '{table_name}'
            )
            BEGIN
                CREATE TABLE {table_name} (
                    {', '.join([f'[{col}] NVARCHAR(MAX)' for col in df.columns])}
                );
            END;
            """
            cursor.execute(create_table_query)

            # Inserir os dados
            for index, row in df.iterrows():
                columns = ', '.join([f'[{col}]' for col in df.columns])
                values = ', '.join([f'?' for _ in df.columns])
                insert_query = f"INSERT INTO {table_name} ({columns}) VALUES ({values})"
                cursor.execute(insert_query, tuple(row))

            connection.commit()
            print(f"Dados importados com sucesso para a tabela: {table_name}")
    except Exception as e:
        print(f"Erro ao importar arquivo {file_path} para a tabela {table_name}:", e)

# Percorrer as pastas e arquivos
for root, dirs, files in os.walk(base_path):
    # Excluir pastas "merge"
    dirs[:] = [d for d in dirs if d.lower() != 'merge']

    for file in files:
        if file.endswith('.csv'):
            file_path = os.path.join(root, file)
            table_name = os.path.splitext(file)[0].replace(" ", "_")  # Ajuste no nome da tabela
            import_csv_to_sql(file_path, table_name, conn)

# Fechar conexão
conn.close()
print("Processo concluído.")
