
#use the Amazon-like database created
use amazondb;

#drop warehouses table if exists,create a table like it, and load into it the warehouses data from file
#data is separated by commas and each row data is in a line of the file (a field's data might be enclosed in "'s)
drop table if exists warehouses;
create table warehouses like warehouses_table;
load data local infile 'C:\\Users\\AnaMarta\\Documents\\UCF\\Spring 2013\\Database Systems\\AmazonDB- Folder\\warehouse.txt' 
	into table warehouses
		fields terminated by ','
		lines terminated by '\r\n';
#show the populated table
select * from warehouses;

#drop products table if exists,create a table like it, and load into it the products data from file
#data is separated by commas and each row data is in a line of the file (a field's data might be enclosed in "'s)
drop table if exists products;
create table products like products_table;
load data local infile 'C:\\Users\\AnaMarta\\Documents\\UCF\\Spring 2013\\Database Systems\\AmazonDB- Folder\\products.txt' 
	into table products
		fields terminated by ','
		optionally enclosed by '"'
		lines terminated by '\r\n';
#show the populated table
select * from products;

#drop customers table if exists,create a table like it, and load into it the customer data from file
#data is separated by commas and each row data is in a line of the file (a field's data might be enclosed in "'s)
drop table if exists customers;
create table customers like customers_table;
load data local infile 'C:\\Users\\AnaMarta\\Documents\\UCF\\Spring 2013\\Database Systems\\AmazonDB- Folder\\customers.txt'
	into table customers 
		fields terminated by ','
		optionally enclosed by '"'
		lines terminated by '\r\n';
#show the populated table
 select * from customers;

#drop orders table if exists,create a table like it, and load into it the orders data from file
#data is separated by commas and each row data is in a line of the file (a field's data might be enclosed in "'s)
drop table if exists orders;
create table orders like orders_table;
load data local infile 'C:\\Users\\AnaMarta\\Documents\\UCF\\Spring 2013\\Database Systems\\AmazonDB- Folder\\orders.txt'
	into table orders 
		fields terminated by ','
		optionally enclosed by '"'
		lines terminated by '\r\n';
#show the populated table
select * from orders;

#drop order lines table if exists,create a table like it, and load into it the order lines data from file
#data is separated by commas and each row data is in a line of the file (a field's data might be enclosed in "'s)
drop table if exists order_lines;
create table order_lines like order_lines_table;
load data local infile 'C:\\Users\\AnaMarta\\Documents\\UCF\\Spring 2013\\Database Systems\\AmazonDB- Folder\\order_lines.txt'
	into table order_lines 
		fields terminated by ','
		optionally enclosed by '"'
		lines terminated by '\r\n';
#show the populated table
select * from order_lines;

#drop shipments table if exists,create a table like it, and load into it the shipments data from file
#data is separated by commas and each row data is in a line of the file (a field's data might be enclosed in "'s)
drop table if exists shipments;
create table shipments like shipments_table;
load data local infile 'C:\\Users\\AnaMarta\\Documents\\UCF\\Spring 2013\\Database Systems\\AmazonDB- Folder\\shipment.txt'
	into table shipments 
		fields terminated by ','
		optionally enclosed by '"'
		lines terminated by '\r\n';
#show the populated table
select * from shipments;



							