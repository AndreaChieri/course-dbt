What is our user repeat rate?  --> 79.84%
Repeat Rate = Users who purchased 2 or more times / users who purchased

WITH count_orders_by_user AS (
    SELECT user_id
        , COUNT(order_id) AS count_orders
    FROM DEV_DB.DBT_ANDREACHIERICOZZIMOLLIECOM.stg_orders
    group by user_id
)

SELECT COUNT(CASE WHEN count_orders>1 THEN user_id ELSE NULL END) AS count_users_with_multiple_orders
    , COUNT(user_id) AS count_of_users_who_purchased
    , ROUND(100*COUNT(CASE WHEN count_orders>1 THEN user_id ELSE NULL END) / COUNT(user_id),2) AS repeat_rate
FROM count_orders_by_user

__________________________________________________________________________________________________________________________________________________________________________________________________________________________________
What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.

1) A boolean that per user checks if any sessions happened after the last purchase date where the user went through the website store and checked plants that did not belong to any of the previous orders. This assumes that is unlikely that a customer will buy again the same plants a second time, therefore if you check the store page of plants you already bought, is likely that you are checking info. This is my personal assumptions that I believe fits the case.

A boolean that set a logic that is based on the count of purchases already made. For example, checking if the count of purchases is above 1 already, or if it is above the median for example. It depens on the distrubution. If there is a Pareto rule in place, for example, you could even check if it is part of the small amount of customers that purchase often, such as small businesses or indipendent workers (freelancers, owners, and so on).
If the count of purchases is just one, potentially you could add a check for the number of plants that were bought in that order, assuming that the bigger the purchase in terms of items (or total price), the higher the chance the user will come back.
On top of all of these factors, I would also add a check for whether the last purchase (or the last website activity) was longer than a certain period, for example a few months or 1 year.
For example, if a customer has made several orders but the last one (or the last time he/she visited the website) was longer than 1 year, is unlikely that is goingt to purchase again.
Another piece of logic could be related to the location. If my target market is the Netherlands, and a customer made one order from UK (assuming is even feasible), is unlikely is going to order again given higher shipping costs, local alternatives, or higher chance that the plant will be ruined while transported.

2) I would look for return / complaints / replacements / refund requests if available. How many users asked for a free replacement, or returned the plants asking for a refund.
I would look into any kind of data that would tell me if a user was satisfied with the previous order or not. It could be a survey potentially, or a star rating system linked to the order.

__________________________________________________________________________________________________________________________________________________________________________________________________________________________________

Explain the product mart models you added. Why did you organize the models in the way you did?
1) created an int table with page_views events only, plus the final order id if any. The idea behind is to check if the views were translated into orders checking if the order has the product id in it.
2) created an int table with orders and order items (check prev row for why)
3) created a fct table joining the two int tables and stg_user to provide a table with page_views events only, plus user info, plus check if each view translated into an order eventually.

__________________________________________________________________________________________________________________________________________________________________________________________________________________________________
Paste in an image of your DAG from the docs. These commands will help you see the full DAG

https://8080-andreachieri-coursedbt-snx7ramgoxr.ws-eu95.gitpod.io/#!/overview?g_v=1

__________________________________________________________________________________________________________________________________________________________________________________________________________________________________
What assumptions are you making about each model? (i.e. why are you adding each test?)
- Unique IDs of each dataset to be unique, other key data to be not null, other integer data such as quantity, order_total, inventory, to be positive.

Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
- No, everything was successful

__________________________________________________________________________________________________________________________________________________________________________________________________________________________________
Run the product snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week. 

Which products had their inventory change from week 1 to week 2?

4cda01b9-62e2-46c5-830f-b7f262a58fb1	Pothos
be49171b-9f72-4fc9-bf7a-9a52e259836b	Monstera
55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3	Philodendron
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80	String of pearls