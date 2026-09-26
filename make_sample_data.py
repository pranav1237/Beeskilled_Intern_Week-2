"""
Builds sales_data.csv: a small retail sales dataset with the properties
the Week 2 practice questions ask us to work with -- multiple categories,
some missing values, a couple of duplicate rows, and several numeric
columns (for grouping, sorting, and a correlation matrix).
"""
import random
import pandas as pd
from datetime import date, timedelta

random.seed(7)

categories = {
    "Electronics": ["Wireless Mouse", "Bluetooth Speaker", "USB-C Hub", "Webcam", "Laptop Stand"],
    "Clothing":    ["Cotton T-Shirt", "Denim Jacket", "Running Shoes", "Wool Sweater", "Rain Jacket"],
    "Home & Kitchen": ["Blender", "Non-stick Pan", "Air Fryer", "Cutlery Set", "Coffee Maker"],
    "Books":       ["Data Analysis 101", "Python Crash Course", "SQL Basics", "Novel: The Long Road", "History of Rome"],
    "Sports":      ["Yoga Mat", "Dumbbell Set", "Cycling Helmet", "Tennis Racket", "Camping Tent"],
}
regions = ["North", "South", "East", "West"]

rows = []
order_id = 1000
start = date(2024, 1, 1)

for _ in range(120):
    category = random.choice(list(categories.keys()))
    product = random.choice(categories[category])
    quantity = random.randint(1, 8)
    unit_price = round(random.uniform(8, 220), 2)
    revenue = round(quantity * unit_price, 2)
    region = random.choice(regions)
    order_date = start + timedelta(days=random.randint(0, 269))
    rating = round(random.uniform(2.5, 5.0), 1)

    rows.append({
        "OrderID": order_id,
        "Product": product,
        "Category": category,
        "Quantity": quantity,
        "UnitPrice": unit_price,
        "Revenue": revenue,
        "Region": region,
        "OrderDate": order_date.isoformat(),
        "CustomerRating": rating,
    })
    order_id += 1

df = pd.DataFrame(rows)

# --- Inject realistic messiness ---
# 1) A handful of missing values (Region and CustomerRating)
missing_region_idx = random.sample(range(len(df)), 5)
df.loc[missing_region_idx, "Region"] = None

missing_rating_idx = random.sample(range(len(df)), 6)
df.loc[missing_rating_idx, "CustomerRating"] = None

# 2) A few exact duplicate rows (common in real, messy exports)
dup_rows = df.sample(4, random_state=3)
df = pd.concat([df, dup_rows], ignore_index=True)

# shuffle so duplicates/missing aren't obviously clustered at the end
df = df.sample(frac=1, random_state=11).reset_index(drop=True)

df.to_csv("sales_data.csv", index=False)
print(f"Wrote sales_data.csv with {len(df)} rows "
      f"({df.duplicated().sum()} duplicate rows, "
      f"{df.isnull().sum().sum()} missing values).")
