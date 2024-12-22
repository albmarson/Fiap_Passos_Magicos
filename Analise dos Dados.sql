USE FIAP 

SELECT Count(*) Quant
FROM   [dbo].[tbaluno]; -- Quantidade de Alunos

SELECT Count(DISTINCT IdAluno) Quant
FROM   [dbo].[tbaluno]; -- Quantidade de Alunos Únicos

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
GROUP  BY TipoResponsavel; -- Quantidade de Alunos por Responsável 

UPDATE [dbo].[tbtiporesponsavel]
SET    tiporesponsavel = 'Mãe'
WHERE  idtiporesponsavel = 13; -- Ajustando o valor da coluna para uma melhor padronização

SELECT Count(*) Quant
FROM   [dbo].[tbalunoturma]; -- 9.157 registros 

SELECT Count(DISTINCT IdAluno) Quant
FROM   [dbo].[tbalunoturma]; -- 2.163 registros de alunos únicos

DROP TABLE IF EXISTS #UltimaTurma -- Capturando a última turma dos alunos
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
group by CorRaca

select count(*) Quant, 
	   PlanoSaude
from   [dbo].[tbaluno]
group by PlanoSaude

SELECT Count(*) Quant,
       strecursoauxilioledor
FROM   [dbo].[tbaluno]
GROUP  BY strecursoauxilioledor

SELECT Count(*) Quant,
       strecursoauxiliotranscricao
FROM   [dbo].[tbaluno]
GROUP  BY strecursoauxiliotranscricao

SELECT Count(*) Quant,
       strecursoguiainterprete
FROM   [dbo].[tbaluno]
GROUP  BY strecursoguiainterprete

SELECT Count(*) Quant,
       strecursotradutorinterpretedelibras
FROM   [dbo].[tbaluno]
GROUP  BY strecursotradutorinterpretedelibras

SELECT Count(*) Quant,
       strecursoleituralabial
FROM   [dbo].[tbaluno]
GROUP  BY strecursoleituralabial

SELECT Count(*) Quant,
       strecursomaterialdidaticoprovabraille
FROM   [dbo].[tbaluno]
GROUP  BY strecursomaterialdidaticoprovabraille

SELECT Count(*) Quant,
       strecursoprovaampliada
FROM   [dbo].[tbaluno]
GROUP  BY strecursoprovaampliada

SELECT Count(*) Quant,
       strecursoprovasuperampliada
FROM   [dbo].[tbaluno]
GROUP  BY strecursoprovasuperampliada

SELECT Count(*) Quant,
       strecursocdcomaudio
FROM   [dbo].[tbaluno]
GROUP  BY strecursocdcomaudio

SELECT Count(*) Quant,
       strecursolinguaportuguesasegundalingua
FROM   [dbo].[tbaluno]
GROUP  BY strecursolinguaportuguesasegundalingua

SELECT Count(*) Quant,
       strecursoprovaemvideo
FROM   [dbo].[tbaluno]
GROUP  BY strecursoprovaemvideo

