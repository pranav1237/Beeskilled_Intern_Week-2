# Data Analyst Course — Week 2 Assignment Submission

This covers everything in `week 2.pdf` and `practice set.pdf`:

1. **SQL for Data Analysis** — query a sample database to find top customers
   and average order values (plus joins, subqueries, and CASE statements).
2. **Python for Data Analysis** — the 5 Pandas practice questions.

## A note on the linked Google Sheet

`week 2.pdf` links to a private Google Sheet as the "sample database"
(`docs.google.com/spreadsheets/d/1TsjE5RFrHXzWgONIpdPfAbAtsLm8nPTs`). It
isn't shared publicly, so it couldn't be opened here. To keep the SQL work
concrete and actually runnable, `SQL/generate_db.py` builds a comparable
stand-in dataset — a `customers` table and an `orders` table — and every
query in `SQL/queries.sql` runs against that.

**If your instructor grades against the exact numbers in that sheet**,
open the sheet, use *File → Download → CSV* (or share it so it can be
read directly), and send me the file — I'll re-run every query against
the real data and refresh the results in minutes. The query logic itself
won't need to change.

## What's inside

```
SQL/
  generate_db.py       - builds the sample database (run first)
  schema_and_data.sql   - the resulting schema + INSERT statements (readable)
  sample_database.db    - the actual SQLite database file
  queries.sql           - the 5 analysis queries, commented
  run_queries.py        - runs queries.sql against the .db, writes results
  query_results.md      - the output of every query, as tables

Python/
  make_sample_data.py     - builds the sample sales dataset (run first)
  sales_data.csv           - the raw dataset used (has messy real-world quirks)
  week2_python_practice.py - answers all 5 practice questions
  practice_output.txt      - full printed output of that script
  sales_data_cleaned.csv   - output of question 2 (missing values/duplicates handled)
  revenue_by_category.png  - chart supporting question 3
  correlation_heatmap.png  - chart supporting question 5
```

## SQL — what was found

- **Top customer**: Oliver Nguyen, $1,547.93 across 5 completed orders
  (see `query_results.md`, Q1 and Q3 for the full top-5 and per-customer
  breakdown).
- **Average order value**: $193.16 across all orders, $183.12 across
  completed orders only (Q2).
- Q3 adds a `CASE`-based spend tier (Gold/Silver/Bronze) per customer.
- Q4 uses a subquery to find customers spending above the average
  customer's total spend.
- Q5 uses `JOIN` + `CASE` to break down order outcomes (completed /
  cancelled / returned) by city.

To reproduce: `cd SQL && python3 generate_db.py && python3 run_queries.py`
(or open `sample_database.db` in any SQLite client — DB Browser for
SQLite, TablePlus, etc. — and run the statements in `queries.sql`
directly).

## Python — what was found

- Q1: dataset is 124 rows × 9 columns; `df.info()` / `.describe()` output
  in full in `practice_output.txt`.
- Q2: found 5 missing `Region` values, 6 missing `CustomerRating` values,
  and 4 duplicate rows. Duplicates were dropped; `Region` nulls were
  labeled `"Unknown"` (categorical, no natural default) and
  `CustomerRating` nulls were filled with the column median.
- Q3: total revenue by category, highest to lowest — Sports ($14,428.26)
  led, Books ($9,727.56) was lowest. See `revenue_by_category.png`.
- Q4: data sorted by `Category` (A→Z) then `Revenue` (high→low) within
  each category.
- Q5: correlation matrix across `Quantity`, `UnitPrice`, `Revenue`,
  `CustomerRating` — `UnitPrice` and `Revenue` correlate most (0.72);
  `CustomerRating` has essentially no linear relationship with the
  others, as expected. See `correlation_heatmap.png`.

To reproduce: `cd Python && python3 make_sample_data.py && python3 week2_python_practice.py`

## Suggested video (from `week 2.pdf`)

`https://youtu.be/l8DCPaHc5TQ?si=PztVky6cSoWp23i9` — worth watching before
submitting, since it's the course's own walkthrough of this material.
