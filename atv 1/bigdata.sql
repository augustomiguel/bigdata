
-- 5) Funções agregadas e nativas - Utilize funções agregadas e/ou nativas
-- SQL para responder as seguintes questes:

-- a) Recupere a média salarial de todos os empregados do sexo feminino.
SELECT AVG(salario) AS media_salarial
FROM EMPREGADO
WHERE sexo = 'F';

-- b) Mostre o número de empregados por supervisor.
SELECT s.pnome AS nome_supervisor, COUNT(*) AS numero_empregados
FROM EMPREGADO e
JOIN EMPREGADO s ON e.superssn = s.ssn
GROUP BY s.pnome
ORDER BY numero_empregados DESC;

-- c) Mostre o maior número de horas envolvido em projetos.
SELECT MAX(horas) AS maior_numero_horas
FROM TRABALHA;

-- d) Para cada projeto, liste o nome do projeto e o total de horas por semana (de todos os
-- empregados) gastas no projeto.
SELECT p.pjnome AS nome_projeto, SUM(t.horas) AS total_horas_semana
FROM PROJETO p
JOIN TRABALHA t ON p.pnumero = t.pno
GROUP BY p.pjnome;

-- e) Para cada departamento, recupere o nome do departamento e a média salarial de todos os
-- empregados que trabalham nesse departamento.
SELECT d.dnome AS nome_departamento, AVG(e.salario) AS media_salarial
FROM DEPARTAMENTO d
JOIN EMPREGADO e ON d.dnumero = e.dno
GROUP BY d.dnome;

-- f) Liste os nomes de todos os empregados com dois ou mais dependentes.
SELECT e.pnome, e.inicialm, e.unome
FROM EMPREGADO e
JOIN DEPENDENTE d ON e.ssn = d.essn
GROUP BY e.ssn, e.pnome, e.inicialm, e.unome
HAVING COUNT(*) >= 2;

-- g) Mostre o nome do departamento que possui o menor número de projetos associados.
SELECT d.dnome AS nome_departamento
FROM DEPARTAMENTO d
LEFT JOIN PROJETO p ON d.dnumero = p.dnum
GROUP BY d.dnome
ORDER BY COUNT(p.pnumero) ASC
LIMIT 1;

-- h) Escreva uma consulta que retorne do 10o ao 22o caractere do endereço do empregado.
SELECT SUBSTRING(endereco, 10, 13) AS trecho_endereco
FROM EMPREGADO;

-- i) Escreva uma consulta que retorne apenas o mês de nascimento de cada funcionário.
SELECT EXTRACT(MONTH FROM datanasc) AS mes_nascimento
FROM EMPREGADO;

-- j) Escreva uma consulta que retorne a idade (em anos) que o empregado tinha quando o
-- dependente de parentesco filhou ou filha nasceu.
SELECT 
    e.pnome, 
    e.unome, 
    d.nomedep, 
    d.parentesco,
    DATE_PART('year', AGE(d.datanascdep, e.datanasc)) AS idade_empregado
FROM 
    EMPREGADO e
JOIN 
    DEPENDENTE d ON e.ssn = d.essn
WHERE 
    d.parentesco IN ('FILHO', 'FILHA'); 

-- k) Escreva uma consulte que conte o número de dependentes por ano de nascimento.
SELECT EXTRACT(YEAR FROM datanascdep) AS ano_nascimento, COUNT(*) AS numero_dependentes
FROM DEPENDENTE
GROUP BY ano_nascimento
ORDER BY ano_nascimento;

-- l) Escreva uma consulte que mostre o nome de empregados supervisor que tenham 2 ou mais supervisionados.
SELECT s.pnome, s.unome
FROM EMPREGADO e
JOIN EMPREGADO s ON e.superssn = s.ssn
GROUP BY s.ssn, s.pnome, s.unome
HAVING COUNT(*) >= 2;

-- m) Escreva uma consulta que mostre o valor mensal a ser pago por projeto (considere que a
-- coluna ‘salário’ de empregado é mensal).
SELECT p.pjnome AS nome_projeto, SUM(e.salario) AS valor_mensal_projeto
FROM EMPREGADO e
JOIN TRABALHA t ON e.ssn = t.essn
JOIN PROJETO p ON t.pno = p.pnumero
GROUP BY p.pjnome;



-- 6) – Subconsultas - Escreva subconsultas SQL para as questes:

-- a) Recupere nome (pnome e unome) de cada um dos empregados que tenham um dependente
-- cujo primeiro nome e sexo sejam o mesmo do empregado em questão.
SELECT DISTINCT e.pnome, e.unome
FROM EMPREGADO e
JOIN DEPENDENTE d ON e.ssn = d.essn
WHERE e.pnome = d.nomedep
  AND e.sexo = d.sexodep;

-- b) Recupere os nomes dos empregados (pnome e unome) cujos salrios so maiores que a 
-- media dos salrios dos empregados do departamento 5.

SELECT e.pnome, e.unome
FROM EMPREGADO e
WHERE e.salario > (
    SELECT AVG(salario)
    FROM EMPREGADO
    WHERE dno = '5'
);

-- c) Retorne o nmero do seguro social (SSN) de todos os empregado que trabalham com a mesma 
-- combinao (projeto, horas) em algum dos projetos em que o empregado ‘Fabio Will’ (SSN= 333445555) trabalhe.
SELECT DISTINCT e.ssn
FROM EMPREGADO e
JOIN TRABALHA t ON e.ssn = t.essn
WHERE (t.pno, t.horas) IN (
    SELECT t2.pno, t2.horas
    FROM TRABALHA t2
    WHERE t2.essn = '333445555' -- SSN do 'Fabio Will'
)
AND e.ssn <> '333445555'; -- Exclui o próprio 'Fabio Will'

-- d) Recupere os nomes de todos os empregados que no trabalham em nenhum projeto.
SELECT pnome, unome
FROM EMPREGADO
WHERE ssn NOT IN (SELECT essn FROM TRABALHA);

-- e) Recupere o nome de empregados que no tenham dependentes.
SELECT pnome, unome
FROM EMPREGADO
WHERE ssn NOT IN (SELECT essn FROM DEPENDENTE);

-- f) Liste o ultimo nome de todos os gerentes de departamento que no tenham dependentes.
SELECT e.unome
FROM EMPREGADO e
JOIN DEPARTAMENTO d ON e.ssn = d.gerssn
WHERE e.ssn NOT IN (SELECT essn FROM DEPENDENTE);

-- g) Liste os nomes dos gerentes que tenham, pelo menos, um dependente
SELECT DISTINCT e.pnome, e.unome
FROM EMPREGADO e
JOIN DEPARTAMENTO d ON e.ssn = d.gerssn
WHERE EXISTS (
    SELECT 1
    FROM DEPENDENTE dep
    WHERE dep.essn = e.ssn
);



-- 7) Índices - Escreva comandos SQL para responder as seguintes questes:

-- a) Crie a tabela tempEmpregado contendo dos dados dos atributos ssn, pnome,sexo, endereco
-- e datanasc da tabela empregado. Realizar a copia dos dados durante o processo de criao da nova tabela.
CREATE TABLE tempEmpregado AS
SELECT ssn, pnome, sexo, endereco, datanasc
FROM empregado;

-- b) Utilize o comando EXPLAIN ANALYSE e anote o tempo de execuo da consulta SELECT *FROM TEMPEMPREGADO.
EXPLAIN ANALYZE
SELECT * FROM TEMPEMPREGADO;

-- c) Crie um indice com o campo ssn que no permite dados duplicados para a tabela
--  tempEmpregado, utilizando o algoritmo de ordenao BTREE.
CREATE UNIQUE INDEX idx_ssn_unique ON tempEmpregado (ssn);
--o tipo de índice B-tree é o padrão, portanto, você não precisa especificar USING BTREE explicitamente.

-- d) Crie um indice com o campo pnome para a tabela tempEmpregado, em ordem decrescente
-- e que utilize o algoritmo de ordenao HASH.
CREATE INDEX idx_pnome_hash ON tempEmpregado USING HASH (pnome);

-- e) Utilize o comando EXPLAIN ANALYSE, anote e compare com o tempo de execuo da
-- consulta SELECT * FROM TEMPEMPREGADO. O que achou do resultado?
EXPLAIN ANALYZE SELECT * FROM tempEmpregado;

-- f) Remova os indices criados nos itens c e d.
--Remova os indices criados nos itens o campo ssn que no permite dados duplicados para a tabela tempEmpregado, e indice com o campo pnome para a tabela tempEmpregado

DROP INDEX idx_ssn ON tempEmpregado;
DROP INDEX idx_pnome ON tempEmpregado;

-- g) Remova a tabela temporria criada no item a.
DROP TABLE tempEmpregado;




-- 8) Visões - Escreva comandos SQL para responder as seguintes questes

    -- a) Crie a viso chamada TRABALHA_EM que dever conter os campos pnome e unome da
    -- tabela empregado, o campo pjnome da tabela projeto e o campo horas da tabela trabalha
CREATE VIEW TRABALHA_EM AS
SELECT e.pnome, e.unome, p.pjnome, t.horas
FROM empregado e
JOIN trabalha t ON e.ssn = t.essn
JOIN projeto p ON t.pno = p.pnumero;

-- b) Crie uma consulta SQL na viso implementada no item a que retorne o ltimo e o primeiro
-- nome de todos os empregados que trabalham no ‘ProdutoX’.
SELECT unome, pnome
FROM TRABALHA_EM
WHERE pjnome = 'ProdutoX';

-- c) Exclua a visão criada no item a.
DROP VIEW TRABALHA_EM;

-- d) Crie uma visão chamada DEPTO_INFO que deverá conter os campos dnome da tabela
-- departamento, e o total de empregados e somatório dos salários dos empregados da tabela
-- empregado por departamento
CREATE VIEW DEPTO_INFO AS
SELECT d.dnome, 
       COUNT(e.ssn) AS total_empregados, 
       SUM(e.salario) AS soma_salarios
FROM departamento d
LEFT JOIN empregado e ON d.dnumero = e.dno
GROUP BY d.dnome;


-- e) Crie uma consulta SQL na visão implementada no item c que retorne a lista de informações
-- por departamentos ordenados pelo somatório dos salários.
SELECT *
FROM DEPTO_INFO
ORDER BY soma_salarios DESC;

-- f) Exclua as visões criadas nos itens a.
DROP VIEW DEPTO_INFO;

