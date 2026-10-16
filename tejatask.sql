create database if not exists mysql_assignment;
use mysql_assignment;

create table if not exists customers (
    customer_id int primary key auto_increment,
    name varchar(50),
    city varchar(50)
);

create table if not exists accounts (
    account_id int primary key auto_increment,
    customer_id int,
    account_type varchar(20),
    balance decimal(10,2),
    foreign key (customer_id) references customers(customer_id)
);

insert into customers (name, city) values
('janani', 'chennai'),
('arun', 'coimbatore'),
('priya', 'madurai'),
('karthik', 'salem');

insert into accounts (customer_id, account_type, balance) values
(1, 'savings', 50000),
(1, 'current', 20000),
(2, 'savings', 30000),
(3, 'savings', 15000),
(4, 'current', 40000);

create table if not exists trains (
    train_id int primary key auto_increment,
    train_name varchar(50),
    source varchar(50),
    destination varchar(50)
);

create table if not exists bookings (
    booking_id int primary key auto_increment,
    train_id int,
    passenger_name varchar(50),
    fare decimal(10,2),
    status varchar(20),
    foreign key (train_id) references trains(train_id)
);

insert into trains (train_name, source, destination) values
('express1', 'chennai', 'madurai'),
('express2', 'coimbatore', 'salem'),
('express3', 'madurai', 'chennai');

insert into bookings (train_id, passenger_name, fare, status) values
(1, 'janani', 500, 'confirmed'),
(1, 'arun', 500, 'waiting'),
(2, 'priya', 300, 'confirmed'),
(3, 'karthik', 450, 'cancelled'),
(2, 'meena', 300, 'confirmed');

create table if not exists employee (
    emp_id int primary key,
    emp_name varchar(50),
    department varchar(30),
    salary decimal(10,2),
    city varchar(30),
    joining_date date
);

insert into employee values
(101, 'john', 'it', 60000, 'chennai', '2022-01-15'),
(102, 'david', 'hr', 45000, 'bangalore', '2021-03-10'),
(103, 'smith', 'it', 70000, 'chennai', '2020-07-12'),
(104, 'mary', 'finance', 55000, 'mumbai', '2023-01-20'),
(105, 'james', 'hr', 48000, 'delhi', '2022-05-05'),
(106, 'linda', 'finance', 65000, 'mumbai', '2021-08-18');

create table if not exists customers_orders (
    customer_id int primary key,
    customer_name varchar(50),
    city varchar(30)
);

create table if not exists orders (
    order_id int primary key,
    customer_id int,
    amount decimal(10,2),
    order_date date,
    foreign key (customer_id) references customers_orders(customer_id)
);

create table if not exists students (
    student_id int primary key,
    student_name varchar(50),
    department varchar(30),
    marks int
);

select * from accounts where balance > 20000;

select * from customers where city = 'chennai';

select * from accounts where balance between 20000 and 50000;

select * from customers where name like 'j%';

select * from accounts where account_type in ('savings', 'current');

select * from accounts where account_type <> 'savings';

select * from customers where name like '%a%';

select * from accounts where balance <= 30000;

select * from customers where city <> 'madurai';

select * from accounts where balance not between 10000 and 40000;

select * from customers where name like '%i';

select * from accounts where balance = 50000;

select * from customers where city in ('chennai', 'salem');

select * from accounts where balance > 10000 and balance < 40000;

select * from accounts where account_type not in ('current');

select * from accounts order by balance desc;

select * from customers order by name asc;

select * from accounts order by account_type asc, balance desc;

select sum(balance) as total_balance from accounts;

select avg(balance) as average_balance from accounts;

select max(balance) as maximum_balance from accounts;

select min(balance) as minimum_balance from accounts;

select count(*) as total_customers from customers;

select account_type, sum(balance) as total_balance
from accounts
group by account_type;

select account_type, avg(balance) as average_balance
from accounts
group by account_type;

select account_type, avg(balance) as average_balance
from accounts
group by account_type
having avg(balance) > 20000;

select customer_id, count(*) as account_count
from accounts
group by customer_id;

select c.customer_id, c.name, count(a.account_id) as account_count
from customers c
join accounts a on c.customer_id = a.customer_id
group by c.customer_id, c.name
having count(a.account_id) > 1;

select c.name, a.balance
from customers c
join accounts a on c.customer_id = a.customer_id;

select c.customer_id, c.name, c.city, a.account_id, a.account_type, a.balance
from customers c
left join accounts a on c.customer_id = a.customer_id;

select a.*, c.name, c.city
from accounts a
join customers c on a.customer_id = c.customer_id;

select c.name, a.account_type
from customers c
join accounts a on c.customer_id = a.customer_id
where a.balance > 20000;

select c.customer_id, c.name, coalesce(sum(a.balance), 0) as total_balance
from customers c
left join accounts a on c.customer_id = a.customer_id
group by c.customer_id, c.name;

select c.name, a.balance
from customers c
join accounts a on c.customer_id = a.customer_id
order by a.balance asc;

select c.city, count(a.account_id) as account_count
from customers c
left join accounts a on c.customer_id = a.customer_id
group by c.city;

select * from accounts
where balance > (select avg(balance) from accounts);

select * from customers
where customer_id in (select customer_id from accounts);

select * from customers
where customer_id not in (select customer_id from accounts);

select * from accounts
where balance = (select max(balance) from accounts);

select c.customer_id, c.name, sum(a.balance) as total_balance
from customers c
join accounts a on c.customer_id = a.customer_id
group by c.customer_id, c.name
having sum(a.balance) > 40000;

select * from bookings where fare > 400;

select * from bookings where status <> 'confirmed';

select * from trains where source = 'chennai';

select * from bookings where fare between 300 and 500;

select * from bookings where passenger_name like 'a%';

select t.train_name, b.passenger_name
from trains t
join bookings b on t.train_id = b.train_id;

select t.train_id, t.train_name, count(b.booking_id) as booking_count
from trains t
left join bookings b on t.train_id = b.train_id
group by t.train_id, t.train_name;

select t.train_name, coalesce(sum(b.fare), 0) as total_fare
from trains t
left join bookings b on t.train_id = b.train_id
group by t.train_id, t.train_name;

select * from bookings
where fare = (select max(fare) from bookings);

select t.train_id, t.train_name, count(b.booking_id) as booking_count
from trains t
join bookings b on t.train_id = b.train_id
group by t.train_id, t.train_name
having count(b.booking_id) > 1;

select department, count(*) as employee_count
from employee
group by department;

select department, avg(salary) as average_salary
from employee
group by department;

select department, count(*) as employee_count
from employee
group by department
having count(*) > 1;

select department, max(salary) as highest_salary
from employee
group by department;

select department, min(salary) as lowest_salary
from employee
group by department;

select department, avg(salary) as average_salary
from employee
group by department
having avg(salary) > 50000;

select department, sum(salary) as total_salary
from employee
group by department;

select * from employee order by salary desc;

select * from employee order by department asc, salary desc;

select city, count(*) as employee_count
from employee
group by city
having count(*) > 1;

select city, sum(salary) as total_salary
from employee
group by city;

select department, sum(salary) as total_salary
from employee
group by department
order by total_salary desc;

select department, count(*) as employee_count
from employee
where salary > 50000
group by department;

select department, max(salary) - min(salary) as salary_difference
from employee
group by department;

select * from employee order by salary desc limit 3;

select c.customer_id, c.customer_name, coalesce(sum(o.amount), 0) as total_amount
from customers_orders c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

select c.customer_id, c.customer_name, count(o.order_id) as order_count
from customers_orders c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having count(o.order_id) > 3;

select c.customer_id, c.customer_name, avg(o.amount) as average_amount
from customers_orders c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

select c.customer_id, c.customer_name, max(o.amount) as highest_order
from customers_orders c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

select c.customer_id, c.customer_name, coalesce(sum(o.amount), 0) as total_purchase
from customers_orders c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
order by total_purchase desc;

select c.customer_id, c.customer_name, sum(o.amount) as total_purchase
from customers_orders c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having sum(o.amount) > 10000;

select c.customer_name, count(o.order_id) as order_count
from customers_orders c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

select c.customer_id, c.customer_name, sum(o.amount) as total_spent
from customers_orders c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having sum(o.amount) = (
    select max(total_amount)
    from (
        select sum(amount) as total_amount
        from orders
        group by customer_id
    ) as customer_totals
);

select c.customer_id, c.customer_name, count(o.order_id) as order_count
from customers_orders c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having count(o.order_id) = (
    select max(order_count)
    from (
        select count(*) as order_count
        from orders
        group by customer_id
    ) as order_counts
);

select c.customer_id, c.customer_name, avg(o.amount) as average_amount
from customers_orders c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having avg(o.amount) > 2000;

select c.customer_id, c.customer_name, sum(o.amount) as total_purchase
from customers_orders c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
order by total_purchase desc
limit 5;

select c.customer_id, c.customer_name, min(o.amount) as minimum_order
from customers_orders c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

select c.customer_id, c.customer_name, sum(o.amount) as total_purchase
from customers_orders c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having sum(o.amount) > 5000;

select c.customer_id, c.customer_name,
       count(o.order_id) as total_orders,
       coalesce(sum(o.amount), 0) as total_purchase
from customers_orders c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

select c.customer_id, c.customer_name,
       count(o.order_id) as total_orders,
       sum(o.amount) as total_purchase
from customers_orders c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having count(o.order_id) > 2 and sum(o.amount) > 8000;

select department, avg(marks) as average_marks
from students
group by department;

select department, avg(marks) as average_marks
from students
group by department
having avg(marks) > 75;

select department, max(marks) as highest_mark
from students
group by department;

select department, count(*) as student_count
from students
group by department;

select department, count(*) as student_count
from students
group by department
having count(*) > 5;

select department, avg(marks) as average_marks
from students
group by department
order by average_marks desc;

select department, avg(marks) as average_marks
from students
group by department
order by average_marks desc
limit 3;

select department, avg(marks) as average_marks
from students
group by department
having avg(marks) between 70 and 90;

select department, sum(marks) as total_marks
from students
group by department;

select department, count(*) as student_count
from students
group by department
order by student_count desc;

select department, min(marks) as lowest_mark
from students
group by department;

select department, max(marks) as highest_mark
from students
group by department
having max(marks) > 90;

select department, count(*) as student_count
from students
where marks > 80
group by department;

select department, count(*) as student_count
from students
where marks > 75
group by department
having count(*) > 3;

select department, max(marks) as highest_mark
from students
group by department
order by highest_mark desc;