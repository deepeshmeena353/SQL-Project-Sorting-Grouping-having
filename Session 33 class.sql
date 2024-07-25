select * from smartphones;

-- Sorting
-- find top 5 Samsung phone with biggest screen size
SELECT model, screen_size
FROM smartphones
WHERE brand_name = 'samsung'
ORDER BY screen_size DESC
LIMIT 10;

-- sort all the phone in descending order of number of total cameras.
select model, num_front_cameras + num_rear_cameras as total_cameras 
from smartphones
order by total_cameras desc;
-- sort the data based on the PPI in decreasing order.
select model, round((resolution_width*resolution_width + resolution_height*resolution_height )/screen_size) as PPi
from smartphones
order by ppi desc;

-- Find the phone with 2nd largest battery
select model, battery_capacity from smartphones
order by battery_capacity desc limit 1,1;

-- FIND THE NAME OR RATING OF THE WORST RATED APPLE PHONE
select model, rating from smartphones 
where brand_name = 'apple'
order by rating asc limit 1;

-- sort the phones alphabetically and then by rating in descending order.
select * from smartphones
ORDER BY brand_name ASC, RATING desc;

-- sort the phones alphabetically by name and then by price in ascending order.
Select * from smartphones
order by brand_name asc, price asc;


-- GROUPING 

-- Group smartphones by brand and obtain count, average price, maximum rating, average screen size, and average battery capacity. 
select brand_name, count(*) as Num_Phone, 
round(AVG(price),2) as avg_price,
max(rating) as Max_rating,
ROUND(avg (screen_size),2) as avg_screen_size,
ROUND(avg (battery_capacity),2) as avg_battery_capacity
from smartphones
group by brand_name
order by Num_phone desc limit 5;

-- Group smartphones based on NFC availability and calculate average price and rating.
 select has_nfc, round(avg(PRICE),2), round(AVG(rating),2) 
 from smartphones
 group by has_nfc;

-- Group the smartphones by the available extended memory and calculate the average price for each group.
select extended_memory_available,
avg(price) from smartphones
group by extended_memory_available;

-- Group smartphones by brand and processor brand to count models and average primary camera resolution (rear).
select brand_name, processor_brand, count(*) AS NUM_PHONE, 
ROUND(avg(primary_camera_rear),2) AS AVG_CAMERA_REAR
from smartphones
group by brand_name, processor_brand
ORDER BY brand_name asc;

-- FIND TOP 5 MOST COSTLY PHONE BRANDS
SELECT brand_name, round(avg(price)) as avg_price 
from smartphones
group by brand_name 
order by avg_price desc limit 5;

-- which brand mackes the smallest screen smartphones.
select brand_name, avg(screen_size) as avg_screen 
from smartphones
group by brand_name
order by avg_screen asc limit 1;

-- The average price of 5G phones versus the average price of non-5G phones.
select has_5g, avg(price) as avg_price_5g_Non5g
from smartphones
 group by has_5g;
 
 -- Group smartphones by brand to find the one with the most models featuring both NFC and an IR Blaster.
 select brand_name, count(*) as Brand_count
 from smartphones
Where has_nfc = "True" and has_ir_blaster = "True"
group by brand_name
order by brand_count desc limit 1;

-- Find all Samsung 5G-enabled smartphones and determine the average price for NFC and non-NFC models.
select has_nfc, avg(price) as avg_price 
from smartphones
where brand_name = "samsung" and has_5g = "true"
group by has_nfc;

-- Find the brand name, price of the costliest phone
select brand_name, price 
from smartphones
order by PRICE desc limit 1;

-- GROUP BY SE KIYA
select brand_name, round(avg(price)) as avg_price
from smartphones
group by brand_name
order by avg_price desc limit 1;

-- HAVING FUNCTION

-- Find the average rating of smartphone brands that have more than 20 phones.
SELECT BRAND_NAME, COUNT(*) AS BRND_COUNT, 
ROUND(AVG(RATING),2) AS AVG_RATING
FROM smartphones
group by BRAND_NAME HAVING BRND_COUNT >40
order by AVG_RATING desc;  

-- FIND THE TOP 3 BRANDS WIHT THE HIGHEST AVG RAM THAT HAVE A REFRESH RATE OF AT LEAST 90 HZ AND FAST CHARGING AVAILABLE AND DONT CONSIDER BRAND WHICH HAVE LESS THAN 10 PHONE.
SELECT brand_name, ROUND(AVG(ram_capacity),2) AS AVG_RAM 
FROM smartphones
WHERE refresh_rate > 90 AND fast_charging_available =1
group by brand_name HAVING COUNT(*) >10
order by AVG_RAM desc LIMIT 3;


-- Find the average price of phone brands with an average rating greater than 70 and more than 10 phones, among all 5G-enabled phones.
select brand_name, count(*) as pp_count, 
avg(price) as avg_price, 
avg(rating) as avg_Rating 
from smartphones
where has_5g = "true"
group by brand_name having pp_count >10 and  avg_rating >70;



-- and 

select brand_name, avg(price) as avg_price from smartphones
where has_5g = "true"
group by brand_name having count(*) >10 and  avg(rating) >70;







-- IPL DATA SET 
SELECT * FROM ipl_data;

-- find the top 5 batsman in ipl 
select batter, sum(batsman_run) as TOT_RUN from ipl_data
group by batter
order by tot_run desc limit 5;

-- find the 2nd highest 6 hitter in ipl
select batter, count(*) as "count_run"
from ipl_data
where batsman_run = 6 
group by batter
order by count_run desc limit 1,1;

-- Find virat kohli performance against all IPL Team
select batter, sum(batsman_run) from ipl_data
where batter = 'v kohli';

-- Find the top 10 batter with centuries in IPL.
select batter, count(*) 
from (select batter, id, sum(batsman_run) as "100_s" from ipl_data
group by batter,id having 100_s >=100
order by 100_s desc) as c_data
GROUP BY batter
ORDER BY count(*) DESC
LIMIT 10;


