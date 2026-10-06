WITH convert_data_types AS (
    SELECT inter_dom,
           NULLIF(stay, '')::INT AS stay,
           NULLIF(todep, '')::INT AS todep_int,
           NULLIF(tosc, '')::INT AS tosc_int,
           NULLIF(toas, '')::INT AS toas_int
    FROM students_raw
    WHERE inter_dom = 'Inter'
)

SELECT stay,
       COUNT(inter_dom) AS count_int,
       ROUND(AVG(todep_int), 2) AS average_phq,
       ROUND(AVG(tosc_int), 2) AS average_scs,
       ROUND(AVG(toas_int), 2) AS average_as
FROM convert_data_types
GROUP BY stay
ORDER BY stay DESC;
