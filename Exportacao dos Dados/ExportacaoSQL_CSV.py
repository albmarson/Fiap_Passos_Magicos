import pyodbc
import pandas as pd

server = 'localhost'  
database = 'FIAP'     
output_folder = r'C:\Users\Alberto Marson\Desktop\Fase 5\Dados do Relatorio'  

tables = [
    'TbAluno',
    'AlunoUltimaTurma'
]

try:
    
    conn = pyodbc.connect(
        f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes;'
    )
    print("Conexão estabelecida com sucesso!")

    for table in tables:
        query = f"SELECT * FROM [dbo].[{table}]"
        print(f"Exportando dados da tabela: {table}")
        
        df = pd.read_sql(query, conn)

        output_path = f"{output_folder}\\{table}.csv"

        df.to_csv(output_path, index=False, sep=',', encoding='utf-8')
        print(f"Dados exportados com sucesso para: {output_path}")

except Exception as e:
    print(f"Erro: {e}")

finally:
   
    conn.close()
    print("Conexão fechada.")
