use repositry;
## Qeury number1
## Adding foreign keys to persondetails table 
ALTER TABLE `repositry`.`persondetails` 
ADD CONSTRAINT `vehicleid`
  FOREIGN KEY (`vehicleid`)
  REFERENCES `repositry`.`vehicledetails` (`vehicletype`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


## Query number 2
## split the composite key date into date month year... and remove the column date of stop
create or replace view split_date as  
SELECT 
    CASE
        WHEN LOCATE('/',dateofstop )>0 
			THEN SUBSTRING_INDEX((SUBSTRING_INDEX(dateofstop,'/',1)),'/',-1)
        WHEN LOCATE('-', dateofstop)>0 
			THEN SUBSTRING_INDEX((SUBSTRING_INDEX(dateofstop,'-',1)),'-',-1)
    END as months,
    CASE
        WHEN LOCATE('/',dateofstop )>0 
			THEN SUBSTRING_INDEX((SUBSTRING_INDEX(dateofstop,'/',2)),'/',-1)
        WHEN LOCATE('-', dateofstop)>0 
			THEN SUBSTRING_INDEX((SUBSTRING_INDEX(dateofstop,'-',2)),'-',-1)
    END as days,
    CASE
        WHEN LOCATE('/',dateofstop )>0 
			THEN SUBSTRING_INDEX((SUBSTRING_INDEX(dateofstop,'/',3)),'/',-1)
        WHEN LOCATE('-', dateofstop)>0 
			THEN SUBSTRING_INDEX((SUBSTRING_INDEX(dateofstop,'-',3)),'-',-1)
    END as years,  
        CASE
        WHEN LOCATE(':',timeofstop )>0 
			THEN SUBSTRING_INDEX((SUBSTRING_INDEX(timeofstop,':',1)),':',-1)
    END as hours,
            CASE
        WHEN LOCATE(':',timeofstop )>0 
			THEN SUBSTRING_INDEX((SUBSTRING_INDEX(timeofstop,':',2)),':',-1)
    END as minutes
    
FROM violations;

## Query number 3
## Count the number of violations in each month
select months, count(*) as count from split_date group by months ORDER BY count DESC;

## Query number 4
## find the number of people of certain age were involved in accident without consumption of alcohol
SELECT  accident, gender, alcohol , age, count(*)
FROM persondetails
JOIN violations 
ON  persondetails.personid = violations.personid
WHERE violations.alcohol = "No" and violations.accident = "Yes"
group by age ORDER BY age ASC ;

## Query numnber 5
## Creating a view belts_violations where the violation is belts from persondetails and violations tables using joins
CREATE OR REPLACE VIEW belts_violations AS  
SELECT persondetails.personid, age, gender, race, dateofstop, timeofstop, accident, belts 
FROM persondetails
INNER JOIN violations 
ON  persondetails.personid = violations.personid
WHERE belts = 'Yes';
SELECT * FROM belts_violations;

## query number 6
## Number of violations per city in descending order
select drivercity, count(*) as count
from persondetails
group by drivercity
order by  count DESC;

## Query number 7
## Number of Male caught in violations order by age
create or replace view view1 as 
select personid, age, Gender
from persondetails
where gender = "M"
order by age;
select * from view1;

## Query number 8
## From view1 find the number  of total male of particular age in violations
select age, count(*) as total   from view1
group by age
order by total DESC;
## For which age there are most violations
select age, count(*) as total from view1 group by age order by count(*) desc limit 1;

## Query number 9
## Create a view from persondetails and violations tables where property is damaged
CREATE OR REPLACE VIEW view2 AS  
SELECT persondetails.personid, persondetails.vehicleid,  violations.propertydamge
FROM persondetails, violations  
WHERE persondetails.personid = violations.personid and propertydamge="Yes";
select * from view2;
select count(*) from view2;

## Query number 10 
## Number of violations handled by each police
select distinct policeid, count(*) as total from persondetails
group by policeid
order by total desc; 

## Query number 11
## Find the vehicles of white color ordered by year  
SELECT vehicledetails.year as years,vehicledetails.make, vehicledetails.model, vehicledetails.color
FROM vehicledetails 
group by make
having color = "WHITE"
order by years;

## Query number 12
## Violations made between 25 and 31 group and order by year
select split_date.days, split_date.months, split_date.years
from split_date
where split_date.days BETWEEN 25 AND 31
group by days
order by days, years ASC;




select * from view3; 
select count(*) from view3;
drop view view3;
SELECT Orders.OrderID, Customers.CustomerName, poilicedetails.policeid
FROM Orders
INNER JOIN poilicedetails ON persondetails.policeid=Customers.CustomerID;
select * from poilicedetails;
select * from persondetails;







-- SELECT 
-- SUBSTRING_INDEX((SUBSTRING_INDEX(dateofstop,'/',1)),'/',-1) AS days,
-- SUBSTRING_INDEX((SUBSTRING_INDEX(dateofstop,'/',2)),'/',-1) AS months,
-- SUBSTRING_INDEX((SUBSTRING_INDEX(dateofstop,'/',3)),'/',-1) AS years
-- FROM violations;