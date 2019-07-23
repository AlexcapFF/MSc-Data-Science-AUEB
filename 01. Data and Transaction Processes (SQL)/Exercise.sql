
--Done in MS Server

------------1st question--------------


--check the price of the first product
select model,price, discount_price, (price- price*0.1) as disc_price, (discount_price - discount_price*0.1) as extra_disc_price
from Products
where model ='HP255G6-231';
--check the price of the second product multiplied by 2
select model,price, discount_price, (price- price*0.1)*2 as disc_price, (discount_price - discount_price*0.1)*2 as extra_disc_price
from Products
where model = 'HP6950T87';
--check the store_id
select id
from Stores
where name like '%Γλυφάδα';


insert into Clients(id,	name, surname)
values(10001 ,'Eleni', 'Grigoriadou');
insert into Purchases(id,date, client_id , store_id)
values(1021, '2018-11-22', 10001, 1);

insert into PurchaseProducts(product_model,purchase_id,quantity, price)
values('HP255G6-231', 1021, 1, 332.1);
insert into PurchaseProducts(product_model,purchase_id,quantity, price)
values('HP6950T87', 1021, 2, 153);


------------2nd question--------------

--check the product prices
select pr.model,cast(pr.price + pr.price*0.1 as numeric(10,2))as new_price, cast(pr.discount_price + pr.discount_price*0.1 as numeric(10,2))as new_discount_price
from Companies as c
inner join Products as pr
	on c.id=pr.company_id
where c.name= 'HP';


update Products
set price = 405.90, discount_price = 352.00
where model= 'HP255G6-231';

update Products
set price = 93.50
where model= 'HP6950T87';

------------3rd question--------------

select *
from Stores
where address like '%Αθήνα%';

------------4th question--------------
--name and client_id were added because the question doesn't specify which one should be used

select A.id, A.date,st.name as storename, A.client_id, A.name, A.surname
from (select pur.id, pur.date, pur.client_id, cl.name,cl.surname, pur.store_id
	  from Clients as cl
	  inner join Purchases as pur
		 on pur.client_id=cl.id
	  where date like '2017%') as A
left join stores as st
	on A.store_id=st.id
order by A.date desc;

------------5th question--------------

select *
from Products
where (price - discount_price) > 100;

------------6th question--------------

--I have two solutions for this question

--1st --it is not entirely correct because it doesnt consider the months as seen below
SELECT cast(DATEDIFF(year, '2017/08/25', '2018/11/29') as numeric(4,2)) as WRONG_RESULT;

SELECT *
from clients
where DATEDIFF(year, birthdate, GETUTCDATE()) <30;

--2nd --it takes the months into account. I've multiplied with 12 to turn all quantities to months
select * --add this ---((month(GETUTCDATE())+ year(GETUTCDATE())*12) - (month(birthdate)+ year(birthdate)*12))/12---  in the select for crosscheck
from Clients
where (month(GETUTCDATE())+ year(GETUTCDATE())*12) - (month(birthdate)+ year(birthdate)*12) < 30*12;

------------7th question--------------
--excluded
------------8th question--------------

select product_model, sum(quantity) as Pr_Sum
from PurchaseProducts
where product_model = 'T255G6-433'
group by product_model;


------------9th question--------------


select B.id, B.date,B.storename, B.client_id, B.name, B.surname, count(distinct ppr.product_model) as Model_Count, sum(ppr.quantity) as Total_Quantity
from	(select A.id, A.date,st.name as storename, A.client_id, A.name, A.surname
	  	 from (select pur.id, pur.date, pur.client_id, cl.name,cl.surname, pur.store_id
			   from Clients as cl
			   inner join Purchases as pur
				  on pur.client_id=cl.id) as A
		 left join stores as st
			 on A.store_id=st.id) as B
inner join [dbo].[PurchaseProducts] as ppr
	on ppr.purchase_id = B.id
group by B.id, B.date,B.storename, B.client_id, B.name, B.surname;


------------10th question--------------

select cl.*
from clients as cl
left join Purchases as pr
	on pr.client_id=cl.id
where (pr.id is null and pr.date is null and pr.client_id is null and pr.store_id is null);


------------11th question--------------


create table PLAYERS(
		ID nvarchar(10) NOT NULL,
		Name nvarchar(250) NULL,
		Position nvarchar(10) NULL,
		Skill_Level integer NULL,

PRIMARY KEY(ID),
CHECK(Skill_Level >0),
CHECK(Skill_Level <= 100)
);

create table TEAMS(
		ID nvarchar(20) NOT NULL,
		Name nvarchar(250) NOT NULL,
		City nvarchar(50) NOT NULL,
		Player_ID nvarchar(10) NULL,

PRIMARY KEY(ID),
UNIQUE (Player_ID),
FOREIGN KEY(Player_ID) references PLAYERS(ID)
)

create table GAMES(
		ID nvarchar(10) NOT NULL,
		Date datetime NOT NULL,
		City nvarchar(50) NOT NULL,
		Team_ID nvarchar(20) NOT NULL,
		Score integer NOT NULL,

PRIMARY KEY(ID, Date, City, Team_ID),
CHECK(Score >=0),
FOREIGN KEY(Team_ID) references TEAMS(ID)
);