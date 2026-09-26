"""
Week 2 - Python for Data Analysis: Practice Questions
======================================================
Dataset: sales_data.csv (a small retail sales dataset - see make_sample_data.py
for how it was generated).

1. Load a CSV file using Pandas and display basic info.
2. Handle missing values and duplicates using Pandas.
3. Group data by category and find total revenue.
4. Sort data by multiple columns using Python.
5. Create a correlation matrix for numerical columns.

Running this script prints the answer to every question and saves two
chart images (revenue_by_category.png, correlation_heatmap.png).
"""
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import seaborn as sns

pd.set_option("display.width", 100)
pd.set_option("display.max_columns", 10)


def section(title):
    print("\n" + "=" * 70)
    print(title)
    print("=" * 70)


# ------------------------------------------------------------------
# Q1. Load a CSV file using Pandas and display basic info
# ------------------------------------------------------------------
section("Q1. Load CSV and display basic info")

df = pd.read_csv("sales_data.csv")

print("\nShape (rows, columns):", df.shape)
print("\nFirst 5 rows:")
print(df.head())
print("\ndf.info():")
df.info()
print("\ndf.describe() (numeric columns):")
print(df.describe())


# ------------------------------------------------------------------
# Q2. Handle missing values and duplicates using Pandas
# ------------------------------------------------------------------
section("Q2. Handle missing values and duplicates")

print("\nMissing values per column (before cleaning):")
print(df.isnull().sum())

n_dupes = df.duplicated().sum()
print(f"\nFully duplicated rows (before cleaning): {n_dupes}")

df_clean = df.copy()

# Duplicates: exact duplicate rows are dropped outright.
df_clean = df_clean.drop_duplicates()

# Missing values:
#  - Region (categorical, no natural "default") -> label as "Unknown"
#    so we keep the row instead of losing sales data.
#  - CustomerRating (numeric) -> fill with the column median, a simple,
#    robust stand-in that doesn't distort the overall distribution.
df_clean["Region"] = df_clean["Region"].fillna("Unknown")
df_clean["CustomerRating"] = df_clean["CustomerRating"].fillna(
    df_clean["CustomerRating"].median()
)

print("\nMissing values per column (after cleaning):")
print(df_clean.isnull().sum())
print(f"\nDuplicate rows (after cleaning): {df_clean.duplicated().sum()}")
print(f"Row count: {len(df)} -> {len(df_clean)} after cleaning")


# ------------------------------------------------------------------
# Q3. Group data by category and find total revenue
# ------------------------------------------------------------------
section("Q3. Total revenue by category")

revenue_by_category = (
    df_clean.groupby("Category")["Revenue"]
    .sum()
    .round(2)
    .sort_values(ascending=False)
)
print(revenue_by_category)

# quick supporting chart
plt.figure(figsize=(7, 4.5))
revenue_by_category.sort_values().plot(kind="barh", color="#3b6ea5")
plt.xlabel("Total Revenue ($)")
plt.title("Total Revenue by Category")
plt.tight_layout()
plt.savefig("revenue_by_category.png", dpi=150)
plt.close()
print("\nSaved chart: revenue_by_category.png")


# ------------------------------------------------------------------
# Q4. Sort data by multiple columns
# ------------------------------------------------------------------
section("Q4. Sort by multiple columns (Category asc, Revenue desc)")

sorted_df = df_clean.sort_values(
    by=["Category", "Revenue"], ascending=[True, False]
)
print(sorted_df[["Category", "Product", "Revenue", "Region"]].head(15))


# ------------------------------------------------------------------
# Q5. Create a correlation matrix for numerical columns
# ------------------------------------------------------------------
section("Q5. Correlation matrix (numerical columns)")

numeric_cols = df_clean.select_dtypes(include="number").drop(columns=["OrderID"])
corr_matrix = numeric_cols.corr().round(2)
print(corr_matrix)

plt.figure(figsize=(6, 5))
sns.heatmap(corr_matrix, annot=True, cmap="coolwarm", vmin=-1, vmax=1)
plt.title("Correlation Matrix - Numerical Columns")
plt.tight_layout()
plt.savefig("correlation_heatmap.png", dpi=150)
plt.close()
print("\nSaved chart: correlation_heatmap.png")

# Save the cleaned dataset too, for reference
df_clean.to_csv("sales_data_cleaned.csv", index=False)
print("\nSaved cleaned dataset: sales_data_cleaned.csv")

section("Done")
print("All 5 practice questions completed.")
