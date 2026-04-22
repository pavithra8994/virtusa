create database SwiftShip;
use SwiftShip;

create table Partners (
  partner_id int auto_increment primary key,
  partner_name varchar(60)
);

create table Shipments (
  shipment_id int auto_increment primary key,
  partner_id int,
  destination_city varchar(50),
  promised_date date,
  actual_delivery_date date,
  status varchar(20)
);

create table deliverylogs (
  log_id int auto_increment primary key,
  shipment_id int,
  log_status varchar(50)
  );

insert into Partners (partner_name) values
('amazon'),
('zepto'),
('myntra');

insert into Shipments (partner_id, destination_city, promised_date, actual_delivery_date, status) values
(1,'chennai','2026-04-01','2026-04-02','delivered'),
(2,'Hyderabad','2026-04-01','2026-04-01','delivered'),
(1,'Chennai','2026-04-02','2026-04-05','delivered'),
(3,'Mumbai','2026-04-03','2026-04-03','returned'),
(2,'Chennai','2026-04-02','2026-04-04','delivered');

insert into deliverylogs (shipment_id, log_status) values
(1,'picked'),
(1,'in transit'),
(1,'delivered'),
(2,'delivered'),
(3,'delivered'),
(4,'returned'),
(5,'delivered');

select * from Partners;
select* from Shipments;
select* from deliverylogs;

#Write a query to find all shipments where the ActualDeliveryDate is greater than the PromisedDate.
select * 
from shipments
where actual_delivery_date > promised_date;

#Use COUNT and GROUP BY to show how many "Successful" vs. "Returned" deliveries each Partner handled.
select partner_id,
count(case when status='delivered' then 1 end) as successful,
count(case when status='returned' then 1 end) as returned
from shipments
group by partner_id;

#Identify the most popular "Destination City" for orders placed in the last 30 days to help the warehouse plan truck routes
select destination_city, count(*) 
from shipments
where promised_date >= curdate() - interval 30 day
group by destination_city
order by count(*) desc
limit 1;

#"Partner Scorecard" showing which company has the fewest delays
select partner_id,
count(*) as delay
from shipments
where actual_delivery_date > promised_date
group by partner_id
order by count(*);
