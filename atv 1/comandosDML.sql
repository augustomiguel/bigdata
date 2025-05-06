
--2  escreva o comando DML adequado que:


-- A )  Mostre o número de segurança social do empregado, o nome do dependente e o
-- parentesco, ordenado por ssn ascendente e parentesco descendente.
SELECT essn AS ssn, nomedep, parentesco
FROM DEPENDENTE
ORDER BY essn ASC, parentesco DESC;

-- B) Mostre o nome e endereço de todos os empregados que trabalham para 
-- o departamento Pesquisa.
SELECT e.pnome, e.unome, e.endereco
FROM EMPREGADO e
JOIN DEPARTAMENTO d ON e.dno = d.dnumero
WHERE d.dnome = 'Pesquisa';

-- c) Para todo projeto localizado em Araucaria, liste o nome do projeto, o nome do departamento
-- de controle e o último nome, endereço e data de nascimento do gerente do departamento.
SELECT 
    p.pjnome AS nome_projeto, 
    d.dnome AS nome_departamento, 
    e.unome AS ultimo_nome_gerente, 
    e.endereco AS endereco_gerente, 
    e.datanasc AS data_nascimento_gerente
FROM 
    PROJETO p
JOIN 
    DEPARTAMENTO d ON p.dnum = d.dnumero
JOIN 
    EMPREGADO e ON d.gerssn = e.ssn
WHERE 
    p.plocal = 'Araucaria';

-- D) Recupere os nomes de todos os empregados que trabalhem mais de 10 horas por semana
-- no projeto Automatizacao.
SELECT 
    e.pnome, e.unome
FROM 
    EMPREGADO e
JOIN 
    TRABALHA t ON e.ssn = t.essn
JOIN 
    PROJETO p ON t.pno = p.pnumero
WHERE 
    p.pjnome = 'Automatizacao' AND t.horas > 10;

-- E) Mostre o nome dos empregados que têm os três maiores salários.
SELECT pnome, inicialm, unome
FROM EMPREGADO
ORDER BY salario DESC
LIMIT 3;

-- F) Mostre o nome e o salário dos supervisores com aumento de 20%.
SELECT e.pnome, e.unome, e.salario * 1.20 AS novo_salario
FROM EMPREGADO e
JOIN DEPARTAMENTO d ON e.ssn = d.gerssn; 

-- G) Mostre os departamentos e suas localidades.
SELECT d.dnome AS nome_departamento, l.dlocalizacao AS localizacao
FROM DEPARTAMENTO d
JOIN LOCALIZACAO l ON d.dnumero = l.dnum;

-- H) Mostre os departamentos e seus projetos.
SELECT d.dnome AS nome_departamento, p.pjnome AS nome_projeto
FROM DEPARTAMENTO d
JOIN PROJETO p ON d.dnumero = p.dnum;

-- I) Mostre os empregados do sexo feminino e a data de nascimento cujo salário é maior que 30.000.
SELECT pnome, inicialm, unome, datanasc
FROM EMPREGADO
WHERE sexo = 'F' AND salario > 30000;

-- J) Mostre os projetos em que o empregado 'Fábio' trabalha.
SELECT p.pjnome AS nome_projeto
FROM PROJETO p
JOIN TRABALHA t ON p.pnumero = t.pno
JOIN EMPREGADO e ON t.essn = e.ssn
WHERE e.pnome = 'Fabio';

--3) Joins: Dadas as tabelas A e B e seus registros (abaixo):
-- 3 registros para a empresa 1 (que existe na tabela A);
SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
INNER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
LEFT OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
RIGHT OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
FULL OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;


-- 2 registros para a empresa 2 (que existe na tabela A);
SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
INNER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
LEFT OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
RIGHT OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
FULL OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;


-- 1 registros para a empresa 3 (que existe na tabela A);
SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
INNER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
LEFT OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
RIGHT OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
FULL OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

-- 0 registros para a empresa 4 (que existe na tabela A);
SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
INNER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
LEFT OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
RIGHT OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
FULL OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;
-- 1 registros para a empresa 5 (que existe na tabela A);

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
INNER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
LEFT OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
RIGHT OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
FULL OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

-- 1 registros para a empresa 8 (que NÃO existe na tabela A)
SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
INNER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
LEFT OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
RIGHT OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;

SELECT A.CODIGO, A.NOME, B.ID, B.VALOR
FROM TABELA_A A
FULL OUTER JOIN TABELA_B B ON A.CODIGO = B.CODIGO;











--  4) Operações CRUD (Complementar) Suponha que cada uma das seguintes operações de atualização seja aplicada 
-- diretamente ao estado do banco de dados "empresa”, apresentado na Atividade 1. Escreva o comando DML adequado que:

-- a) Encontre todos os empregados cujo supervisor esteja alocado em um departamento
-- diferente. Mostre o número de segurança social e o nome completo do empregado.
SELECT e.ssn, e.pnome, e.inicialm, e.unome
FROM EMPREGADO e
JOIN EMPREGADO s ON e.superssn = s.ssn  
WHERE e.dno <> s.dno;  -- Filtra os empregados cujo departamento é diferente do departamento do supervisor

-- b) Mostre o número de segurança social do empregado, o nome do dependente o e
-- parentesco, ordenado por ssn ascendente e parentesco descendente.
SELECT e.ssn, d.nomedep, d.parentesco
FROM EMPREGADO e
JOIN DEPENDENTE d ON e.ssn = d.essn
ORDER BY e.ssn ASC, d.parentesco DESC;

-- c) Encontre os nomes de todos os empregados que são diretamente supervisionados por “Joaquim E Brito”.
SELECT e.pnome, e.inicialm, e.unome
FROM EMPREGADO e
JOIN EMPREGADO s ON e.superssn = s.ssn
WHERE s.pnome = 'Joaquim' AND s.unome = 'Brito';

-- d) Faça uma lista dos números e nomes de projetos que envolvam um empregado cujo último
-- nome seja ‘Will’, mesmo que esse trabalhador seja o gerente do departamento que controla o
-- projeto.
SELECT p.pnumero, p.pjnome
FROM PROJETO p
JOIN TRABALHA t ON p.pnumero = t.pno
JOIN EMPREGADO e ON t.essn = e.ssn
WHERE e.unome = 'Will'
   OR p.dnum IN (SELECT dnumero FROM DEPARTAMENTO WHERE gerssn IN (SELECT ssn FROM EMPREGADO WHERE unome = 'Will'));

-- e) Encontre o nome dos empregados que trabalham em algum dos projetos controlados pelo
--departamento número 5.
SELECT DISTINCT e.pnome, e.inicialm, e.unome
FROM EMPREGADO e
JOIN TRABALHA t ON e.ssn = t.essn
JOIN PROJETO p ON t.pno = p.pnumero
WHERE p.dnum::integer = 5;

-- f) Encontre o nome e o endereço de todos os empregados que trabalhem em pelo menos um
-- projeto localizado em ‘Curitiba’, mas cujo departamento não se localiza em ‘Curitiba’.

SELECT DISTINCT e.pnome, e.unome, e.endereco
FROM EMPREGADO e
JOIN TRABALHA t ON e.ssn = t.essn
JOIN PROJETO p ON t.pno = p.pnumero
JOIN DEPARTAMENTO d ON e.dno = d.dnumero
JOIN LOCALIZACAO l ON d.dnumero = l.dnum
WHERE p.plocal = 'Curitiba'
  AND l.dlocalizacao <> 'Curitiba';
 
