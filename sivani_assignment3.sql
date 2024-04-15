--DATABASE DESIGN:

--CUSTOMERS TABLE:
create table Customers(customer_id int Primary Key,
first_name varchar(30),
last_name varchar(30),
DOB date,
email varchar(40),
phone_number varchar(20),
address varchar(30))

insert into Customers(customer_id,first_name,last_name,DOB,email,phone_number,address)
values(101,'mahendra','singh','2000-07-07','mahendra@gmail.com',9874565987,'mumbai'),
(102,'ravindra','jadeja','2001-10-14','ravijadeja@gmail.com',9398097164,'mumbai'),
(103,'matheesha','pathirana','2003-09-08','pathiranam@gmail.com',7897845650,'chennai'),
(104,'rachin','ravindra','2003-01-20','rachinravi@gmail.com',8794885790,'chennai'),
(105,'deepak','chahar','2002-11-07','deepakchahar@gmail.com',9874897589,'pune'),
(106,'devon','conway','2001-12-01','devonconway@gmail.com',8569854789,'delhi'),
(107,'ruturaj','gaikwad','2004-09-27','ruturaj@gmail.com',8069224789,'hyderabad'),
(108,'shivam','dube','2001-02-23','shivam@gmail.com',7984400326,'mumbai'),
(109,'shardul','thakur','2002-12-20','shardul@gmail.com',9879875556,'bangalore'),
(110,'ajinkya','rahane','2000-04-11','ajinkyar@gmail.com',9988775520,'delhi')
select*from Customers

--ACCOUNTS TABLE:
create table Accounts(account_id int Primary Key,
customer_id int,
account_type varchar(20),
balance int,
Foreign Key(customer_id)
references Customers(customer_id))

insert into Accounts(account_id,customer_id,account_type,balance)
values(1,101,'savings',1000),
(2,102,'current',1200),
(3,103,'savings',600),
(4,104,'zero balance',0),
(5,105,'savings',1500),
(6,106,'current',3000),
(7,107,'savings',2000),
(8,108,'zero balance',0),
(9,109,'savings',0),
(10,110,'zero balance',0)
select*from accounts

update accounts set balance=2000 where account_id=2

--TRANSACTIONS TABLE:
create table Transactions(transaction_id int Primary Key,
account_id int,
transaction_type varchar(20),
amount int,
transaction_date dateForeign Key(account_id) references accounts(account_id))
insert into Transactions(transaction_id,account_id,transaction_type,amount,transaction_date)
values(201, 1, 'deposit', 500.00, '2024-01-02'),
    (202, 2, 'withdrawal', 200.00, '2024-01-02'),
    (203, 3, 'transfer', 100.00, '2024-01-10'),
    (204, 4, 'deposit', 800.00, '2024-01-10'),
    (205, 5, 'withdrawal', 300.00, '2024-01-02'),
    (206, 6, 'deposit', 150.00, '2024-01-10'),
    (207, 7, 'withdrawal', 1000.00, '2024-01-10'),
    (208, 8, 'deposit', 300.00, '2024-01-02'),
    (209, 9, 'deposit', 700.00, '2024-01-12'),
    (210, 10, 'deposit', 150.00, '2024-01-12');
select*from Transactions
select*from Accounts
select*from Customers
--TASK 2:

1:--Write a SQL query to retrieve the name, account type and email of all customers
select c.first_name,c.last_name,c.email,a.account_type 
from Customers c
join Accounts a on c.customer_id=a.customer_id

--2. Write a SQL query to list all transaction corresponding customer
select c.first_name,c.last_name,t.transaction_type,t.amount,t.transaction_date
from Customers c 
join Accounts a on c.Customer_id=a.Customer_id
join Transactions t on a.account_id=t.account_id

--3. Write a SQL query to increase the balance of a specific account by a certain amount
update Accounts set balance=balance+200 where account_id=1

--4. Write a SQL query to Combine first and last names of customers as a full_name
select concat(first_name,' ',last_name) as full_name 
from Customers
select * from accounts

--5:Write a SQL query to remove accounts with a balance of zero where the account type is savings.
delete from accounts where balance=0 and account_type='savings'

--6:Write a SQL query to Find customers living in a specific city.
select * from customers where address='mumbai'

--7:Write a SQL query to Get the account balance for a specific account.
select balance from accounts where account_id=6

--8:Write a SQL query to List all current accounts with a balance greater than $1,000.
select *from accounts
where account_type = 'current' AND balance > 1000;

--9. Write a SQL query to Retrieve all transactions for a specific account.
select*from transactions where account_id=1

--10:Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.SELECT account_id, balance * 3 as interest_accrued
FROM accounts
WHERE account_type = 'savings';

--11:Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.
select * from accounts where balance<1000

--12:Write a SQL query to Find customers not living in a specific city.
select first_name,address from Customers where address not in ('chennai')

select*from Transactions
select*from Accounts
select*from Customers

--TASK 3:
--1. Write a SQL query to Find the average account balance for all customers.
select avg(balance) as averagebalance from Accounts

--2. Write a SQL query to Retrieve the top 10 highest account balances
select * from Accounts 
order by balance DESC

--3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
select sum(amount)as total_deposits from Transactions 
where transaction_type='deposit' and transaction_date = '2024-01-10'

--4:Write a SQL query to Find the Oldest and Newest Customers.
select min(DOB) as oldest_customer_dob,max(DOB) as newest_customer_dob from Customers

--5:Write a SQL query to Retrieve transaction details along with the account type
select t.*,a.account_type
from transactions t
join accounts a on a.account_id=t.account_id
		 
--6:Write a SQL query to Get a list of customers along with their account details
select c.*,account_type,balance from customers c
join accounts a on c.customer_id=a.customer_id

--7:Write a SQL query to Retrieve transaction details along with customer information for a specific account
select c.first_name,c.last_name,c.email ,t.* from Transactions t  
join Accounts a on t.account_id=a.account_id
join Customers c on a.customer_id=c.customer_id
where transaction_id=203

--8:Write a SQL query to Identify customers who have more than one account.
select customer_id from accounts group by customer_id having count(*)>1

--9:Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.
select account_id, 
sum(CASE WHEN transaction_type = 'deposit' THEN amount ELSE 0 END) -
sum(CASE WHEN transaction_type = 'withdrawal' THEN amount ELSE 0 END) AS difference
from Transactions
group by account_id;

--10:Write a SQL query to Calculate the average daily balance for each account over a specified period.
select account_id, avg(balance) as avg_daily_bal
from Accounts
group by account_id;

--11: Calculate the total balance for each account type
select account_type,sum(balance) as total_balance 
from Accounts
group by account_type

--12:. Identify accounts with the highest number of transactions order by descending order.
select account_id, COUNT(*) AS transaction_count
from Transactions
group by account_id
order by transaction_count DESC;

13:--List customers with high aggregate account balances, along with their account types.
select c.customer_id,c.first_name,a.account_type,SUM(t.amount) AS total_balance
from customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
group by c.customer_id, c.first_name, a.account_type
order by total_balance DESC


14:--Identify and list duplicate transactions based on transaction amount, date, and account.
select account_id, transaction_type, amount, transaction_date, count(*) as count
from Transactions 
group by account_id, transaction_type, amount, transaction_date
having count(*) > 1
order by account_id, transaction_date

select*from customers
select*from accounts
select*from Transactions

--TASK 4:
--1. Retrieve the customer(s) with the highest account balance.
select first_name,last_name from Customers 
where customer_id in (
select customer_id from Accounts
where balance=(SELECT MAX(balance) FROM accounts))

--2. Calculate the average account balance for customers who have more than one account.
select customer_id,avg(tot_bal) as avg_bal
from(select customer_id,sum(balance) as tot_bal
from Accounts
group by customer_id
having COUNT(account_id)>1) as acc_bal
group by customer_id

--3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
select account_id from transactions 
where amount>(
select avg(amount) from transactions)

--4. Identify customers who have no recorded transactions.
select customer_id, first_name from customers 
where customer_id not in(
select distinct customer_id from transactions)

--5. Calculate the total balance of accounts with no recorded transactions.
select customer_id,sum(balance) as totalbal from accounts
where customer_id not in(
select distinct customer_id from transactions)
group by customer_id

--6. Retrieve transactions for accounts with the lowest balance.
select *from transactions 
where amount=(
select min(amount) from transactions)

--7. Identify customers who have accounts of multiple types.
select customer_id,first_name  from customers
where customer_id in(
select customer_id from accounts
group by customer_id
having count(DISTINCT account_type) > 1
)

--8. Calculate the percentage of each account type out of the total number of accounts.
select account_type, count(*)*100.0/(select count(*) from accounts) as percentage
from accounts
group by account_type;

--9:Retrieve all transactions for a customer with a given customer_id.
declare @InputCustomer_id int
set @InputCustomer_id=104
select t.transaction_id, t.account_id, t.transaction_type, t.amount, t.transaction_date
from transactions t
where t.account_id in(
select a.account_id from Accounts a
where a.customer_id=@InputCustomer_id)

--10:Calculate the total balance for each account type, including a subquery within the SELECT clause.
select account_type,
    (SELECT SUM(balance) FROM Accounts WHERE Accounts.account_type = A.account_type) AS total_balance
	from Accounts A
group by account_type;









