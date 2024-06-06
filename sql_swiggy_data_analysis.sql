select * from swiggy;

-- 1. how many restaurants have the rating greater than 4.5?
select count(distinct restaurant_name) 
from swiggy
where rating > 4.5; 

-- 2. which is the top city with the highest no. of restaurants?
select count(distinct restaurant_name), city as restaurant_count
from swiggy
group by city
order by restaurant_count desc
limit 1;

-- 3. how many restaurants sell pizza or have word "pizza" in their name?
select  distinct restaurant_name  as restaurant_count
from swiggy
where restaurant_name like '%Pizza%';

-- 4. what is the most common cuisine among the restaurants?
select cuisine , count(*) as cuisine_count
from swiggy 
group by cuisine 
order by cuisine_count desc 
limit 1; 

-- 5.What is the average rating of restaurants in each city?
select city, avg(rating) as avg_rating
from swiggy 
group by city;

-- 6.What is the highest price of item under the 'Recommended' menu category for each restaurant?
select distinct restaurant_name, menu_category, max(price) as highestprice
from swiggy 
where menu_category = "Recommended"
group by restaurant_name, menu_category;

-- 7.find the top 5 most expensive restaurants that offer cuisine other than indian cuisine
select distinct restaurant_name, cost_per_person
from swiggy
where cuisine<> 'Indian'
order by cost_per_person desc
limit 5;

--  8. Find the restaurants that have average cost which is higher than the total average cost of all restaurants together
select distinct restaurant_name, cost_per_person
from swiggy
where cost_per_person> (select avg(cost_per_person) from swiggy);

--  9. Retrieve the details of restaurants that have the same name but are located in different cities?
select distinct s1.restaurant_name, s1.city, s2.city
from swiggy s1 join swiggy s2
on s1.restaurant_name = s2.restaurant_name and s1.city <> s2.city;

-- 10. Which restaurant offers the most no. of items in the 'main course' category?
select distinct restaurant_name, menu_category, coutn(item) as no_of_items
from swiggy
where menu_category= 'Main Course'
group by restaurant_name, menu_category
order by no_of_items desc
limit 1;

-- 11. List the name of restarurants that are 100% in alphabetical order of restarurant name?
select distinct restaurant_name,
(count (case when veg_or_nonveg = 'Veg' then 1 end)*100/
count(*)) as vegetarian_percentage
from swiggy
group by restaurant_name 
having vegetarian_percentage=100.00
order by restaurant_name;

-- 12. which is the restaurant proving lowest average price for all items?
select distinct restaurant_name, avg(price) as avg_price
from swiggy
group by restaurant_name
order by avg_price
limit 1;

-- 13. which top 5 restaurants offers highest number of categories?
select distinct restaurant_name, count(distinct menu_category) as no_of_categories
from swiggy
group by restaurant_name
order by no_of_categories desc
limit 5;

-- 14. which restarurant provides the highest percentage of non-vegetarian food?
select distinct restaurant_name,
(count(case when veg_or_non-veg ='Non-veg' then 1 end)*100
/count(*)) as nonvegetarian_percentage
from swiggy
group by restaurant_name 
order by nonvegerarian_percentage desc 
limit 1;

-- 15. determine most and least expensive cites for dining
with CityExpense AS (
select city, max(cost_per_person) as max_cost, min(cost_per_person) as min_cost
from swiggy 
group by city)
select city, max_cost, min_cost
from CityExpense
order by max_cost desc;

