# Students' Mental Health

Exploratory data analysis in SQL (PostgreSQL) of a study on university students' mental health, focused on international students and how their length of stay affects their outcomes.

## Background

A Japanese international university surveyed its students in 2018 and published a study the following year. The study found that international students face a higher risk of mental health difficulties than the general population, and that two factors predict depression: social connectedness (a sense of belonging to a social group) and acculturative stress (the stress of adapting to a new culture).

**Question for this project:** is length of stay a contributing factor to the average depression, social connectedness, and acculturative stress scores of international students?

## Dataset

Table `students`, with one row per surveyed student.

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

- **Data source:** to be documented (original study and link).
- **Note:** the data comes from a DataCamp exercise; the analysis and queries in this repository are my own.

## Project structure

- `data/raw/`: original data, unmodified.
- `data/processed/`: transformed data.
- `queries/`: SQL queries, numbered in execution order.
- `outputs/`: final results.

## How to reproduce

Requirements: PostgreSQL 17 and `psql`.

1. To do: create the database.
2. To do: load `data/raw/students.csv`.
3. To do: run the files in `queries/` in order.

## Findings

To do: complete once the analysis is finished.
