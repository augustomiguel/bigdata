-- 1

--A;
INSERT INTO EMPREGADO (ssn, pnome, inicialm, unome, sexo, endereco, datanasc, superssn, dno, salario)
VALUES ('943775543', 'Roberto', 'F', 'Silva', 'M', 'Rua X, 22 – Araucária – PR', '1952-06-21', '888665555', '1', 58000.00);

--B;
INSERT INTO PROJETO (pnumero, pjnome, plocal, dnum)
VALUES ('4', 'ProdutoA', 'Araucaria', '2');

--C;
INSERT INTO DEPARTAMENTO (dnumero, dnome, gerssn, gerdatainicio)
VALUES ('4', 'Produção', '943775543', '1998-10-01');

--D 
INSERT INTO TRABALHA (essn, pno, horas)
VALUES ('677678989', null, 40.0);

--E
INSERT INTO DEPENDENTE (essn, nomedep, sexodep, datanascdep, parentesco)
VALUES ('453453453', 'Joao', 'M', '1970-12-12', 'CONJUGE');

--F
DELETE FROM TRABALHA
WHERE essn = '333445555';
--G
DELETE FROM TRABALHA
WHERE essn = '333445555';
--H 
DELETE FROM PROJETO
WHERE pjnome = 'ProdutoX';
--I
UPDATE DEPARTAMENTO
SET gerssn = '123456789', gerdatainicio = '1999-01-10'
WHERE dnumero = '5';
--J 
UPDATE EMPREGADO
SET superssn = '943775543'
WHERE ssn = '999887777';
--K
UPDATE TRABALHA
SET horas = 5.0
WHERE essn = '999887777' AND pno = '10';