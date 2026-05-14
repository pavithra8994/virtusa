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
  status varchar(20),
  foreign key (partner_id) references Partners(partner_id)
);

create table deliverylogs (
  log_id int auto_increment primary key,
  shipment_id int,
  log_status varchar(50),
  foreign key (shipment_id) references Shipments(shipment_id)
  );

insert into Partners (partner_name) values
('amazon'),
('zepto'),
('myntra');

insert into Shipments (partner_id, destination_city, promised_date, actual_delivery_date, status) values
(1,'chennai','2026-08-01','2026-08-11','delivered'),
(2,'Hyderabad','2026-08-12','2026-08-12','delivered'),
(1,'Chennai','2026-08-14','2026-08-17','delivered'),
(3,'Mumbai','2026-08-16','2026-08-16','returned'),
(2,'Chennai','2026-08-18','2026-08-19','delivered');

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
select p.partner_name,
count(case when s.status='delivered' then 1 end) as successful,
count(case when s.status='returned' then 1 end) as returned
from shipments s
join partners p on s.partner_id = p.partner_id
group by p.partner_name;

#Identify the most popular "Destination City" for orders placed in the last 30 days to help the warehouse plan truck routes
select destination_city, count(*) 
from shipments
where promised_date >= curdate() - interval 30 day
group by destination_city
order by count(*) desc
limit 1;

#"Partner Scorecard" showing which company has the fewest delays
select p.partner_name,
count(case when s.actual_delivery_date > s.promised_date then 1 end) as delay
from shipments s
join partners p on s.partner_id = p.partner_id
group by p.partner_name
order by delay;

