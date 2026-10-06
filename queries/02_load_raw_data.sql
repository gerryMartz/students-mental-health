-- Reload the raw table from the CSV (safe to run more than once)
TRUNCATE students_raw;

\copy students_raw FROM 'data/raw/students.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8')