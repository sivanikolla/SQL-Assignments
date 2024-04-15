-- DATABASE DESIGN:

--CUSTOMER TABLE:
create table Customers(Customerid int primary key,
Firstname varchar(20),
Lastname varchar(20),
Email varchar(20),
Phone varchar(20),
Address varchar(20));

INSERT INTO Customers(Customerid,Firstname,Lastname,Email,Phone,Address)
values(101,'mahendra','singh','mahendra@gmail.com',9874565987,'mumbai'),
(102,'sivani','kolla','ksivani@gmail.com',9398097164,'andhrapradesh'),
(103,'joshika','dintakurthi','joshikad@gmail.com',7897845650,'andhrapradesh'),
(104,'kusuma','sri','kusumasri@gmail.com',8794885790,'telangana'),
(105,'likhitha','gannina','likhithag@gmail.com',9874897589,'chennai'),
(106,'nikhitha','durgam','nikhithad@gmail.com',8569854789,'telangana'),
(107,'abhi','kumar','abhikumar@gmail.com',8069224789,'hyderabad'),
(108,'sai','ram','sairam@gmail.com',7984400326,'guntur'),
(109,'chandra','sekhar','chandras@gmail.com',9879875556,'vijayawada'),
(110,'deepak','kumar','deepak@gmail.com',9988775520,'tanuku');
select*from Customers

--PRODUCT TABLE:
create table Products(Productid int primary key,
Productname varchar(30),
Description text,
Price int,
Quantity int)

INSERT INTO Products(Productid,Productname,Description,Price,Quantity)
values(1,'charger','fast charging',1000,1),
(2,'laptop','high performance',50000,1),
(3,'camera','dslr camera with changable lens',35000,2),
(4,'smart watch','fitness tracker and heart rate monitor',3000,2),
(5,'air conditioner','energy efficient with warranty of five years',30000,1),
(6,'telivision','smart tv with ultra HD resolution',25000,1),
(7,'refrigerator','energy efficient',20000,1),
(8,'Books','top rated from popular authors',2500,3),
(9,'Skincare products','Natural for protecting skin',1600,3),
(10,'Board games','best classics',5000,2);
select*from Products

--ORDERS TABLE:
create table Orders(Orderid int primary key,
Customerid int,
Orderdate date,
TotalAmount int,
foreign key(Customerid) References Customers(Customerid));

INSERT INTO Orders(Orderid,Customerid,Orderdate,TotalAmount)
values(1001,101,'2023-08-08',1000),
(1002,102,'2023-08-16',50000),
(1003,103,'2023-09-12',70000),
(1004,104,'2023-09-27',6000),
(1005,105,'2023-10-04',30000),
(1006,106,'2023-10-10',25000),
(1007,107,'2023-10-18',20000),
(1008,108,'2023-10-24',7500),
(1009,109,'2023-11-14',4800),
(1010,110,'2023-11-18',10000);
select*from Orders

--ORDERDETAILS TABLE:
create table OrderDetails(OrderDetailid int Primary key,
Orderid int,
Productid int,
Quantity int,
foreign key(Orderid) References Orders(Orderid),
foreign key(Productid) References Products(Productid));

INSERT INTO OrderDetails(OrderDetailid,Orderid,Productid,Quantity)
values(1,1001,1,1),
(2,1002,2,1),
(3,1003,3,2),
(4,1004,4,2),
(5,1005,5,1),
(6,1006,6,1),
(7,1007,7,1),
(8,1008,8,3),
(9,1009,9,3),
(10,1010,10,2);
Select*from OrderDetails

--INVENTORY TABLE:
create table Inventory (Inventoryid int Primary Key,
Productid int,
QuantityInStock int,
LastStockUpdate date,
foreign key (Productid) References Products (Productid))

INSERT INTO Inventory(Inventoryid,Productid,QuantityInStock,LastStockUpdate)
values(101,1,15,'2024-03-12'),
(102,2,5,'2024-03-09'),
(103,3,10,'2024-03-26'),
(104,4,4,'2024-02-28'),
(105,5,8,'2024-03-20'),
(106,6,12,'2024-03-07'),
(107,7,5,'2024-04-02'),
(108,8,2,'2024-03-29'),
(109,9,14,'2024-04-01'),
(110,10,7,'2024-04-03');
select*from Inventory

--CATEGORY TABLE:
create table Category(categoryid int Primary key,categoryname varchar(20))
insert into category(categoryid,categoryname)
values(1,'ElectronicGadget'),
(2,'others')

select*from Category

alter table Products add Categoryid int Foreign key(Categoryid)
References Category(Categoryid)
update Products set Categoryid=1 where Productid=1
update Products set Categoryid=1 where Productid in(2,3,4,5,6,7,11)
update Products set Categoryid=2 where Productid in(8,9,10)
select*from Products

--TASK 2:
1:--Write an SQL query to retrieve the names and emails of all customers
select Firstname,Lastname,Email from Customers

2:--Write an SQL query to list all orders with their order dates and corresponding customer names.
Select O.Orderid,O.Orderdate,c.Firstname+c.Lastname as Customername from Orders O JOIN Customers C ON O.Customerid=c.Customerid

3:-- Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address
INSERT INTO Customers values(111,'virat','kohli','viratk@gmail.com',9898745654,'delhi')
select*from Customers

4:-- Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.
UPDATE Products SET Price=Price*1.10
select*from Products

5:--Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables.
--Allow users to input the order ID as a parameter.
DECLARE @Orderid int=1004
DELETE from Orderdetails where Orderid=@Orderid
DELETE from Orders where Orderid=@Orderid
select*from OrderDetails

6:-- Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information.
INSERT into Orders values(1011,111,'2023-11-20', 1000)

7:--Write an SQL query to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. 
--Allow users to input the customer ID and new contact information
DECLARE @customerid int = 106;
DECLARE @new_email varchar(60) = 'dnikhita@gmail.com';
DECLARE @new_address varchar(100) = 'Andhra';
UPDATE Customers
SET Email = @new_email,
    Address = @new_address
WHERE CustomerID = @customerid;

select*from customers

8:-- Write an SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.
UPDATE Orders set TotalAmount=(select sum(od.quantity*p.price) from Orderdetails od
INNER JOIN Products p on p.Productid=od.Productid where Orders.Orderid=od.Orderid)
select*from Products

9:--Write an SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables.
--Allow users to input the customer ID as a parameter.
DECLARE @customerid int=106 
DELETE from Orderdetails where OrderId in (Select Orderid from Orders where Customerid=@customerid)
DELETE from Orders where Customerid=@customerid

10:-- Write an SQL query to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details.
insert into Products values(11,'wireless earbuds','connect via bluetooth',1000,2)

11:--Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status.
alter table Orders add OrderStatus varchar(20);
update Orders set OrderStatus='Pending' where Orderid in (1001,1004,1006,1008,1009);
update Orders set OrderStatus='shipped' where Orderid in (1005,1007,1006,1010,1011);

DECLARE @orderid int=1001
DECLARE @orderstatus varchar(20)='shipped'
update Orders set OrderStatus=@Orderstatus where Orderid=@orderid
select*from orders

12:--Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.
alter table Customers add NumOrders int
UPDATE Customers set NumOrders=1 where Customerid in(101,105,107)
UPDATE Customers set NumOrders=2 where Customerid=110
UPDATE Customers set NumOrders=3 where Customerid in(108,109)

UPDATE Customers SET NumOrders=( SELECT COUNT(*) FROM Orders WHERE Orders.Customerid = Customers.Customerid)

select*from Customers
select*from Products
select*from Orders
select*from OrderDetails
select*from Inventory

--TASK 3:

1:--Write an SQL query to retrieve a list of all orders along with customer information (e.g.,customer name) for each order.select o.orderid,o.orderdate,c.firstname
from orders o
inner join Customers c on o.CustomerID=c.CustomerID

2:--Write an SQL query to find the total revenue generated by each electronic gadget product.Include the product name and the total revenue.
select p.productname,sum(od.quantity*p.price) as totalrevenue
from orderdetails od
join products p on od.productid = p.productid
group by p.productid, p.productname
select*from Products

3:--Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information.
select c.firstname,c.phone from customers c
join orders o on c.customerid=o.customerid
group by c.firstname, c.Phone

4:--Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. 
--Include the product name and the total quantity ordered.
select top 1 p.productname, sum(od.quantity) as total_quantity_ordered 
from orderdetails od
join products p on od.productid = p.productid
group by p.productname
order by total_quantity_ordered DESC

5:--Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories.
select p.categoryid,p.productname 
from products p
join category c on c.categoryid=p.categoryid

6:--Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value.
select c.firstname,avg(o.totalamount) as averageordervalue
from customers c
join orders o on c.customerid = o.customerid
group by c.firstname

7:--Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.select top 1 o.orderid,c.firstname,c.lastname,o.totalamount
from orders o
join customers c on o.customerid = c.customerid
order by o.totalamount desc

8:--Write an SQL query to list electronic gadgets and the number of times each product has been ordered
select p.productname,count(od.productid) as numtimesordered from Products p
join OrderDetails od on od.ProductID=p.ProductID
group by p.productname

9:--Write an SQL query to find customers who have purchased a specific electronic gadget product.
--Allow users to input the product name as a parameter.declare @Proname varchar(20) 
set @Proname='charger'
select c.firstname from Customers c
join orders o on o.customerid=c.Customerid
join OrderDetails od on od.Orderid=o.orderid
join Products p on p.Productid=od.Productid
where ProductName=@Proname
10:--Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period.
--Allow users to input the start and end dates as parameters.
declare @Startdate date, @Enddate date
set @Startdate='2023-08-15'
set @Enddate='2023-12-10'
select sum(o.totalamount) as totalrevenue
from orders o
where o.orderdate between @Startdate and @Enddate


--TASK 4:

1:--Write an SQL query to find out which customers have not placed any orders.
select CONCAT(firstname,' ',lastname) as customername ,customerid from Customers
where Customerid not in(select customerid from orders)

2:--Write an SQL query to find the total number of products available for sale
SELECT COUNT(*) AS TotalProductsAvailable
FROM (
    SELECT p.Productid FROM Products p
    JOIN Inventory i ON p.ProductID = i.ProductID
    WHERE i.Quantityinstock > 0
) AS AvailableProducts;

3:--Write an SQL query to calculate the total revenue generated by TechShop. 
Select SUM(OrderTotal) AS TotalRevenue FROM (
SELECT SUM(TotalAmount) AS OrderTotal FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Orders.OrderID)
AS RevenueByOrder;

4:--Write an SQL query to calculate the average quantity ordered for products in a specific category.Allow users to input the category name as a parameter.
DECLARE @category_name VARCHAR(50) = 'others';
SELECT AVG(Quantity) AS AverageQuantityOrdered
FROM (
    SELECT od.Quantity
    FROM OrderDetails od
    JOIN Products p ON od.ProductID = p.ProductID
    JOIN Category c ON p.Categoryid = c.categoryid
    WHERE c.categoryname = @category_name
) AS OrdersByCategory
select *from Products

5:--Write an SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter.
DECLARE @customerid INT = 108
SELECT SUM(TotalAmount) AS TotalRevenue
FROM (
    SELECT o.TotalAmount
    FROM Orders o
    WHERE o.CustomerID = @customerid
) AS CustomerOrders

6:--Write an SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed.
SELECT FirstName, LastName, NumOrdersPlaced
FROM ( SELECT c.FirstName, c.LastName, COUNT(o.Orderid) AS NumOrdersPlaced
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.FirstName, c.LastName
) AS CustomerOrders
ORDER BY NumOrdersPlaced DESC

7:--Write an SQL query to find the most popular product category, which is the one with the highest total quantity ordered across all orders.
select top 1 categoryname, totalquantity
from(select c.categoryname,sum(od.quantity) as totalquantity
from orderdetails od
join products p on od.productid = p.productid
join category c on p.categoryid = c.categoryid
group by c.categoryname) as categorytotals
order by totalquantity desc;

8:--Write an SQL query to find the customer who has spent the most money (highest total revenue) on electronic gadgets.
--List their name and total spending.
select top 1 c.firstname, maximum.totalspent
from customers c
join(select CustomerID, sum(totalamount) as totalspent from orders
group by customerid)maximum on c.customerid = maximum.customerid
order by maximum.totalspent desc

9:--Write an SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers.
select c.firstname, all_orders.avg_order
from customers c
join(select customerid, sum(totalamount)/count(orderid) as avg_order
from orders
group by customerid) all_orders on c.customerid = all_orders.customerid;

10:--Write an SQL query to find the total number of orders placed by each customer and list their names along with the order count.
select c.FirstName,o.noofOrders from Customers c
join (select CustomerID,count(OrderID) as noofOrders from Orders group by CustomerID) o
on o.customerid=c.CustomerID


