# 2
select * from offices where country = 'USA';

# 3
alter table employees add fullName varchar(50);
update employees set fullName = concat(firstName,' ',lastName) where fullname is null;
select * from employees;

# 4
select e.*, o.city, o.state from offices o
left join employees e on e.officeCode = o.officeCode; 

# 5
select o.officeCode, count(e.employeeNumber) from employees e  
left join offices o on e.officeCode = o.officeCode
group by o.officeCode
having count(e.employeeNumber) = 0;

# 6
select count(*) from employees;

# 7
select c.customerNumber, count(p.customerNumber) from payments p 
inner join customers c on p.customerNumber = c.customerNumber 
group by c.customerNumber 
having count(p.customerNumber) <= 3;

# 8
select c.customerNumber, p.paymentDate from payments p 
inner join customers c on p.customerNumber = c.customerNumber 
order by p.paymentDate asc limit 10;

# 9
select c.customerNumber, e.employeeNumber from employees e 
inner join customers c on c.salesRepEmployeeNumber = e.employeeNumber;

# 10
select c.customerNumber, count(p.customerNumber) from payments p 
inner join customers c on p.customerNumber = c.customerNumber
group by c.customerNumber 
order by count(p.customerNumber) desc limit 10;

# 11
select * from orders o where month(orderDate) = 11 and year(orderDate) = 2003;

# 12
insert into employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle) values
(1999,'Hauer','Dan','x9999','dhauer@classicmodelcars.com','1',1002,'VP Sales'),
(2000,'Bond','Jame','x007','jbond@classicmodelcars.com','7',null,'VP Sales');

# 13
insert  into customers(customerNumber,customerName,contactLastName,contactFirstName,phone,addressLine1,addressLine2,city,state,postalCode,country,salesRepEmployeeNumber,creditLimit) values 
(500,'La J Silver','Black','Adam ','098 555 123','21st, Jump St',NULL,'Nantes',NULL,'1734','France',1370,'21000.00'),
(555,'Fire J','Adolf','Hit ','0888 777 21','Berlin State',NULL,'Berlin',NULL,'75016','German',1370,'85800.00');

# 14
update customers set addressLine2 = '31 street Red' where postalCode = '94080';

# 15
update customers set addressLine2 = addressLine1 where addressLine2 is null;

# 16
update customers set state = concat(upper(left(city,1)),substring(city,2,2)) where state is null;

# 17
select c.customerNumber, count(o.customerNumber) from orders o 
inner join customers c on o.customerNumber = c.customerNumber
group by c.customerNumber 
order by count(o.customerNumber) desc limit 10;

# 18
select distinct * from orderdetails o2  
left join orders o on o2.orderNumber = o.orderNumber;

# 19
select * from orderdetails where productCode like 'S10%';

# 20
select p.productCode, count(o.productCode) from orderdetails o 
join products p on o.productCode = p.productCode
group by p.productCode 
order by count(o.productCode) asc limit 11; 

# 21
select distinct * from orders o
join orderdetails o2 on o.orderNumber = o2.orderNumber
join products p on p.productCode = o2.productCode 
join productlines p2 on p2.productLine = p.productLine; 

# 22
insert into products(productCode,productName,productLine,productScale,productVendor,productDescription,quantityInStock,buyPrice,MSRP) values
('S99_1678','1969 Harley Davidson Ultimate Chopper','Motorcycles','1:10','Min Lin Diecast','This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.',7933,'48.81','95.70'),
('S98_1678','1969 Harley Davidson Ultimate Chopper','Motorcycles','1:10','Min Lin Diecast','This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.',7933,'48.81','95.70'),
('S97_1678','1969 Harley Davidson Ultimate Chopper','Motorcycles','1:10','Min Lin Diecast','This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.',7933,'48.81','95.70');

# 23
delete customers from customers
left join orders on customers.customerNumber = orders.customerNumber 
where orderNumber is null;

# 24
select distinct * from customers c 
inner join orders o on c.customerNumber = o.customerNumber 
inner join orderdetails o2 on o2.orderNumber = o.orderNumber;

# 25
select c.customerNumber, count(p.customerNumber) from customers c
inner join payments p on c.customerNumber = p.customerNumber
group by c.customerNumber
order by count(p.customerNumber) desc;

# 26
select c.customerNumber, p.amount from customers c
inner join payments p on c.customerNumber = p.customerNumber
group by c.customerNumber
order by p.amount asc limit 3;

# 27
select p.productCode, count(p2.customerNumber) from products p 
inner join orderdetails o on p.productCode = o.productCode 
inner join orders o2 on o.orderNumber = o2.orderNumber 
inner join customers c on c.customerNumber = o2.customerNumber 
inner join payments p2 on p2.customerNumber = c.customerNumber
group by p.productCode
order by count(p2.customerNumber) desc limit 5;

# 28
select o.customerNumber, p.paymentDate from orders o 
inner join payments p on o.customerNumber = p.customerNumber
group by o.customerNumber 
having year(p.paymentDate) = 2003 and month(p.paymentDate) between 4 and 12;

# 29
select e.officeCode, count(c.salesRepEmployeeNumber) from customers c 
join employees e on c.salesRepEmployeeNumber = e.employeeNumber
join offices o on o.officeCode = e.officeCode
group by o.officeCode
order by count(c.salesRepEmployeeNumber) desc limit 1;

# 30
select * from customers where creditLimit < 20000;

# 31
select * from products
order by quantityInStock desc limit 2;

# 32
select p.productCode, p.buyPrice ,count(c.customerNumber) from products p 
inner join orderdetails o on p.productCode = o.productCode 
inner join orders o2 on o.orderNumber = o2.orderNumber 
inner join customers c on c.customerNumber = o2.customerNumber 
group by p.productCode
order by p.buyPrice asc, count(c.customerNumber) desc limit 10;

# 33
select p.productCode, o.orderNumber, count(o2.status = 'Cancelled') from products p 
inner join orderdetails o on p.productCode = o.productCode
inner join orders o2 on o2.orderNumber = o.orderNumber 
group by p.productCode 
order by count(o2.status = 'Cancelled') desc limit 5;

# 34
select p.productCode, o.orderNumber, datediff(o2.shippedDate, o2.orderDate)  from products p 
inner join orderdetails o on p.productCode = o.productCode
inner join orders o2 on o2.orderNumber = o.orderNumber 
group by p.productCode 
order by datediff(o2.shippedDate, o2.orderDate) asc limit 5;

# 35
select c.customerNumber, sum(if(year(p.paymentDate) = 2004, p.amount, 0)) as creditPay from customers c
inner join payments p on c.customerNumber = p.customerNumber
group by customerNumber
order by customerNumber asc;

# 36
select reportsTo, count(reportsTo) as times from employees where reportsTo is not null
group by reportsTo 
order by times desc limit 2;

# 37 chua biet lam
select p.productCode, o2.requiredDate from products p 
inner join orderdetails o on p.productCode = o.productCode 
inner join orders o2 on o.orderNumber = o2.orderNumber 
having year(o2.requiredDate) <> 2005;
# 38
select * from orders where status = 'Shipped' and datediff(shippedDate , orderDate) <= 3; 

# 39
select * from orders where status = 'Shipped' and year(shippedDate) = 2004 and month(shippedDate) = 12;