drop database if exists sql_workbench ;
create database `awesome chocolates`;
use `awesome chocolates`;

#1) Sales details where amount>10000
select * from Sales
where amount>10000;
order by amount desc; 

#2) Sales details where Products to be sold in gegraphical location G1
select * from Sales
where geoid="G1"
order by amount;

#3) Sales details with amount>10000 and SaleDate on or after 2022-01-01;
select * from Sales
where amount>10000 and SaleDate>=2022-01-01;

#4) Sales details with amount>10000 and year as 2022
select SaleDate,amount from Sales
where amount>10000 and year(SaleDate)=2022
order by amount;

#5) Sales details for boxes upto 50
select * from sales
where boxes between 0 and 50;
#or
select * from sales
where boxes > 0 and boxes<=50;

#6) Sales details where amount 2,000 and count of boxes<100
select * from sales
where amount>2000 and boxes<100;

#7) Sales details in January 2022
select * from sales
where month(SaleDate)= 1 and year(SaleDate)=2022;

#8) Sales details when the product shipment on fridays
select * from sales
where weekday(SaleDate)=4;

#9) People details which team is of Delish or jucies
select * from people
where team="Delish" or team="Jucies";
#or
select * from people
where team in ("Delish","Jucies");

#10) People details whose name start with letter B 
select * from people
where Salesperson like "B%";  

#11) People details who has y anywhere in their name
select * from people
where Salesperson like "%y%";  

#12) Creating a category column for amount if amount<1000 as "Under 1k",if amount<5000 as "Under 5k",if amount<10000 as "Under 10k",others as ">=10k"
select SaleDate,amount,
        case when amount<1000 then "Under 1k"
        when amount<5000 then "Under 5k"
        when amount<10000 then "Under 10k"
        else "10k or more"
        end as "Amount category"
from sales;
select curdate()

#13) Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?
select * from sales s
where amount>2000 and boxes<100;

#14) How many shipments (sales) each of the sales persons had in the month of January 2022?
select p.Salesperson, count(*) as ‘Shipment_Countt’
from sales s
join people p on s.spid = p.spid
where month(SaleDate)=1 and year(SaleDate)=2022
group by p.Salesperson;

#15) Which product sells more boxes? Milk Bars or Eclairs?
select pr.product,sum(boxes) as "total boxes" from sales s
join products pr on pr.pid = s.pid
where pr.Product  in ("Milk Bars","Eclairs")
group by pr.product;

#16) Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?
select pr.product,sum(Boxes) as "total box" from sales s
join products pr on pr.pid = s.pid
where pr.Product in ("Milk Bars","Eclairs") and s.SaleDate>="2022-02-01" and s.SaleDate<="2022-02-07"
group by pr.product;

#17) Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?
select* from sales s
where s.Customers<100 and s.Boxes<100 and weekday(s.SaleDate)=2;
#or
select *,
case when weekday(saledate)=2 then "Wednesday_Shipment"
else ""
end as "W_Shipment"
from sales
where customers < 100 and boxes < 100;

#18) What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?
select distinct p.Salesperson from sales s 
join people p on s.spid = p.spid
where s.SaleDate>="2022-01-01" and s.SaleDate<="2022-01-07"
order by p.Salesperson;

#19) Which salespersons did not make any shipments in the first 7 days of January 2022?
select p.Salesperson from people p
where p.spid not in
(select distinct SPID from sales s 
where s.SaleDate between "2022-01-01" and "2022-01-07");

#20) How many times we shipped more than 1,000 boxes in each month?
select year(saledate),month(saledate),count(*) as "Times we shipped 1k boxes" from sales
where boxes>1000
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);

#21) Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?
select year(saledate), month(saledate),
if (sum(Boxes)>1,"yes","no") "Status"
from sales s
join geo g on g.GeoID=s.GeoID
join products pr on pr.pid = s.pid
where pr.product="After Nines" and g.Geo="New Zealand"
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);

#22) India or Australia? Who buys more chocolate boxes on a monthly basis?
select g.Geo,year(saledate), month(saledate),sum(boxes) from sales s
join geo g on g.GeoID=s.GeoID
where g.Geo in ("India","Australia")
group by g.Geo,year(saledate), month(saledate);
