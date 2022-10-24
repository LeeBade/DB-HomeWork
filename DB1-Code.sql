--DataBase.Homework.1
--2020141460283田峻奇

.open northwind.db

select"

Q1

";
--ans for Q1
select distinct shipname,substr(shipname,1,instr(shipname,'-')-1)
    from 'order'
    where shipname like'%-%'
    order by shipname ;

select "

Q2

";

--ans for Q2
--从集合USA Canada Mexico中选出id，shipcountry，“NorthAmerica”
--从集合选出“OtherPlace”
--id升序，offset 15443，limit 20
select id,shipcountry,"NorthAmerica"
    from 'order'
    where shipcountry='USA' or shipcountry='Canada' or shipcountry='Mexico'
    union 
select id,shipcountry,"OtherPlace"
    from 'Order'
    where shipcountry<>'USA' and shipcountry<>'Canada' and shipcountry<>'Mexico'
    order by id
    limit 20
    offset 5197;

select "

Q3

";
--ans for Q3
--order--"shipvia"--shipper--id匹配

--round(field,2);
select companyname,'|',round(
    (select count(*) from 'order' where ShippedDate > RequiredDate and  'order'.shipvia=shipper.id)*100.0
    /(select count(*) from 'order' where 'order'.shipvia=shipper.id),2)
from shipper
group by companyname;

select "

Q4

";

--ans for Q4
select categoryname,
    (select count(*) from product where category.id=product.categoryid),
    (select avg(unitprice) from product where category.id=product.categoryid),
    (select min(unitprice) from product where category.id=product.categoryid),
    (select max(unitprice) from product where category.id=product.categoryid),
    (select sum(unitsonorder) from product where category.id =product.categoryid)
from Category
group by category.id;

select"

Q5

";

--ans for Q5

select productname,customer.companyname,customer.contactname
from(
    select productname,customerid,min('order'.orderdate)
    from product inner join orderdetail on product.id=orderdetail.productid
    inner join 'order' on 'order'.id=orderdetail.orderid
    where discontinued=1
    group by productname
    )inner join customer on customer.id=customerid
order by productname;

select"

Q6


";

--ans for Q6
select id, orderdate,lag(orderdate,1,0) over(ORDER BY orderdate),round(julianday(orderdate)-julianday(lag(orderdate,1,0) over(ORDER BY orderdate)),2)
from 'order'
where CustomerId like"BLONP"
limit 10;


select"

Q7


";
--ans for Q7
with EachExpend(customerid,expend) as(
    select customerid,sum(quantity*unitprice) as ex
    from orderdetail inner join 'order' on 'order'.id=orderdetail.orderid
    group by customerid
    order by ex
)
,quartile(customerid,expend,buk) as(
    select customerid,expend,ntile(4) over(order by eachexpend.expend)
    from eachexpend
)
select ifnull(companyname,'MISSING_NAME'),customerid,expend
from quartile left outer join customer on customerid=customer.id
where buk=1
order by expend;



select"

Q8


";
--ans for Q8
with Youngest(employeeid,regionid,date) as(
    select employee.id,region.id,max(birthdate)
    from
    employee inner join employeeterritory on employee.id=employeeterritory.employeeid
    inner join territory on employeeterritory.territoryid=territory.id
    inner join region on region.id=territory.regionid
    group by region.id
)
select regionDescription,firstname,lastname,birthdate
from youngest inner join employee on employee.id=youngest.employeeid
    inner join region on youngest.regionid=region.id
order by regionid;



select"

Q9


";
--ans for Q9
with Esp(productname) as(
    select productname
    from product inner join orderdetail on product.id=orderdetail.productid
    inner join 'order' on 'order'.id=orderdetail.orderid
    inner join customer on customer.id='order'.customerid
    where companyname like "Queen Cozinha"
    and orderdate like "2014-12-25%"
    order by product.id
)
select group_concat(productname,',')
from esp;


select"

写的都是垃圾
没有半点优雅可言

";
