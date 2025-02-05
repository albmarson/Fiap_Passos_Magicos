USE FIAP 

SELECT Count(*) Quant
FROM   [dbo].[tbaluno]; -- Quantidade de Alunos

SELECT Count(DISTINCT IdAluno) Quant
FROM   [dbo].[tbaluno]; -- Quantidade de Alunos �nicos

SELECT Count(*) Quant,
       Sexo
FROM   [dbo].[tbaluno]
GROUP  BY Sexo; -- Quatidade de Alunos por Sexo 

SELECT Count(*) Quant,
       TipoResponsavel
FROM   [dbo].[tbaluno]
       LEFT JOIN [dbo].[tbtiporesponsavel]
              ON [tbaluno].idtiporesponsavel =
                 [tbtiporesponsavel].idtiporesponsavel
GROUP  BY TipoResponsavel; -- Quantidade de Alunos por Respons�vel 

UPDATE [dbo].[tbtiporesponsavel]
SET    tiporesponsavel = 'M�e'
WHERE  idtiporesponsavel = 13; -- Ajustando o valor da coluna para uma melhor padroniza��o

SELECT Count(*) Quant
FROM   [dbo].[tbalunoturma]; -- 9.157 registros 

SELECT Count(DISTINCT IdAluno) Quant
FROM   [dbo].[tbalunoturma]; -- 2.163 registros de alunos �nicos

DROP TABLE IF EXISTS #UltimaTurma -- Capturando a �ltima turma dos alunos
SELECT     row_number() OVER (partition BY [tbalunoturma].idaluno ORDER BY [tbperiodo].idperiodo DESC) Ordem,
           [tbalunoturma].idaluno,
           [tbperiodo].*
INTO       #UltimaTurma
FROM       [dbo].[tbalunoturma]
LEFT JOIN  [dbo].[tbturma]
ON         [tbalunoturma].idturma = [tbturma].idturma
INNER JOIN [dbo].[tbperiodo]
ON         [tbturma].idperiodo = [tbperiodo].idperiodo;

DELETE FROM #UltimaTurma
WHERE ORDEM > 1; 

DROP TABLE IF EXISTS [dbo].[AlunoUltimaTurma]
SELECT *
INTO   [dbo].[AlunoUltimaTurma]
FROM   #ultimaturma;

SELECT Count(*) Quant,
       NomePeriodo
FROM   [dbo].[AlunoUltimaTurma]
GROUP  BY NomePeriodo
ORDER  BY NomePeriodo ASC; 

SELECT column_name
FROM   information_schema.columns
WHERE  table_name = 'tbaluno'
       AND table_schema = 'dbo'; -- Query para capturar o nome das colunas da tabela [dbo].[tbaluno]

SELECT Count(*) Quant,
       stdeficienciacegueira
FROM   [dbo].[tbaluno]
GROUP  BY stdeficienciacegueira;

SELECT Count(*) Quant,
       stdeficienciabaixavisao
FROM   [dbo].[tbaluno]
GROUP  BY stdeficienciabaixavisao;

SELECT Count(*) Quant,
       stdeficienciasurdez
FROM   [dbo].[tbaluno]
GROUP  BY stdeficienciasurdez;

SELECT Count(*) Quant,
       stdeficienciaauditiva
FROM   [dbo].[tbaluno]
GROUP  BY stdeficienciaauditiva;

SELECT Count(*) Quant,
       stdeficienciafisica
FROM   [dbo].[tbaluno]
GROUP  BY stdeficienciafisica;

SELECT Count(*) Quant,
       stdeficienciasurdocegueira
FROM   [dbo].[tbaluno]
GROUP  BY stdeficienciasurdocegueira;

SELECT Count(*) Quant,
       stdeficienciamultipla
FROM   [dbo].[tbaluno]
GROUP  BY stdeficienciamultipla;

SELECT Count(*) Quant,
       stdeficienciamental
FROM   [dbo].[tbaluno]
GROUP  BY stdeficienciamental;

SELECT Count(*) Quant,
       stdeficienciaautismoinfantil
FROM   [dbo].[tbaluno]
GROUP  BY stdeficienciaautismoinfantil;

SELECT Count(*) Quant,
       stdeficienciasindromeasperger
FROM   [dbo].[tbaluno]
GROUP  BY stdeficienciasindromeasperger;

SELECT Count(*) Quant,
       stdeficienciasindromerett
FROM   [dbo].[tbaluno]
GROUP  BY stdeficienciasindromerett;

SELECT Count(*) Quant,
       stdeficienciatrastornodesintegrativo
FROM   [dbo].[tbaluno]
GROUP  BY stdeficienciatrastornodesintegrativo;

SELECT Count(*) Quant,
       stdeficienciaaltashabilidades
FROM   [dbo].[tbaluno]
GROUP  BY stdeficienciaaltashabilidades; 

select count(*) Quant, 
	   CorRaca
from   [dbo].[tbaluno]
group by CorRaca;

select count(*) Quant, 
	   PlanoSaude
from   [dbo].[tbaluno]
group by PlanoSaude;

SELECT Count(*) Quant,
       strecursoauxilioledor
FROM   [dbo].[tbaluno]
GROUP  BY strecursoauxilioledor;

SELECT Count(*) Quant,
       strecursoauxiliotranscricao
FROM   [dbo].[tbaluno]
GROUP  BY strecursoauxiliotranscricao;

SELECT Count(*) Quant,
       strecursoguiainterprete
FROM   [dbo].[tbaluno]
GROUP  BY strecursoguiainterprete;

SELECT Count(*) Quant,
       strecursotradutorinterpretedelibras
FROM   [dbo].[tbaluno]
GROUP  BY strecursotradutorinterpretedelibras;

SELECT Count(*) Quant,
       strecursoleituralabial
FROM   [dbo].[tbaluno]
GROUP  BY strecursoleituralabial;

SELECT Count(*) Quant,
       strecursomaterialdidaticoprovabraille
FROM   [dbo].[tbaluno]
GROUP  BY strecursomaterialdidaticoprovabraille;

SELECT Count(*) Quant,
       strecursoprovaampliada
FROM   [dbo].[tbaluno]
GROUP  BY strecursoprovaampliada;

SELECT Count(*) Quant,
       strecursoprovasuperampliada
FROM   [dbo].[tbaluno]
GROUP  BY strecursoprovasuperampliada;

SELECT Count(*) Quant,
       strecursocdcomaudio
FROM   [dbo].[tbaluno]
GROUP  BY strecursocdcomaudio;

SELECT Count(*) Quant,
       strecursolinguaportuguesasegundalingua
FROM   [dbo].[tbaluno]
GROUP  BY strecursolinguaportuguesasegundalingua;

SELECT Count(*) Quant,
       strecursoprovaemvideo
FROM   [dbo].[tbaluno]
GROUP  BY strecursoprovaemvideo;

SELECT DISTINCT CorRaca
FROM   [dbo].[tbaluno]; 

SELECT DISTINCT stpresencafalta
FROM   [dbo].[tbdiariofrequencia]; 

DROP TABLE IF EXISTS dbo.FrequenciaAlunos
SELECT 
    COUNT(*) AS Quant, 
    IDAluno,  
    CASE	
        WHEN stpresencafalta = 'F' THEN 'Falta'
        WHEN stpresencafalta = 'P' THEN 'Presente'
        WHEN stpresencafalta = 'J' THEN 'Falta Justificada'
    END AS StatusPresenca
INTO dbo.FrequenciaAlunos
FROM [dbo].[tbdiariofrequencia]
GROUP BY 
    IDAluno, 
    CASE	
        WHEN stpresencafalta = 'F' THEN 'Falta'
        WHEN stpresencafalta = 'P' THEN 'Presente'
        WHEN stpresencafalta = 'J' THEN 'Falta Justificada'
    END;

DROP TABLE IF EXISTS dbo.FrequenciaDisciplina
SELECT Count (*)                     Quant,
       [tbdisciplina].nomedisciplina AS Disciplica,
       CASE
         WHEN stpresencafalta = 'F' THEN 'Falta'
         WHEN stpresencafalta = 'P' THEN 'Presente'
         WHEN stpresencafalta = 'J' THEN 'Falta Justificada'
       END                           AS StatusPresenca
INTO dbo.FrequenciaDisciplina 
FROM   [dbo].[tbdiarioaula]
       INNER JOIN [dbo].[tbdiario]
               ON [tbdiarioaula].iddiario = [tbdiario].iddiario
       INNER JOIN [dbo].[tbdisciplina]
               ON [tbdiario].iddisciplina = [tbdisciplina].iddisciplina
       INNER JOIN [dbo].[tbdiariofrequencia]
               ON [tbdiarioaula].iddiarioaula =
                  [tbdiariofrequencia].iddiarioaula
GROUP  BY [tbdisciplina].nomedisciplina,
          CASE
            WHEN stpresencafalta = 'F' THEN 'Falta'
            WHEN stpresencafalta = 'P' THEN 'Presente'
            WHEN stpresencafalta = 'J' THEN 'Falta Justificada'
          END; 

DROP TABLE IF EXISTS dbo.FrequenciaAnoDisciplina
SELECT Count (*)                     Quant,
       [tbdisciplina].nomedisciplina AS Disciplica,
       CASE
         WHEN stpresencafalta = 'F' THEN 'Falta'
         WHEN stpresencafalta = 'P' THEN 'Presente'
         WHEN stpresencafalta = 'J' THEN 'Falta Justificada'
       END                           AS StatusPresenca,
	   YEAR(DataAula) Ano
INTO dbo.FrequenciaAnoDisciplina 
FROM   [dbo].[tbdiarioaula]
       INNER JOIN [dbo].[tbdiario]
               ON [tbdiarioaula].iddiario = [tbdiario].iddiario
       INNER JOIN [dbo].[tbdisciplina]
               ON [tbdiario].iddisciplina = [tbdisciplina].iddisciplina
       INNER JOIN [dbo].[tbdiariofrequencia]
               ON [tbdiarioaula].iddiarioaula =
                  [tbdiariofrequencia].iddiarioaula
GROUP  BY [tbdisciplina].nomedisciplina,
          CASE
            WHEN stpresencafalta = 'F' THEN 'Falta'
            WHEN stpresencafalta = 'P' THEN 'Presente'
            WHEN stpresencafalta = 'J' THEN 'Falta Justificada'
          END,
		  YEAR(DataAula); 

DROP TABLE IF EXISTS [dbo].[ProfessorDisciplinas]
SELECT     [TbProfessor].NomeProfessor,
           DataNascimento,
           DataAdmissao,
           NomeDisciplina AS disciplina
INTO       [dbo].[ProfessorDisciplinas]
FROM       [dbo].[TbProfessor]
INNER JOIN [dbo].[TbProfessorDisciplina]
ON         [TbProfessor].idprofessor = [TbProfessorDisciplina].idprofessor
INNER JOIN [dbo].[TbDisciplina]
ON         [TbProfessorDisciplina].iddisciplina = [TbDisciplina].iddisciplina
WHERE      stativo = 'True';

SELECT Count(*) Quant,
       nomeprofessor
FROM   [dbo].[professordisciplinas]
GROUP  BY nomeprofessor
HAVING Count(*) > 1 
ORDER BY 1 DESC;