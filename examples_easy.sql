#1. Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?
select * from sales s
where amount>2000 and boxes<100;

#2. How many shipments (sales) each of the sales persons had in the month of January 2022?
select p.Salesperson, count(*) as ‘Shipment_Countt’
from sales s
join people p on s.spid = p.spid
where month(SaleDate)=1 and year(SaleDate)=2022
group by p.Salesperson;

#3. Which product sells more boxes? Milk Bars or Eclairs?
select pr.product,sum(boxes) as "total boxes" from sales s
join products pr on pr.pid = s.pid
where pr.Product  in ("Milk Bars","Eclairs")
group by pr.product;

#4. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?
select pr.product,sum(Boxes) as "total box" from sales s
join products pr on pr.pid = s.pid
where pr.Product in ("Milk Bars","Eclairs") and s.SaleDate>="2022-02-01" and s.SaleDate<="2022-02-07"
group by pr.product;

#Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?
select* from sales s
where s.Customers<100 and s.Boxes<100 and weekday(s.SaleDate)=2;
#or
select *,
case when weekday(saledate)=2 then "Wednesday_Shipment"
else ""
end as "W_Shipment"
from sales
where customers < 100 and boxes < 100;

#What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?
select distinct p.Salesperson from sales s 
join people p on s.spid = p.spid
where s.SaleDate>="2022-01-01" and s.SaleDate<="2022-01-07"
order by p.Salesperson;

#Which salespersons did not make any shipments in the first 7 days of January 2022?
select p.Salesperson from people p
where p.spid not in
(select distinct SPID from sales s 
where s.SaleDate between "2022-01-01" and "2022-01-07");

#How many times we shipped more than 1,000 boxes in each month?
select year(saledate),month(saledate),count(*) as "Times we shipped 1k boxes" from sales
where boxes>1000
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);

#— Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?
select year(saledate), month(saledate),
if (sum(Boxes)>1,"yes","no") "Status"
from sales s
join geo g on g.GeoID=s.GeoID
join products pr on pr.pid = s.pid
where pr.product="After Nines" and g.Geo="New Zealand"
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);

#— India or Australia? Who buys more chocolate boxes on a monthly basis?
select g.Geo,year(saledate), month(saledate),sum(boxes) from sales s
join geo g on g.GeoID=s.GeoID
where g.Geo in ("India","Australia")
group by g.Geo,year(saledate), month(saledate);



