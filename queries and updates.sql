
use amazondb;

#Query 1: returns all the customer's stored
select customer_id as 'ID',customer_Fname as 'First Name',customer_Lname as 'Last Name',customer_streetAddress as 'Street Address',
				customer_city as 'City',customer_state as 'State',customer_zipcode as 'Zipcode',customer_country as 'Country',
				customer_email as 'E-mail',rewards_member as 'Rewards Member',customer_dateCreated as 'Date Joined'
		from customers;

#Query 2: return info for all products ordered by customer "Bruce Wayne" and the city of the warehouses that shipped them
select order_lines.orders_id as 'Order ID',products.product_id as 'Product ID',products.product_name as 'Product Name',
		shipment_quantity as 'Quantity',(order_line_quantity*product_price) as 'Amount payed', city as 'Shipped From'
		from shipments,order_lines,products,warehouses,customers
		where  #(customer_Fname="Bruce" and customer_Lname="Wayne") and customers.customer_id = shipments.customer_id and
			  shipments.customer_id = (select customer_id from customers where customer_Fname="Bruce" and customer_Lname="Wayne") and
			  shipments.order_line_id = order_lines.order_line_id and
			  order_lines.product_id = products.product_id and
			  warehouses.warehouse_id = shipments.warehouse_id

		group by order_lines.order_line_id;

#Query 3: returns total order information for order_id=305678 plus the order total, total amount of items in the order, and the 
#		  estimated delivery date
select customers.customer_id as 'Customer ID',customer_Fname as 'First Name',customer_Lname as 'Last Name',
		orders.orders_id as 'Order ID', SUM(order_line_quantity*product_price) as 'Order Total', 
		SUM(order_line_quantity) as 'Total Items', estimated_delivery as 'Estimated Delivery Date'			
	from customers,orders,order_lines,products
	where customers.customer_id = orders.customer_id and
		  orders.orders_id = 305678 and
		  order_lines.orders_id = orders.orders_id and
		  order_lines.product_id = products.product_id
	group by order_lines.orders_id;


#Query 4: returns all order line information
select customers.customer_id as 'Customer ID',customer_Fname as 'First Name',customer_Lname as 'Last Name', 
				product_name as 'Product Ordered', products.product_price as 'Price',order_lines.order_line_quantity as 'Qty'
	from customers,orders,order_lines,products
 		where  customers.customer_id = orders.customer_id and 
 			   order_lines.orders_id = orders.orders_id and
 			   products.product_id = order_lines.product_id;


#Query 5: returns total order history (all orders cost and number of items ever ordered) for every customer
select customers.customer_id as 'Customer ID', customer_Fname as 'First Name',customer_Lname as 'Last Name',
	SUM(order_line_quantity*product_price) as 'All Orders - Total',	SUM(order_line_quantity) as 'All Orders - No. Items'
	from customers,orders,order_lines,products
	where customers.customer_id = orders.customer_id and
		  order_lines.orders_id = orders.orders_id and
		  order_lines.product_id = products.product_id
	group by customers.customer_id;


#Query 6: returns info for all international (out of U.S.) customers
select customer_id as 'ID',customer_Fname as 'First Name',customer_Lname as 'Last Name',customer_streetAddress as 'Street Address',
				customer_city as 'City',customer_state as 'State',customer_zipcode as 'Zipcode',customer_country as 'Country',
				customer_email as 'E-mail',rewards_member as 'Rewards Member',customer_dateCreated as 'Date Joined'
		from customers
		where customer_country != "United States";


#Delete 1: delete all customers who joined more than a decade ago
delete from customers where date_sub(now(), interval 10 year) >= customer_dateCreated;

#Query 7: show updated customer table (with delete #1)
select * from customers;

#Update 1: update information for customer Lebron James
update customers 
	set customer_streetAddress="9725 Lake Shore Blvd",customer_city="Cleveland",customer_state="OH",customer_zipcode="44108"
	where customer_Fname="Lebron" and customer_Lname="James";

#Update 2: update rewards member status for customer Evaristo Perez
update customers 
	set rewards_member="yes"
	where customer_Fname="Evaristo" and customer_Lname="Perez";

#Update 3: update address and e-mail information for customer Ricky Rubio
update customers 
	set customer_streetAddress="132-198 1st Ave NE",customer_city="Minneapolis",customer_state="MN",customer_zipcode="55413",
		 customer_country="United States", customer_email="timberwolve9@gmail.com"
	where customer_Fname="Ricky" and customer_Lname="Rubio";

#Insert 1: insert a new customer Walter White
insert into customers(customer_ID,customer_Fname,customer_Lname,customer_streetAddress,customer_city,customer_state,customer_zipcode,
						customer_country,customer_email,rewards_member,customer_dateCreated) values ('9319861','Walter','White',
						'10713 Nelle Ave NE','Albuquerque','NM','87111','United States','bluecrystalcook@yahoo.com','no','2013-04-19');
#Insert 2: insert a new order for customer Walter White
insert into orders(orders_id,date_Placed,estimated_delivery,customer_id) values ('3951177492','2013-04-19','2013-04-25','9319861'); 
#Insert 3,4: add two items to Walter White's order
insert into order_lines(order_line_id,orders_id,product_id,order_line_quantity) values ('4258180024','3951177492','2567','1');
insert into order_lines(order_line_id,orders_id,product_id,order_line_quantity) values ('4258180025','3951177492','43867','1');

#Query 8: show updated customer table
select * from customers;

#Query 9: show updated orders table
select * from orders;

#Query 10: show updated order_lines table
select * from order_lines;

