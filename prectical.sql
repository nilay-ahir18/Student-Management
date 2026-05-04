create database event_management;
use event_management;

create table events (
    event_id int primary key auto_increment,
    event_name varchar(100),
    event_date date,
    venue_id int,
    organizer_id int,
    ticket_price decimal(10,2),
    total_seats int,
    available_seats int
);

insert into events (event_name, event_date, venue_id, organizer_id, ticket_price, total_seats, available_seats) values
('music fest', '2026-06-10', 1, 1, 500, 100, 80),
('tech summit', '2026-07-15', 2, 2, 1000, 200, 150),
('food carnival', '2026-05-20', 3, 3, 300, 150, 50),
('business meet', '2026-08-05', 4, 4, 700, 120, 20),
('startup expo', '2026-09-12', 5, 5, 400, 180, 90);

create table venues (
    venue_id int primary key auto_increment,
    venue_name varchar(100),
    location varchar(100),
    capacity int
);

insert into venues (venue_name, location, capacity) values
('city hall', 'ahmedabad', 500),
('grand arena', 'surat', 800),
('open ground', 'rajkot', 1000),
('conference center', 'vadodara', 300),
('expo hall', 'gandhinagar', 600);

create table organizers (
    organizer_id int primary key auto_increment,
    organizer_name varchar(100),
    contact_email varchar(100),
    phone_number varchar(15)
);

insert into organizers (organizer_name, contact_email, phone_number) values
('abc events', 'abc@gmail.com', '9876543210'),
('star group', 'star@gmail.com', '9876501234'),
('elite planners', 'elite@gmail.com', '9812345678'),
('prime events', 'prime@gmail.com', '9823456789'),
('event pro', 'pro@gmail.com', '9834567890');

create table attendees (
    attendee_id int primary key auto_increment,
    name varchar(100),
    email varchar(100),
    phone_number varchar(15)
);

insert into attendees (name, email, phone_number) values
('rahul', 'rahul@gmail.com', '9000000001'),
('neha', 'neha@gmail.com', '9000000002'),
('amit', 'amit@gmail.com', '9000000003'),
('priya', 'priya@gmail.com', '9000000004'),
('karan', 'karan@gmail.com', '9000000005');


create table tickets (
    ticket_id int primary key auto_increment,
    event_id int,
    attendee_id int,
    booking_date date,
    status varchar(20),
    foreign key (event_id) references events(event_id),
    foreign key (attendee_id) references attendees(attendee_id)
);


insert into tickets (event_id, attendee_id, booking_date, status) values
(1, 1, '2026-05-01', 'confirmed'),
(2, 2, '2026-05-02', 'confirmed'),
(3, 3, '2026-05-03', 'cancelled'),
(4, 4, '2026-05-04', 'confirmed'),
(5, 5, '2026-05-05', 'pending');


create table payments (
    payment_id int primary key auto_increment,
    ticket_id int,
    amount_paid decimal(10,2),
    payment_status varchar(20),
    payment_date datetime,
    foreign key (ticket_id) references tickets(ticket_id)
);


insert into payments (ticket_id, amount_paid, payment_status, payment_date) values
(1, 500, 'success', '2026-05-01 10:00:00'),
(2, 1000, 'success', '2026-05-02 11:00:00'),
(3, 300, 'failed', '2026-05-03 12:00:00'),
(4, 700, 'success', '2026-05-04 01:00:00'),
(5, 400, 'pending', '2026-05-05 02:00:00');



-- update
update events
set ticket_price = 600
where event_id = 1;

-- delete
delete from events
where event_id = 1;

-- select
select * from events;

-- upcoming events in city
select e.*
from events e
join venues v on e.venue_id = v.venue_id
where v.location = 'ahmedabad'
and e.event_date > curdate();

-- top 5 revenue events
select e.event_name, sum(p.amount_paid) as revenue
from events e
join tickets t on e.event_id = t.event_id
join payments p on t.ticket_id = p.ticket_id
where p.payment_status = 'success'
group by e.event_id
order by revenue desc
limit 5;

-- attendees in last 7 days
select distinct a.*
from attendees a
join tickets t on a.attendee_id = t.attendee_id
where t.booking_date >= curdate() - interval 7 day;

-- december events + 50% seats available
select *
from events
where month(event_date) = 12
and available_seats > total_seats * 0.5;

-- attendees booked OR pending payment
select distinct a.*
from attendees a
join tickets t on a.attendee_id = t.attendee_id
left join payments p on t.ticket_id = p.ticket_id
where t.status = 'confirmed'
or p.payment_status = 'pending';

-- not fully booked
select *
from events
where available_seats > 0;

-- sort events by date
select *
from events
order by event_date asc;

-- attendees per event
select event_id, count(attendee_id) as total_attendees
from tickets
group by event_id;

-- revenue per event
select e.event_name, sum(p.amount_paid) as total_revenue
from events e
join tickets t on e.event_id = t.event_id
join payments p on t.ticket_id = p.ticket_id
group by e.event_id;

-- total revenue
select sum(amount_paid) as total_revenue
from payments;

-- event with max attendees
select event_id, count(attendee_id) as total
from tickets
group by event_id
order by total desc
limit 1;

-- avg ticket price
select avg(ticket_price) as avg_price
from events;

-- inner join
select e.event_name, v.venue_name
from events e
inner join venues v on e.venue_id = v.venue_id;

-- left join (no payment)
select a.name
from attendees a
join tickets t on a.attendee_id = t.attendee_id
left join payments p on t.ticket_id = p.ticket_id
where p.payment_id is null;

-- right join (events without attendees)
select e.event_name
from tickets t
right join events e on t.event_id = e.event_id
where t.ticket_id is null;

-- revenue above average
select event_name
from events
where event_id in (
    select t.event_id
    from tickets t
    join payments p on t.ticket_id = p.ticket_id
    group by t.event_id
    having sum(p.amount_paid) >
    (select avg(amount_paid) from payments)
);

-- attendees booked multiple events
select attendee_id
from tickets
group by attendee_id
having count(distinct event_id) > 1;


-- extract month
select event_name, month(event_date) as event_month
from events;

-- days remaining
select event_name,
datediff(event_date, curdate()) as days_left
from events;

-- format date
select date_format(payment_date, '%Y-%m-%d %H:%i:%s')
from payments;

-- uppercase
select upper(organizer_name) from organizers;

-- trim
select trim(name) from attendees;

-- replace null
select ifnull(email, 'not provided') from attendees;

-- rank events by revenue
select event_id,
sum(amount_paid) as revenue,
rank() over(order by sum(amount_paid) desc) as rank_no
from tickets t
join payments p on t.ticket_id = p.ticket_id
group by event_id;

-- running total attendees
select event_id,
count(*) as total,
sum(count(*)) over(order by event_id) as running_total
from tickets
group by event_id;

select event_name,
case
    when available_seats < total_seats * 0.2 then 'high demand'
    when available_seats between total_seats * 0.2 and total_seats * 0.5 then 'moderate demand'
    else 'low demand'
end as demand_status
from events;

select payment_status,
case
    when payment_status = 'success' then 'successful'
    when payment_status = 'failed' then 'failed'
    else 'pending'
end as final_status
from payments;