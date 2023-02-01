--Exercicios da livro T-SQL 2012 CAP 2
-----------------------------------------------------------------------------------------------------------------------------
1--Escreva uma consulta na tabela Sales.Orders que retorne pedidos feitos em junho de 2007.
-----------------------------------------------------------------------------------------------------------------------------
select * from Sales.SalesOrderHeader
where Year(OrderDate)= '2011' and month(OrderDate)='06';


2-- Escreva uma consulta na tabela Sales.Orders que retorne pedidos feitos no último dia do mês.

-- ■ Tabelas envolvidas: banco de dados TSQL2012 e tabela Sales.Orders
-- ■ Saída desejada (abreviada):
-----------------------------------------------------------------------------------------------------------------------------
select * from Sales.SalesOrderHeader
where '31'=day(OrderDate) or '30'=day(OrderDate) or '28' =day(OrderDate);
-----------------------------------------------------------------------------------------------------------------------------

3-- Escreva uma consulta na tabela HR.Employees que retorne funcionários com sobrenome contendo o
-- letra a duas vezes ou mais.

-- ■ Tabelas envolvidas: banco de dados TSQL2012 e tabela HR.Employees
-- ■ Saída desejada:
-----------------------------------------------------------------------------------------------------------------------------
SELECT * from Person.Person
where LastName like '%a%a%';
-----------------------------------------------------------------------------------------------------------------------------

--4-- Escreva uma consulta na tabela Sales.Order Details que retorna pedidos com valor total (quantidade * preço unitário) maior que 10.000, 
-- classificados por valor total.
-----------------------------------------------------------------------------------------------------------------------------

select * from Sales.SalesOrderDetail
where UnitPrice*OrderQty>=10.000;


SELECT SalesOrderDetailID, SUM(OrderQty*unitprice) AS totalvalue
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderDetailID
HAVING SUM(OrderQty*unitprice) > 10000
ORDER BY totalvalue DESC;

-----------------------------------------------------------------------------------------------------------------------------
--Escreva uma consulta na tabela Sales.Orders que retorne os três países de destino com frete médio mais alto em 2007.
-----------------------------------------------------------------------------------------------------------------------------
select * from Sales.SalesOrderDetail
select * from sales.SalesOrderHeader
SELECT * from Purchasing.PurchaseOrderDetail


-----------------------------------------------------------------------------------------------------------------------------
--6--Escreva uma consulta na tabela Sales.Orders que calcule os números de linha para pedidos com base no pedido
-- pedido de data (usando o ID do pedido como desempate) para cada cliente separadamente.
-----------------------------------------------------------------------------------------------------------------------------
select ModifiedDate,count(ProductID)as cont,ProductID from Sales.SalesOrderDetail
WHERE ModifiedDate=ModifiedDate
GROUP by ModifiedDate,ProductID
--RDER by ProductID asc  ;


-----------------------------------------------------------------------------------------------------------------------------
-- 7-- Usando a tabela HR.Employees, descubra a instrução SELECT que retorna para cada funcionário o
-- gênero com base no título de cortesia. Para ‘Sra. ' e 'Sra.' retornam 'Feminino'; para 'Sr. ' retorna 'Masculino'; e
-- em todos os outros casos (por exemplo, 'Dr. ') retorne 'D
-----------------------------------------------------------------------------------------------------------------------------
select top 100 (FirstName),
case 
      when UPPER(Title) like 'MR.' then 'Masculino'
      when UPPER(Title) like 'MS%' or UPPER(Title) like 'MR%' or  UPPER(Title) like 'SR%' then 'Femino'
      else 'Desconhecido'
end 
from Person.Person

use curso
select left(id_aluno,1+cast('000'as varchar)

-----------------------------------------------------------------------------------------------------------------------------
--8- Escreva uma consulta na tabela Sales.Customers que retorne para cada cliente o ID do cliente e
-- região. Classifique as linhas na saída por região, tendo marcas NULL classificadas por último (após valores não NULL).

-----------------------------------------------------------------------------------------------------------------------------
select PersonID,TerritoryID  from Sales.Customer
order by TerritoryID asc;

use curso


-----------------------------------------------------------------------------------------------------------------------------
--1--Escreva uma consulta que gere cinco cópias de cada linha de funcionário.
--■ Tabelas envolvidas: HR.Employees e dbo.Nums
-----------------------------------------------------------------------------------------------------------------------------
use AdventureWorks2017

select he.JobTitle, ss.TerritoryID from HumanResources.Employee he
cross join  Sales.SalesTerritory ss
where ss.TerritoryID<=5


-----------------------------------------------------------------------------------------------------------------------------
--1.1-Escreva uma consulta que retorne uma linha para cada funcionário e dia no intervalo de 12 de junho de 2009 a
---16 de junho de 2009.
---■ Tabelas envolvidas: HR.Employees e dbo.Nums
---■ Saída desejada:
-----------------------------------------------------------------------------------------------------------------------------
select he.RateChangeDate,t.num, DATEADD(day, t.num -1, '20090612') from HumanResources.EmployeePayHistory he
CROSS join #tem t
where t.num <= DATEDIFF(day,'20090612','20090616')


SELECT num,
 DATEADD(day, D.num - 1, '20090612') AS dt
FROM HumanResources.EmployeePayHistory AS E
 CROSS JOIN #tem AS D
WHERE D.num <= DATEDIFF(day, '20090612', '20090616') + 1
-----------------------------------------------------------------------------------------------------------------------------

--2-Retorne clientes dos Estados Unidos e, para cada cliente, retorne o número total de pedidos e o total
---quantidades.
---Tabelas envolvidas: Sales.Customers, Sales.Orders e Sales.OrderDetails
-----------------------------------------------------------------------------------------------------------------------------

SELECT C.custid, COUNT(DISTINCT O.orderid) AS numorders, SUM(OD.qty) AS totalqty
FROM Sales.Customer AS C
 JOIN Sales.SalesOrderDetail AS O
 ON O.custid = C.custid
 JOIN Sales.OrderDetails AS OD
 ON OD.orderid = O.orderid
WHERE C.country = N'USA'
GROUP BY C.custid;


select * from Sales.Customer
select * from sales.SalesOrderDetail


-----------------------------------------------------------------------------------------------------------------------------
3---Clientes de retorno e seus pedidos, incluindo clientes que não fizeram pedidos.
--■ Tabelas envolvidas: Sales.Customers e Sales.Orders
--■ Saída desejada (abreviada):
---
-----------------------------------------------------------------------------------------------------------------------------
select * from sales.Customer sc 
LEFT OUTER JOIN sales.SalesOrderDetail ss 
on CustomerID = SalesOrderDetailID




-----------------------------------------------------------------------------------------------------------------------------
4----Return customers who placed no orders.
---■ Tables involved: Sales.Customers and Sales.Orders
---■ Desired output:

-----------------------------------------------------------------------------------------------------------------------------

select * from sales.Customer sc 
LEFT OUTER JOIN sales.SalesOrderDetail ss 
on CustomerID = SalesOrderDetailID
where PersonID is  null


-----------------------------------------------------------------------------------------------------------------------------
5--Clientes de retorno com pedidos feitos em 12 de fevereiro de 2007, juntamente com seus pedidos.
--■ Tabelas envolvidas: Sales.Customers e Sales.Orders
--■ Saída desejada:

select * from Sales.Customer sc 
 join  sales.SalesOrderDetail
on CustomerID=SalesOrderDetailID
where year(sc.ModifiedDate) BETWEEN '2013' and '2011'


-----------------------------------------------------------------------------------------------------------------------------

--6- Clientes de retorno com pedidos feitos em 12 de fevereiro de 2007, juntamente com seus pedidos. Retorne também clientes que não fizeram pedidos em 12 de fevereiro de 2007.
-- ■■ Tabelas envolvidas: Sales.Customers e Sales.Orders
-- ■■ Saída desejada (abreviada):
-----------------------------------------------------------------------------------------------------------------------------

SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
 LEFT OUTER JOIN Sales.Orders AS O
 ON O.custid = C.custid
 AND O.orderdate = '20070212';


---------------------------------------------------------------------------------------------------------------------------

-7-- Retorne todos os clientes e, para cada retorno, um valor Sim/Não, dependendo se o cliente colocou
-- despacho de 12 de fevereiro de 2007.
-- ■ Tabelas envolvidas: Sales.Customers e Sales.Orders
-- ■ Saída desejada (abreviada):
-- ---
-----------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT C.custid, C.companyname,
 CASE WHEN O.orderid IS NOT NULL THEN 'Yes' ELSE 'No' END AS [HasOrderOn20070212]
FROM Sales.Customers AS C
 LEFT OUTER JOIN Sales.Orders AS O
 ON O.custid = C.custid
 AND O.orderdate = '20070212';





---- SUBQUERY 
--EXEMPLO DE UM SUBCONSULTA ESCALAR QUE RETORNA Único valor.


 select * from matricula

declare @nome as VARCHAR=(select max(id_aluno) from matricula);

select * from matricula 
where id_aluno=@nome;
-----------------------------------------------------------------------------------------------------------------------------



select * from jogos
where IdJogo = (select max(Idjogo) from jogos);


--EXEMPLO DE ERRO DE SUBCONSULTA ESCALAR QUE TEM MAIS DE UM VALOR  
select SalesOrderID from Sales.SalesOrderDetail
where SalesOrderDetailID=(select he.BusinessEntityID from HumanResources.Employee as he where he.JobTitle like 'C%' );

-----------------------------------------------------------------------------------------------------------------------------


-- Exemplos de Subconsulta de Valores Múltiplos Autocontidos
-- Uma subconsulta de vários valores é uma subconsulta que retorna vários valores como uma única coluna, independentemente
-- se a subconsulta é autocontida. Alguns predicados, como o predicado IN, operam em uma subconsulta de vários valores.
-----------------------------------------------------------------------------------------------------------------------------

select SalesOrderID  from Sales.SalesOrderDetail
where SalesOrderDetailID in (select hd.DepartmentID from HumanResources.Department as hd where hd.Name like 'E%');

select * from HumanResources.Department;


-----------------------------------------------------------------------------------------------------------------------------

--1-1 Escreva uma consulta que retorne todos os pedidos feitos no último dia de atividade que podem ser encontrados no
-- Tabela de pedidos.
-- ■ Tabelas envolvidas: Sales.Orders
-- ■ Saída desejada:
------------------------------------------------------------------------------------------------------------------------------

SELECT SalesOrderID, OrderDate from Sales.SalesOrderHeader
where orderdate in (select max(o.OrderDate) from Sales.SalesOrderHeader as o );

SELECT SalesOrderID, OrderDate
FROM sales.SalesOrderHeader        <---Resposta do livro
WHERE orderdate =
(SELECT MAX(o.OrderDate) FROM Sales.SalesOrderHeader AS O);



-----------------------------------------------------------------------------------------------------------------------------
-- 2 (Opcional, Avançado)
-- Escreva uma consulta que retorne todos os pedidos feitos pelo(s) cliente(s) que fizeram o maior número de
-- ordens. Observe que mais de um cliente pode ter o mesmo número de pedidos.
-- ■ Tabelas envolvidas: Sales.Orders
-- ■ Saída desejada (abreviada):
------------------------------------------------------------------------------------------------------------------------------
select top(1) with TIES SalesOrderID
from Sales.SalesOrderDetail
GROUP by SalesOrderID
order by count(*) desc;






SELECT SalesOrderID, OrderQty, 
(
      select sum(b.OrderQty)
      from Sales.SalesOrderDetail as b 
      where a.salesorderid= b.salesorderid) as runqty 

from sales.SalesOrderDetail as a;

-----------------------------------------------------------------------------------------------------------------------------

--3 Escreva uma consulta que retorne funcionários que não fizeram pedidos a partir de 1º de maio de 2008.
-- ■ Tabelas envolvidas: HR.Employees e Sales.Orders
-- ■ Saída desejada:
------------------------------------------------------------------------------------------------------------------------------



select SalesOrderDetailID from sales.SalesOrderDetail  so 
where SalesOrderDetailID not in(
      select SalesOrderDetailID from Sales.Customer sc 
      where ModifiedDate='20080501'
);


select SalesOrderDetailID from sales.SalesOrderDetail  so 
where  not exists(
      select SalesOrderDetailID from Sales.Customer sc 
      where ModifiedDate='20080501'
);


------------------------------------------------------------------------------------------------------------------------------

-- 4-Escreva uma consulta que retorne países onde há clientes, mas não funcionários.
-- ■ Tabelas envolvidas: Vendas.Clientes e RH.Funcionários
-- ■ Saída desejada:
------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT TerritoryID
FROM Sales.Customer
WHERE TerritoryID NOT IN
 (SELECT E.country FROM HR.Employees AS E);

------------------------------------------------------------------------------------------------------------------------------
--5- Escreva uma consulta que retorne para cada cliente todos os pedidos feitos no último dia de atividade do cliente.
-- ■ Tabelas envolvidas: Sales.Orders
-- ■ Saída desejada:

------------------------------------------------------------------------------------------------------------------------------
select ss.SalesOrderDetailID from Sales.SalesOrderDetail ss 
where ModifiedDate = (
      select max(so.ModifiedDate) from Sales.SalesOrderDetail so
      where ss.SalesOrderDetailID=so.SalesOrderDetailID
)GROUP by ss.SalesOrderDetailID;
------------------------------------------------------------------------------------------------------------------------------
-- 6--Escreva uma consulta que retorne clientes que fizeram pedidos em 2007, mas não em 2008.
-- ■ Tabelas envolvidas: Sales.Customers e Sales.Orders
-- ■ Saída desejada:
------------------------------------------------------------------------------------------------------------------------------

select * from Sales.Customer sc 
where year(sc.ModifiedDate) =2007 and not exists 
(select * 
from Sales.SalesOrderDetail so 
where sc.CustomerID=so.ProductID 
 and year(so.ModifiedDate)=2008);

------------------------------------------------------------------------------------------------------------------------------
-- 7 (Opcional, avançado) Escreva uma consulta que retorne os clientes que solicitaram o produto 12.
--  ■ Tabelas envolvidas: Sales.Customers, Sales.Orders e Sales.Order Details
------------------------------------------------------------------------------------------------------------------------------
select * from Sales.SalesOrderDetail ss where exists (
      select * from Sales.Customer sc 
      where ss.SalesOrderDetailID=sc.AccountNumber
      and ss.ModifiedDate >= '20070101' 
      and ss.ModifiedDate<= '20080101'
);

------------------------------------------------------------------------------------------------------------------------------
-- 8 (Opcional, Avançado)
-- Escreva uma consulta que calcule uma quantidade total corrente para cada cliente e mês.
-- ■ Tabelas envolvidas: Pedidos de clientes de vendas
-- ■ Saída desejada:
-- Detalhes do pedido de vendas
------------------------------------------------------------------------------------------------------------------------------

select pp.PurchaseOrderID,(
      select sum(ppp.OrderQty), MONTH(ppp.DueDate) from Purchasing.PurchaseOrderDetail ppp
      where pp.PurchaseOrderID=ppp.PurchaseOrderID
      and  MONTH(ppp.DueDate)<=pp.DueDate
) from Purchasing.PurchaseOrderDetail pp
order by pp.PurchaseOrderID, pp.DueDate;

select p.PurchaseOrderID,p.DueDate, p.OrderQty,(
      select sum(o.OrderQty) 
      from Purchasing.PurchaseOrderDetail o 
      where o.PurchaseOrderID=p.PurchaseOrderID
      and o.DueDate<=p.DueDate
)   from Purchasing.PurchaseOrderDetail p ;

select * from Purchasing.PurchaseOrderDetail

------------------------------------------------------------------------------------------------------------------------------
--1-1 Escreva uma consulta que retorne o valor máximo na coluna orderdate para cada funcionário.
-- ■ Tabelas envolvidas: banco de dados TSQL2012, tabela Sales.Orders
-- ■ Saída desejada:
------------------------------------------------------------------------------------------------------------------------------


select SalesOrderID, max(ModifiedDate)
from Sales.SalesOrderDetail
GROUP by SalesOrderID;



------------------------------------------------------------------------------------------------------------------------------
--1-2
-- Encapsule a consulta do Exercício 1-1 em uma tabela derivada. Escreva uma consulta de junção entre o derivado
-- e a tabela Pedidos para retornar os pedidos com a data máxima de pedido para cada funcionário.
-- ■ Tabelas envolvidas: Sales.Orders
-- ■ Saída desejada:

------------------------------------------------------------------------------------------------------------------------------
;with CTE as 
(
      select  SalesOrderID  , ModifiedDate 
      from Sales.SalesOrderDetail

), 
CTEE as 
(
      select SalesOrderID, max(ModifiedDate) as data
      from CTE
      GROUP by SalesOrderID
)
select SalesOrderID,[data]
from CTEE 

-- OU DESTA FORMA TBM 


select od.SalesOrderID,max(od.ModifiedDate)
from Sales.SalesOrderDetail as od 
inner join Sales.SalesOrderDetail as o 
on o.SalesOrderID=od.SalesOrderID
GROUP by od.SalesOrderID;
-------------------------

select So.SalesOrderID , SO.ModifiedDate
from Sales.SalesOrderDetail SO 
join (select Sa.SalesOrderID,MAX(Sa.ModifiedDate)  as madate from Sales.SalesOrderDetail SA
      group by Sa.SalesOrderID) AS D 
      on SO.SalesOrderID=D.SalesOrderID
      And SO.ModifiedDate=D.madate;






------------------------------------------------------------------------------------------------------------------------------

-- 2-1
-- Escreva uma consulta que calcule um número de linha para cada pedido com base na data do pedido, pedido de id do pedido.
-- ■ Tabelas envolvidas: Sales.Orders
-- ■ Saída desejada (abreviada):
------------------------------------------------------------------------------------------------------------------------------

select 
  ROW_NUMBER() over( order by CustomerID) as row,
  *
  from Sales.SalesOrderHeader;

------------------------------------------------------------------------------------------------------------------------------
-- 2-2
-- Escreva uma consulta que retorne linhas com números de linha de 11 a 20 com base na definição do número da linha
-- no Exercício 2-1. Use um CTE para encapsular o código do Exercício 2-1.
-- ■ Tabelas envolvidas: Sales.Orders
-- ■ Saída desejada:
------------------------------------------------------------------------------------------------------------------------------
; with CTE 
AS 
(
      select 
  ROW_NUMBER() over( order by CustomerID) as row,
  *
  from Sales.SalesOrderHeader
),
CTE2 
AS 
(
      select * from CTE
      where [row] BETWEEN 11 and 20
)

select * from CTE2

--OR 

select * from CTE
where [row] BETWEEN 11 and 20;

------------------------------------------------------------------------------------------------------------------------------
-- 3 (Opcional, Avançado)
-- Escreva uma solução usando um CTE recursivo que retorne a cadeia de gerenciamento que leva ao Zoya
-- Dolgopyatova (funcionário ID 9).
-- ■ Tabelas envolvidas: RH.Funcionários
-- ■ Saída desejada:
------------------------------------------------------------------------------------------------------------------------------
-- Resolução do livro
WITH EmpsCTE AS
(
 SELECT empid, mgrid, firstname, lastname
 FROM HR.Employees
 WHERE empid = 9

 UNION ALL 

 SELECT P.empid, P.mgrid, P.firstname, P.lastname
 FROM EmpsCTE AS C
 JOIN HR.Employees AS P
 ON C.mgrid = P.empid
)
SELECT empid, mgrid, firstname, lastname
FROM EmpsCTE;




------------------------------------------------------------------------------------------------------------------------------

-- 4-1
-- Crie uma exibição que retorne a quantidade total para cada funcionário e ano.
-- ■ Tabelas envolvidas: Sales.Orders e Sales.OrderDetails
-- ■ Ao executar o seguinte código:
-- SELECT * FROM Sales.VEmpOrders ORDER BY empid, orderyear;
-- ■ Saída desejada:
------------------------------------------------------------------------------------------------------------------------------

create or alter  view VEmpOrders as
      select  SH.SalesPersonID, 
      isnull(convert(varchar(10),year(OrderDate)), 'Subtotal') as  ANO ,
      SUM(OrderQty) AS Total
      from Sales.SalesOrderDetail SO 
      inner join Sales.SalesOrderHeader SH
      on Sh.SalesOrderID=So.SalesOrderID
      GROUP by rollup(SH.SalesPersonID, year(OrderDate),OrderQty)
      order by Sh.SalesPersonID asc , year(OrderDate),OrderQty
      OFFSET 0 ROWS;


select * from   VEmpOrders;


------------------------------------------------------------------------------------------------------------------------------
-- 4-2 (Opcional, Avançado)
-- Escreva uma consulta em Sales.VEmpOrders que retorne a quantidade total em execução para cada funcionário
-- e ano.
-- ■ Tabelas envolvidas: exibição Sales.VEmpOrders
-- ■ Saída desejada:
------------------------------------------------------------------------------------------------------------------------------
select *,
      (select sum(Total) 
      from VEmpOrders as V2 
      where V2.SalesPersonID=V1.SalesPersonID 
      and V2.ANO<=V1.ANO) as runtqy 
from VEmpOrders V1 ;




------------------------------------------------------------------------------------------------------------------------------

-- 5-1
-- Crie uma função inline que aceite como entrada um ID de fornecedor (@supid AS INT) e um número solicitado de produtos (@n AS INT). 
-- A função deve retornar @n produtos com os maiores preços unitários que
-- são fornecidos pelo ID do fornecedor especificado.
-- ■ Tabelas envolvidas: Produção.Produtos
-- ■ Ao emitir a seguinte consulta:
-- SELECT * FROM Production.TopProducts(5, 2);

------------------------------------------------------------------------------------------------------------------------------
 create or ALTER FUNCTION productin(@supid int,@n int )
RETURNS table 
as 
RETURN
(

with CTE 
as 
(
     select  
row_number() over (order by ProductID ) as row, *
from Production.Product
where ListPrice>ProductID and (ProductID=@supid)
),
CTE2
AS
(
      select * from CTE
      where [row] between 1 and @n
)
select * from CTE2

)

SELECT* from productin(680,2);
------------------------------------------------------------------------------------------------------------------------------
--5-2
-- Usando o operador CROSS APPLY e a função que você criou no Exercício 4-1, retorne, para cada fornecedor, os dois produtos mais caros.
-- ■ Saída desejada (mostrada aqui de forma abreviada).

------------------------------------------------------------------------------------------------------------------------------
SELECT S.supplierid, S.companyname, P.productid, P.productname, P.unitprice
FROM Production.Suppliers AS S
 CROSS APPLY Production.TopProducts(S.supplierid, 2) AS P;



------------------------------------------------------------------------------------------------------------------------------
--1-
-- Escreva uma consulta que gere uma tabela auxiliar virtual de 10 números no intervalo de 1 a 10 sem
-- usando uma construção de loop. Você não precisa garantir nenhuma ordem das linhas na saída do seu
-- solução.
-- ■ Tabelas envolvidas: nenhuma
-- ■ Saída desejada:

------------------------------------------------------------------------------------------------------------------------------
select 1 as n 
UNION all 
select 2
UNION all 
select 3
UNION all 
select 4
UNION all 
select 5
UNION all 
select 6
UNION all 
select 7
UNION all 
select 8
UNION all 
select 9
UNION all 
select 10





------------------------------------------------------------------------------------------------------------------------------
--2
-- Escreva uma consulta que retorne pares de clientes e funcionários que tiveram atividade de pedido em janeiro de 2008, mas
-- não em fevereiro de 2008.
-- ■ Tabelas envolvidas: banco de dados TSQL2012, tabela Sales.Orders
------------------------------------------------------------------------------------------------------------------------------
select * from Sales.SalesOrderHeader sa 
where year(sa.OrderDate)=2008 and MONTH(sa.OrderDate)=1 
and not EXISTS
      (select * from Sales.SalesOrderHeader so  
      where so.SalesOrderID=sa.SalesOrderID 
      and year(so.OrderDate)=2007 )

select * from Sales.SalesOrderHeader where OrderDate>='20080101' and OrderDate<='20080201'
EXCEPT
select * from Sales.SalesOrderHeader where OrderDate>='20080201' and OrderDate<'20080301'

select * from Sales.SalesOrderHeader  --<--Resposta do livro
where OrderDate>='20080101' and OrderDate<'20080201'
EXCEPT
select * from Sales.SalesOrderHeader 
where OrderDate>='20080201' and OrderDate<'20080301'




------------------------------------------------------------------------------------------------------------------------------
--3
-- Escreva uma consulta que retorne pares de clientes e funcionários que tiveram atividade de pedidos em janeiro de 2008
-- e fevereiro de 2008.
-- ■ Tabelas envolvidas: Sales.Orders
-- ■ Saída desejada:
------------------------------------------------------------------------------------------------------------------------------
use AdventureWorks

select CustomerID from Sales.SalesOrderHeader
where year(OrderDate)=2008 and month(OrderDate)=01
INTERSECT
select CustomerID from Sales.SalesOrderHeader
where YEAR(OrderDate)=2008 and MONTH(OrderDate)=2



SELECT * --<--Resposta do livro
FROM Sales.SalesOrderHeader
WHERE orderdate >= '20080101' AND orderdate < '20080201'
INTERSECT
SELECT *
FROM Sales.SalesOrderHeader
WHERE orderdate >= '20080201' AND orderdate < '20080301';

------------------------------------------------------------------------------------------------------------------------------
--4
-- Escreva uma consulta que retorne pares de clientes e funcionários que tiveram atividade de pedidos em janeiro de 2008
-- e fevereiro de 2008, mas não em 2007.
-- ■ Tabelas envolvidas: Sales.Orders
-- ■ Saída desejada:
------------------------------------------------------------------------------------------------------------------------------
select * from sales.SalesOrderHeader ss
where year(ss.OrderDate)=2008 and 
month(ss.OrderDate) between 1 and 2 
and not EXISTS 
      (select * from Sales.SalesOrderHeader so 
       where ss.SalesOrderID=so.SalesOrderID  and YEAR(so.OrderDate)=2007)



select * from Sales.SalesOrderHeader
where OrderDate>='20080101' and OrderDate<'20080301'
EXCEPT 
select * from Sales.SalesOrderHeader
where OrderDate=2007


(SELECT * --<--Resposta do livro
 FROM Sales.SalesOrderHeader
 WHERE orderdate >= '20080101' AND orderdate < '20080201'
 INTERSECT
 SELECT *
 FROM Sales.SalesOrderHeader
 WHERE orderdate >= '20080201' AND orderdate < '20080301')
EXCEPT
SELECT *
FROM Sales.SalesOrderHeader
WHERE orderdate >= '20070101' AND orderdate < '20080101';
------------------------------------------------------------------------------------------------------------------------------
-- 5 (Opcional, Avançado)
-- Você recebe a seguinte consulta.
-- SELECIONE país, região, cidade
-- DE RH. Empregados
-- UNIÃO SOB
-- SELECIONE país, região, cidade
-- DE Produção.Fornecedores;
-- www.it-ebooks.info
-- Capítulo 6 Definir operadores 207
-- Você é solicitado a adicionar lógica à consulta para garantir que as linhas de Employees sejam
-- retornado na saída antes das linhas de Fornecedores. Além disso, dentro de cada segmento, as linhas devem ser
-- classificados por país, região e cidade.
-- ■ Tabelas envolvidas: RH.Colaboradores e Produção.Fornecedores
-- ■ Saída desejada:
------------------------------------------------------------------------------------------------------------------------------

-- Não conseguir finalizar está questão

SELECT country, region, city --<--Resposta do livro
FROM (SELECT 1 AS sortcol, country, region, city
 FROM HR.Employees
 UNION ALL
 SELECT 2, country, region, city
 FROM Production.Suppliers) AS D
ORDER BY sortcol, country, region, city;

------------------------------------------------------------------------------------------------------------------------------
-- 1-Run the following code to create the dbo.Customers table in the TSQL2012 database

------------------------------------------------------------------------------------------------------------------------------
use TSQL2012



if OBJECT_ID('dbo.Customers','U') is not null drop TABLE dbo.Customers; --or create table if not exists dbo.Customers
create TABLE dbo.Customers(
      custid int not null,
      companyname NVARCHAR(40) NOT NULL,
      country NVARCHAR(15) NOT NULL,
      region NVARCHAR(15) NULL,
      city NVARCHAR(15) NOT NULL,
      
      CONSTRAINT Pk_custid  PRIMARY key (custid)
);

------------------------------------------------------------------------------------------------------------------------------
-- 1-1 -Insira na tabela dbo.Customers uma linha com:

insert into dbo.Customers values (100,'Coho Winery','USA','WA','Redmond')

------------------------------------------------------------------------------------------------------------------------------
-- 1-2
-- Insira na tabela dbo.Customers todos os clientes de Sales.Customers que fizeram pedidos.

------------------------------------------------------------------------------------------------------------------------------
insert into TSQL2012.dbo.Customers
select * from AdventureWorks.Sales.Customer


------------------------------------------------------------------------------------------------------------------------------
-- 1-3
-- Use uma instrução SELECT INTO para criar e preencher a tabela dbo.Orders com pedidos do
-- Sales.Orders que foram colocados nos anos de 2006 a 2008. Observe que este exercício só pode
-- ser praticado em um SQL Server local, porque o banco de dados SQL não suporta o SELECT INTO
-- declaração. No banco de dados SQL, use as instruções CREATE TABLE e INSERT SELECT.
if OBJECT_ID('#Orders','U') is not null drop TABLE #Orders;
CREATE TABLE #Orders
(
      Salesordeid int,
      Orderdate date,
      Custumerid int,
      TerritoryID int,
      CountryRegioCode CHAR(2) null
      CONSTRAINT Pk PRIMARY key (Salesordeid)
)

insert  into #Orders
select SalesOrderID,OrderDate,CustomerID,TerritoryID,null
from AdventureWorks.Sales.SalesOrderHeader
where OrderDate>='2006' 
and OrderDate<='2008'

select * from #Orders



SELECT *--<---Resposta do livro 
INTO dbo.Orders
FROM Sales.Orders
WHERE orderdate >= '20060101'
 AND orderdate < '20090101';

------------------------------------------------------------------------------------------------------------------------------

--2
-- Exclua da tabela dbo.Orders os pedidos que foram feitos antes de agosto de 2006. Use o OUTPUT
-- cláusula para retornar o orderid e o orderdate dos pedidos excluídos.
------------------------------------------------------------------------------------------------------------------------------
delete from #Orders
OUTPUT 
      DELETED.Salesordeid,
      DELETED.Orderdate,
      DELETED.Custumerid
where Orderdate<='2006-07-31'


select * from #Orders



delete from #Orders
OUTPUT $action,
      DELETED.*
where Orderdate<='2006-07-31'


select * from #Orders
------------------------------------------------------------------------------------------------------------------------------
--3
-- Excluir da tabela dbo.Orders pedidos feitos por clientes do Brasil

------------------------------------------------------------------------------------------------------------------------------
delete o  
from #Orders o
INNER join AdventureWorks.Sales.SalesTerritory ab
on ab.TerritoryID=o.TerritoryID
where ab.Name='Canada'

select * from #Orders


MERGE INTO dbo.Orders AS O
USING dbo.Customers AS C
 ON O.custid = C.custid --<--Resposta do livro 
 AND country = N'Brazil'
WHEN MATCHED THEN DELETE;

------------------------------------------------------------------------------------------------------------------------------
--4-
-- Execute a seguinte consulta em dbo.Customers e observe que algumas linhas têm um NULL na região
-- coluna.
-- Atualize a tabela dbo.Customers e altere todos os valores de região NULL para <None>. Use a SAÍDA
-- para mostrar custid, oldregion e newregion.

------------------------------------------------------------------------------------------------------------------------------
select * from #Orders
UPDATE #Orders set CountryRegioCOde =('<>')
OUTPUT 
      inserted.CountryRegioCode as newvalor,
      DELETED.CountryRegioCode as oldvalor

------------------------------------------------------------------------------------------------------------------------------
-- 5
-- Atualize todos os pedidos na tabela dbo.Orders que foram feitos por clientes do Reino Unido e definidos
-- seus valores shipcountry, shipregion e shipcity para os valores country, region e city dos clientes correspondentes.
------------------------------------------------------------------------------------------------------------------------------

update o   --<---Resposta do livro
set shipcountry=c.country,
    shippregion=c.region,
    shipcity=c.city
from #Orders as O 
join dbo.Customers as C 
on O.Custumerid=C.custid
where C.country='UK'

------------------------------------------------------------------------------------------------------------------------------
--1-1
-- Abra três conexões no SQL Server Management Studio (os exercícios se referirão a elas como Conexão 1, Conexão 2 e Conexão 3). 
-- Execute o seguinte código na Conexão 1 para atualizar as linhas
-- em Sales.OrderDetails.
------------------------------------------------------------------------------------------------------------------------------

begin tran
UPDATE sales.SalesOrderDetail
 SET unitpricediscount = 0.05
 WHERE salesorderdetailid = 10249;


------------------------------------------------------------------------------------------------------------------------------
--1--2
-- Execute o seguinte código na Conexão 2  para consultar Sales.OrderDetails; A conexão 2 será bloqueada
-- (lembre-se de descomentar a dica se estiver executando no banco de dados SQL).
------------------------------------------------------------------------------------------------------------------------------
select salesorderdetailid,productid,unitprice,unitpricediscount
from sales.SalesOrderDetail with (readcommittedlock)
where salesorderdetailid=10249
 
------------------------------------------------------------------------------------------------------------------------------
--1-3
-- Execute o seguinte código na Conexão 3 e identifique os bloqueios e IDs de processo envolvidos na cadeia de bloqueio.
------------------------------------------------------------------------------------------------------------------------------
select 
request_session_id as spid,
resource_type as restype,
resource_database_id as dbid,
resource_description as res,
resource_associated_entity_id as resid,
request_mode as mode,
request_status as status 
from sys.dm_tran_locks

------------------------------------------------------------------------------------------------------------------------------
--1-4
-- Substitua os IDs de processo 52 e 53 pelos que você descobriu estarem envolvidos na cadeia de bloqueio em
-- o exercício anterior. Execute o código a seguir para obter informações de conexão, sessão e bloqueio
-- sobre os processos envolvidos na cadeia de bloqueio.
------------------------------------------------------------------------------------------------------------------------------
-- informacao de conexão

select 
session_id as spid,
connect_time,
last_read,
last_write,
most_recent_sql_handle
from sys.dm_exec_connections
where session_id in (52,53)


--informação da sessao

select 
session_id as spid,
login_time,
host_name,
PROGRAM_NAME,
login_name,
nt_user_name,
last_request_start_time,
last_request_end_time
from sys.dm_exec_sessions
where session_id in (52,53)

--blocking 

select 
session_id as spid,
blocking_session_id,
command,
sql_handle,
database_id,
wait_type,
wait_time,
wait_resource
from sys.dm_exec_requests
where blocking_session_id>0

------------------------------------------------------------------------------------------------------------------------------
--1-5
-- Execute o código a seguir para obter o texto SQL das conexões envolvidas na cadeia de bloqueio.
------------------------------------------------------------------------------------------------------------------------------
select session_id, text
from sys.dm_exec_connections
     cross APPLY sys.dm_exec_sql_text(most_recent_sql_handle) as st 
where SESSION_id in (52,53)


------------------------------------------------------------------------------------------------------------------------------
--1-6
-- Execute o código a seguir na Conexão 1 para reverter a transação.
------------------------------------------------------------------------------------------------------------------------------


ROLLBACK TRAN;

------------------------------------------------------------------------------------------------------------------------------
--2-1
-- Execute o seguinte código na Conexão 1 para atualizar as linhas em Sales.OrderDetails e consulte-o
------------------------------------------------------------------------------------------------------------------------------
begin tran;


update sales.SalesOrderDetail
 set unitpricediscount +=0.05
where salesorderdetailid=12249;

select * from sales.SalesOrderDetail
where salesorderdetailid=12249;

------------------------------------------------------------------------------------------------------------------------------
--2-2
-- Execute o seguinte código na Conexão 2 para definir o nível de isolamento como READ UNCOMMITTED e consulte
-- Vendas.Detalhes do pedido
------------------------------------------------------------------------------------------------------------------------------
set TRANSACTION ISOLATION level read UNCOMMITTED;

select * from sales.SalesOrderDetail
where salesorderdetailid=12249;


------------------------------------------------------------------------------------------------------------------------------
--2-3
--Execute o código a seguir na Conexão 1 para reverter a transação.
------------------------------------------------------------------------------------------------------------------------------
ROLLBACK TRAN


------------------------------------------------------------------------------------------------------------------------------
--3-1
-- Neste exercício, você praticará o uso do nível de isolamento READ COMMITTED.
-- Execute o seguinte código na Conexão 1 para atualizar as linhas em Sales.OrderDetails e consulte-o
------------------------------------------------------------------------------------------------------------------------------

begin tran;


update sales.SalesOrderDetail
 set unitpricediscount =0.05
where salesorderdetailid=12249;

select * from sales.SalesOrderDetail
where salesorderdetailid=12249;

------------------------------------------------------------------------------------------------------------------------------
--3-2
-- Execute o seguinte código na Conexão 2 para definir o nível de isolamento como READ COMMITTED e consulte
-- Sales.OrderDetails. (Lembre-se de descomentar a dica se estiver executando no banco de dados SQL.)
------------------------------------------------------------------------------------------------------------------------------
set TRANSACTION ISOLATION LEVEL read committed;
select * 
from sales.SalesOrderDetail with (readcommittedlock)
where salesorderdetailid=12249;

------------------------------------------------------------------------------------------------------------------------------
--3-3
-- Execute o código a seguir na Conexão 1 para confirmar a transação.
------------------------------------------------------------------------------------------------------------------------------
COMMIT TRAN;

------------------------------------------------------------------------------------------------------------------------------
--3-4
-- Vá para a Conexão 2 e observe que você obtém a versão modificada e consolidada das linhas.
------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------
--4-1
-- Neste exercício, você praticará o uso do nível de isolamento REPEATABLE READ.
-- Execute o seguinte código na Conexão 1 para definir o nível de isolamento como REPEATABLE READ, abra uma transação e leia os dados de Sales.OrderDetail

-----------------------------------------------------------------------------------------------------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRAN;
 SELECT *
 FROM sales.SalesOrderDetail
 WHERE salesorderdetailid = 10249;

------------------------------------------------------------------------------------------------------------------------------
--4-2
-- Execute o seguinte código na Conexão 2 e observe que você está bloqueado.
------------------------------------------------------------------------------------------------------------------------------
UPDATE sales.SalesOrderDetail
 SET unitpricediscount += 0.05
WHERE salesorderdetailid = 10249;

------------------------------------------------------------------------------------------------------------------------------
--4-3
-- Execute o código a seguir na Conexão 1 para ler os dados novamente e confirmar a transação.
------------------------------------------------------------------------------------------------------------------------------
select * from sales.SalesOrderDetail
where  salesorderdetailid = 10249;
COMMIT TRAN

------------------------------------------------------------------------------------------------------------------------------
-- 2-4
-- Neste exercício, você praticará o uso do nível de isolamento SERIALIZABLE.
-- Execute o seguinte código na Conexão 1 para definir o nível de isolamento como SERIALIZABLE e consultar
------------------------------------------------------------------------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRAN;
 SELECT *
 FROM sales.SalesOrderDetail
 WHERE salesorderdetailid = 10249;

------------------------------------------------------------------------------------------------------------------------------
--2-4-1
--  Execute o seguinte código na Conexão 2 para tentar inserir uma linha em Sales.OrderDetails com o mesmo
-- ID do pedido que é filtrado pela consulta anterior e observe que você está bloqueado.
------------------------------------------------------------------------------------------------------------------------------
INSERT INTO sales.SalesOrderDetail
 (salesorderdetailid, productid, UnitPriceDiscount)
 VALUES(10249, 2, 19.00);


------------------------------------------------------------------------------------------------------------------------------
--2-4-2
--  Execute o código a seguir na Conexão 1 para consultar Sales.OrderDetails novamente e confirme a transação.
------------------------------------------------------------------------------------------------------------------------------

SELECT *
 FROM sales.SalesOrderDetail
 WHERE salesorderdetailid = 10249;
COMMIT TRAN;

------------------------------------------------------------------------------------------------------------------------------
--2-4-3
-- Execute o seguinte código para limpeza.
------------------------------------------------------------------------------------------------------------------------------
DELETE FROM Sales.OrderDetails
WHERE orderid = 10249
 AND productid = 2;


------------------------------------------------------------------------------------------------------------------------------
--2-4-3-1
-- Execute o seguinte código na Conexão 1 e na Conexão 2 para definir o nível de isolamento para o
-- predefinição.
------------------------------------------------------------------------------------------------------------------------------
 SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


------------------------------------------------------------------------------------------------------------------------------
--  2-5a
-- Neste exercício, você praticará o uso do nível de isolamento SNAPSHOT

-- Se você estiver fazendo os exercícios em uma instância local do SQL Server, execute o código a seguir para
-- defina o nível de isolamento SNAPSHOT no banco de dados TSQL2012 (habilitado no banco de dados SQL por padrão):
------------------------------------------------------------------------------------------------------------------------------

ALTER DATABASE TSQL2012 SET ALLOW_SNAPSHOT_ISOLATION ON;


------------------------------------------------------------------------------------------------------------------------------
--2-5b
-- Execute o seguinte código na Conexão 1 para abrir uma transação, atualizar linhas em Sales.OrderDetails e
-- pergunte
------------------------------------------------------------------------------------------------------------------------------

BEGIN TRAN;

UPDATE sales.SalesOrderDetail
 SET unitpricediscount += 0.05
 WHERE salesorderdetailid = 10249;
 SELECT *
 FROM sales.SalesOrderDetail
 WHERE salesorderdetailid = 1024

------------------------------------------------------------------------------------------------------------------------------
--  2-5c
-- Execute o seguinte código na Conexão 2 para definir o nível de isolamento como SNAPSHOT e consultar
-- Sales.OrderDetails. Observe que você não está bloqueado - em vez disso, obtém uma versão anterior e
--  consistente dos dados que estavam disponíveis quando a transação foi iniciada (com valores de desconto de 0,00).
------------------------------------------------------------------------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
BEGIN TRAN;
 SELECT *
 FROM sales.SalesOrderDetail
 WHERE salesorderdetailid = 10249;


------------------------------------------------------------------------------------------------------------------------------
-- 2-5d
-- Vá para a Conexão 1 e confirme a transação.
------------------------------------------------------------------------------------------------------------------------------
COMMIT TRAN;

------------------------------------------------------------------------------------------------------------------------------
--2-6-e
-- Vá para a Conexão 2 e consulte os dados novamente; observe que você ainda obtém valores de desconto de 0,00.
------------------------------------------------------------------------------------------------------------------------------

 SELECT *
 FROM sales.SalesOrderDetail
 WHERE salesorderdetailid = 10249;

------------------------------------------------------------------------------------------------------------------------------
--2-6-f
-- Na Conexão 2, confirme a transação e consulte os dados novamente; observe que agora você tem desconto
-- valores de 0,05.
 COMMIT TRAN;
SELECT orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails
WHERE orderid = 10249;



------------------------------------------------------------------------------------------------------------------------------
-- Se você estiver executando em uma instância local do SQL Server, altere os sinalizadores do banco de dados de volta para o
-- padrões, desabilitando os níveis de isolamento com base no controle de versão da linha.
------------------------------------------------------------------------------------------------------------------------------


ALTER DATABASE AdventureWorks SET ALLOW_SNAPSHOT_ISOLATION OFF;
ALTER DATABASE AdventureWorks SET READ_COMMITTED_SNAPSHOT OFF;

------------------------------------------------------------------------------------------------------------------------------
-- Execute o seguinte código na Conexão 1 para abrir uma transação e atualizar a linha do produto 2 em
-- Produção.Produtos.
------------------------------------------------------------------------------------------------------------------------------

BEGIN TRAN;
 UPDATE Production.Products
 SET unitprice += 1.00
 WHERE productid = 2;


------------------------------------------------------------------------------------------------------------------------------
--  Execute o seguinte código na Conexão 2 para abrir uma transação e atualizar a linha do produto 3 em
-- Produção.Produtos
------------------------------------------------------------------------------------------------------------------------------
BEGIN TRAN;
 UPDATE Sales.SalesOrderDetail
 SET unitprice += 1.00
 WHERE productid = 758;

------------------------------------------------------------------------------------------------------------------------------
-- Execute o seguinte código na Conexão 1 para consultar o produto 3. Você será bloqueado. 
-- (Lembre-se de descomentar a dica se você estiver conectado ao banco de dados SQL.)
------------------------------------------------------------------------------------------------------------------------------

SELECT *
 FROM Sales.SalesOrderDetail  WITH (READCOMMITTEDLOCK)
 WHERE productid = 758;
COMMIT TRAN;

------------------------------------------------------------------------------------------------------------------------------
-- Execute o seguinte código na Conexão 2 para consultar o produto 2. Você será bloqueado e um erro de impasse
-- será gerado na Conexão 1 ou na Conexão 2
------------------------------------------------------------------------------------------------------------------------------

SELECT *
 FROM Sales.SalesOrderDetail  WITH (READCOMMITTEDLOCK)
 WHERE productid = 758;
COMMIT TRAN;


