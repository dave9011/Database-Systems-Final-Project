drop database if exists amazondb;
create database amazondb;
use amazondb;

#table for products containing each products basic information
drop table if exists products_table;
create table products_table(
	product_id int(5) unsigned not null,
	product_name varchar(50),
	product_description varchar(500),
	product_type varchar(30),
	product_price decimal(10,2),
	product_QOH int(10),
	product_condition varchar(10),
	rating decimal(2,1),
	primary key(product_id)
) ENGINE=INNODB;

#table for the warehouses, contains the general location of each warehouse
drop table if exists warehouses_table;
create table warehouses_table(
	warehouse_id int(5) unsigned not null,
	city varchar(15),
	state varchar (5),
	country varchar(20),
	primary key(warehouse_id)
) ENGINE=INNODB;

#table for all the basic customer information
drop table if exists customers_table;
create table customers_table(
	customer_id int(10) unsigned not null,
	customer_Fname varchar(15),
	customer_Lname varchar(15),
	customer_streetAddress varchar(80),
	customer_city varchar(15),
	customer_state varchar(15),
	customer_zipcode varchar(11),
	customer_country varchar(20),
	customer_email varchar(60),
	rewards_member varchar(4), #yes/no
	customer_dateCreated date, #YYYY-MM-DD
	primary key(customer_id)
) ENGINE=INNODB;

#table for all ordes, has a foreign key that links it to what customer placed that order
drop table if exists orders_table;
create table orders_table(
	orders_id int(20) unsigned not null,
	date_placed date,
	estimated_delivery date,
	customer_id int(10) unsigned not null,
	primary key(orders_id),
	index(customer_id),
	foreign key(customer_id) references customers_table(customer_id) on delete cascade on update cascade
) ENGINE=INNODB;

#the order lines table contains an individual line of an order (there could be 1 or more) and it has two foreign keys that 
#link it to the product in that order line and the order to which it belongs
drop table if exists order_lines_table;
create table order_lines_table(
	order_line_id int(10) unsigned not null,
	orders_id int(20) unsigned not null,
	product_id int(5) unsigned not null,
	order_line_quantity int(5),
	primary key(order_line_id),
	index(orders_id,product_id),
	foreign key(orders_id) references orders_table(orders_id) on delete cascade on update cascade,
	foreign key(product_id) references products_table(product_id) on delete cascade on update cascade
) ENGINE=INNODB;

#table for all shipments; contains foreign keys that link it to what customer the shipment went to, the warehouses that shipped it,
#and what order line was shipped (a shipment isn't a full order, just an order line of that order). we assume that all items in
#the order line are shipped
drop table if exists shipments_table;
create table shipments_table(
	shipment_id int(15) unsigned not null,
	customer_id int(10) unsigned not null,
	order_line_id int(10) unsigned not null,
	warehouse_id int(5) unsigned not null,
	shipment_quantity int(5),
	primary key(shipment_id,customer_id,order_line_id,warehouse_id),
	index(customer_id,order_line_id,warehouse_id),
	foreign key(customer_id) references customers_table(customer_id) on delete cascade on update cascade, 
	foreign key(order_line_id) references order_lines_table(order_line_id) on delete cascade on update cascade,
	foreign key(warehouse_id) references warehouses_table(warehouse_id) on delete cascade on update cascade
) ENGINE=INNODB;

describe customers_table;
describe products_table;
describe orders_table;
describe order_lines_table;
describe shipments_table;
describe warehouses_table;

show tables;

