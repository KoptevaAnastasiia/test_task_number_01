USE test_task_work12;

WITH quiz_orders AS (SELECT
        qst.quiz_submit_email,
        DATE_FORMAT(qst.datetime, '%Y-%m') AS cohort,
        qst.quiz_funnel,
        COUNT(DISTINCT or_id.order_id) AS orders_count
                     FROM quizzes_table qst
                         LEFT JOIN orders_table or_id ON qst.quiz_submit_email = or_id.order_email
                     WHERE or_id.order_id IS NOT NULL
                     GROUP BY qst.quiz_submit_email, cohort, qst.quiz_funnel),


    quiz_attempts AS (SELECT qsEm.quiz_submit_email,
                             DATE_FORMAT(qsEm.datetime, '%Y-%m') AS cohort,
                             qsEm.quiz_funnel,
                             COUNT(DISTINCT qsEm.quiz_submit_email) AS attempts_count
                      FROM  quizzes_table qsEm  GROUP BY qsEm.quiz_submit_email,
                                                         cohort,
                                                         qsEm.quiz_funnel)


SELECT qf.cohort, qf.quiz_funnel, qf.attempts_count, COALESCE(qo.orders_count, 0) AS orders_count,
    ROUND((COALESCE(qo.orders_count, 0) / qf.attempts_count) * 100, 2) AS conversion_rate
FROM quiz_attempts qf
    LEFT JOIN quiz_orders qo ON qf.quiz_submit_email = qo.quiz_submit_email
                             AND qf.cohort = qo.cohort
                             AND qf.quiz_funnel = qo.quiz_funnel

ORDER BY  qf.cohort, qf.quiz_funnel;
