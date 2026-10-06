# Students' Mental Health

Exploratory data analysis in SQL (PostgreSQL) of a study on university students' mental health, focused on international students and how their length of stay affects their outcomes.

## Background

A Japanese international university surveyed its students in 2018 and published a study the following year. The study found that international students face a higher risk of mental health difficulties than the general population, and that two factors predict depression: social connectedness (a sense of belonging to a social group) and acculturative stress (the stress of adapting to a new culture).

**Question for this project:** is length of stay a contributing factor to the average depression, social connectedness, and acculturative stress scores of international students?

## Task

Using only international students, group the data by length of stay (`stay`) and summarize, for each group:

- how many students it contains, and
- the average depression (`todep`, PHQ-9), social connectedness (`tosc`, SCS), and acculturative stress (`toas`, ASISS) scores, rounded to two decimals.

Results are sorted by length of stay, longest first.

### Expected output

One row per distinct length of stay (nine rows), with these columns in this order:

| Column | Description |
|---|---|
| `stay` | Length of stay, in years |
| `count_int` | Number of international students with that length of stay |
| `average_phq` | Average depression score (`todep`), 2 decimals |
| `average_scs` | Average social connectedness score (`tosc`), 2 decimals |
| `average_as` | Average acculturative stress score (`toas`), 2 decimals |

## Dataset

Table `students`, with one row per surveyed student and 51 columns. The columns used in this analysis:

| Column | Description |
|---|---|
| `inter_dom` | Student type (international or domestic) |
| `japanese_cate` | Japanese language proficiency |
| `english_cate` | English language proficiency |
| `academic` | Current academic level (undergraduate or graduate) |
| `age` | Student's current age |
| `stay` | Current length of stay, in years |
| `todep` | Total depression score (PHQ-9 test) |
| `tosc` | Total social connectedness score (SCS test) |
| `toas` | Total acculturative stress score (ASISS test) |

<details>
<summary>Remaining columns (not used in this analysis)</summary>

`index`, `region`, `gender`, `age_cate`, `stay_cate`, `japanese`, `english`, `intimate`, `religion`, `suicide`, `dep`, `deptype`, `depsev`, `apd`, `ahome`, `aph`, `afear`, `acs`, `aguilt`, `amiscell`, `partner`, `friends`, `parents`, `relative`, `profess`, `phone`, `doctor`, `reli`, `alone`, `others`, `internet`, `partner_bi`, `friends_bi`, `parents_bi`, `relative_bi`, `professional_bi`, `phone_bi`, `doctor_bi`, `religion_bi`, `alone_bi`, `others_bi`, `internet_bi`

</details>

### Data notes

- The CSV has 286 rows: 201 international (`Inter`), 67 domestic (`Dom`), and 18 with an empty `inter_dom`.
- `index` comes from the export and is not part of the original data.
- Rows with an empty `inter_dom` are excluded from the analysis, which filters on `inter_dom = 'Inter'`.
- The raw table stores every column as `TEXT`, and empty values are loaded as empty strings, not `NULL`. Type casting and cleaning happen in later scripts.

- **Data source:** to be documented (original study and link).
- **Note:** the data comes from a DataCamp exercise; the analysis and queries in this repository are my own.

## Project structure

- `data/raw/`: original data, unmodified.
- `data/processed/`: transformed data.
- `queries/`: SQL queries, numbered in execution order.
- `outputs/`: final results.

## How to reproduce

Requirements: PostgreSQL 17 and `psql`. Run everything from the repository root.

1. Create the database:

```bash
   createdb students_mental_health
```

2. Create the raw table:

```bash
   psql -d students_mental_health -f queries/01_create_raw_table.sql
```

3. Load the CSV into the raw table (`\copy` is a `psql` command and must be a single line):

```bash
   psql -d students_mental_health -c "\copy students_raw FROM 'data/raw/students.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8')"
```

   Expected output: `COPY 286`.

4. Run the analysis:

```bash
   psql -d students_mental_health -f queries/02_stay_analysis.sql
```

## Findings

Average scores for international students by length of stay (years with at least 14 students):

| Stay (years) | Students | Depression (PHQ-9) | Social connectedness (SCS) | Acculturative stress (ASISS) |
|---|---|---|---|---|
| 1 | 95 | 7.48 | 38.11 | 72.80 |
| 2 | 39 | 8.28 | 37.08 | 77.67 |
| 3 | 46 | 9.09 | 37.13 | 78.00 |
| 4 | 14 | 8.57 | 33.93 | 87.71 |

- **Depression:** the average is higher at 4 years than at 1 year, but it does not rise steadily: it peaks at year 3 and dips slightly at year 4.
- **Social connectedness:** it tends to decrease with length of stay. It is almost flat between years 2 and 3, and the sharpest drop appears at year 4.
- **Acculturative stress:** it increases with length of stay and has the largest jump between years 3 and 4 (from 78.00 to 87.71).

In short, the largest change in all three scores appears at year 4, consistent with longer stays being associated with worse outcomes for international students.

### Limitations

- Stays of 5 years or more have between 1 and 3 students each, so their averages are not reliable and are not interpreted here.
- The 4-year group has only 14 students, so its averages are the most sensitive to individual cases.
- These are descriptive averages of different students at a single point in time, not a follow-up of the same people. No statistical test was run, so the results show an association, not a cause.
