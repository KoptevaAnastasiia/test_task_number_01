USE test_task_work12;

WITH weekly_revenue AS ( SELECT DATE_FORMAT(ord_t.event_date, '%Y-%u') AS week, ord_t.order_country,  SUM(ord_t.order_amount) AS total_revenue
                         FROM orders_table ord_t WHERE ord_t.event_date BETWEEN '2023-06-01' AND '2023-12-31'
                                             GROUP BY week, ord_t.order_country),


    weekly_refunds AS (SELECT DATE_FORMAT(o.event_date, '%Y-%u') AS week,
                              o.order_country,
                              SUM(o.order_amount) AS refunded_amount
                       FROM orders_table o WHERE o.event_date BETWEEN '2023-06-01'
                                            AND '2023-12-31'
                                            AND o.order_status = 'refunded'
                                           GROUP BY week, o.order_country),

    weekly_data AS ( SELECT r.week, r.order_country, r.total_revenue,
                            COALESCE(f.refunded_amount, 0) AS amount

                     FROM weekly_revenue r
                         LEFT JOIN  weekly_refunds f
                             ON r.week = f.week
                             AND r.order_country = f.order_country)





SELECT
    CASE
        WHEN order_country = 'GB' THEN 'United Kingdom'
        WHEN order_country = 'US' THEN 'United States'
        WHEN order_country = 'CA' THEN 'Canada'
        ELSE 'Other Countries'
    END AS country_group, week,

    SUM(total_revenue) AS total_revenue,
    SUM(amount) AS refunded_amount,
SUM(amount) / SUM(total_revenue) * 100 AS refund_rate

FROM weekly_data
GROUP BY country_group, week
ORDER BY  week, country_group;
