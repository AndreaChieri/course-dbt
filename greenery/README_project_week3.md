What is our overall conversion rate? --> 62.45%

WITH by_session AS (
    SELECT events_session_id
        , MAX(view_became_order) AS order_bool
    FROM DEV_DB.DBT_ANDREACHIERICOZZIMOLLIECOM.fct_product__page_views
    GROUP BY 1
)

SELECT SUM(CASE WHEN order_bool = TRUE THEN 1 ELSE 0 END) / COUNT(events_session_id) AS conversion_rate
FROM by_session

What is our conversion rate by product? 

WITH by_session_product AS (
    SELECT events_session_id
        , events_product_id
        , MAX(view_became_order) AS order_bool
    FROM DEV_DB.DBT_ANDREACHIERICOZZIMOLLIECOM.fct_product__page_views
    GROUP BY 1,2
)

SELECT events_product_id
, SUM(CASE WHEN order_bool = TRUE THEN 1 ELSE 0 END) / COUNT(events_session_id) AS conversion_rate
, SUM(CASE WHEN order_bool = TRUE THEN 1 ELSE 0 END) as num
, COUNT(events_session_id) as den
FROM by_session_product
GROUP BY 1
ORDER BY 2 DESC

EVENTS_PRODUCT_ID	CONVERSION_RATE	NUM	DEN
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80	0.609375	39	64
74aeb414-e3dd-4e8a-beef-0fa45225214d	0.555556	35	63
c17e63f7-0d28-4a95-8248-b01ea354840e	0.545455	30	55
b66a7143-c18a-43bb-b5dc-06bb5d1d3160	0.539683	34	63
689fb64e-a4a2-45c5-b9f2-480c2155624d	0.537313	36	67
579f4cd0-1f45-49d2-af55-9ab2b72c3b35	0.518519	28	54
be49171b-9f72-4fc9-bf7a-9a52e259836b	0.510204	25	49
b86ae24b-6f59-47e8-8adc-b17d88cbd367	0.509434	27	53
e706ab70-b396-4d30-a6b2-a1ccf3625b52	0.5	28	56
5ceddd13-cf00-481f-9285-8340ab95d06d	0.492537	33	67
615695d3-8ffd-4850-bcf7-944cf6d3685b	0.492308	32	65
35550082-a52d-4301-8f06-05b30f6f3616	0.488889	22	45
55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3	0.483871	30	62
a88a23ef-679c-4743-b151-dc7722040d8c	0.478261	22	46
64d39754-03e4-4fa0-b1ea-5f4293315f67	0.474576	28	59
5b50b820-1d0a-4231-9422-75e7f6b0cecf	0.474576	28	59
37e0062f-bd15-4c3e-b272-558a86d90598	0.467742	29	62
d3e228db-8ca5-42ad-bb0a-2148e876cc59	0.464286	26	56
c7050c3b-a898-424d-8d98-ab0aaad7bef4	0.453333	34	75
05df0866-1a66-41d8-9ed7-e2bbcddd6a3d	0.45	27	60
843b6553-dc6a-4fc4-bceb-02cd39af0168	0.426471	29	68
bb19d194-e1bd-4358-819e-cd1f1b401c0c	0.423077	33	78
80eda933-749d-4fc6-91d5-613d29eb126f	0.418919	31	74
e2e78dfc-f25c-4fec-a002-8e280d61a2f2	0.412698	26	63
6f3a3072-a24d-4d11-9cef-25b0b5f8a4af	0.411765	21	51
e5ee99b6-519f-4218-8b41-62f48f59f700	0.409091	27	66
e18f33a6-b89a-4fbc-82ad-ccba5bb261cc	0.4	28	70
e8b6528e-a830-4d03-a027-473b411c7f02	0.39726	29	73
58b575f2-2192-4a53-9d21-df9a0c14fc25	0.393443	24	61
4cda01b9-62e2-46c5-830f-b7f262a58fb1	0.344262	21	61

________________________________________________________________________________________________________________________________________________________________________________________

Create a macro to simplify part of a model(s)

I did create a macro but mainly as a test, as it is today would not know how to use it to simplify what I have built myself.
In my mind, a macro should be able to get fields as an input/variable, but did not manage to make it work. Used the utils one in stg_order to compare if the created_at is earlier than the estimated_delivery_at.

________________________________________________________________________________________________________________________________________________________________________________________
snapshot changes 
4cda01b9-62e2-46c5-830f-b7f262a58fb1	Pothos
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80	String of pearls
be49171b-9f72-4fc9-bf7a-9a52e259836b	Monstera
55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3	Philodendron
