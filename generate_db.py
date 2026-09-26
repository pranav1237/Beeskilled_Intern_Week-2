"""
Generates a small, realistic sample e-commerce database (customers + orders)
for the Week 2 SQL assignment, and writes:
  - schema_and_data.sql  (CREATE TABLE + INSERT statements, hand-inspectable)
  - sample_database.db   (the same data loaded into an actual SQLite file)

Note: the assignment's original "sample database" was linked as a private
Google Sheet that this environment could not open (no access/edit rights
were shared). This script builds a comparable stand-in dataset -- a
customers table and an orders table -- so the SQL queries in queries.sql
can be written and actually run end-to-end.
"""
import sqlite3
import random
from datetime import date, timedelta

random.seed(42)

customers = [
    (1, "Ava",     "Thompson", "ava.thompson@example.com",   "Denver",      "2023-01-12"),
    (2, "Liam",    "Garcia",   "liam.garcia@example.com",    "Austin",      "2023-02-03"),
    (3, "Noah",    "Chen",     "noah.chen@example.com",      "Seattle",     "2023-02-20"),
    (4, "Emma",    "Patel",    "emma.patel@example.com",     "Chicago",     "2023-03-05"),
    (5, "Oliver",  "Nguyen",   "oliver.nguyen@example.com",  "Boston",      "2023-03-18"),
    (6, "Sophia",  "Ahmed",    "sophia.ahmed@example.com",   "Portland",    "2023-04-02"),
    (7, "Elijah",  "Rossi",    "elijah.rossi@example.com",   "Miami",       "2023-04-22"),
    (8, "Isabella","Kim",      "isabella.kim@example.com",   "Denver",      "2023-05-09"),
    (9, "Mateo",   "Fischer",  "mateo.fischer@example.com",  "Austin",      "2023-05-30"),
    (10,"Mia",     "Johnson",  "mia.johnson@example.com",    "Seattle",     "2023-06-14"),
    (11,"Lucas",   "Silva",    "lucas.silva@example.com",    "Chicago",     "2023-07-01"),
    (12,"Charlotte","Novak",   "charlotte.novak@example.com","Boston",      "2023-07-19"),
    (13,"Ethan",   "Brooks",   "ethan.brooks@example.com",   "Portland",    "2023-08-08"),
    (14,"Amelia",  "Diaz",     "amelia.diaz@example.com",    "Miami",       "2023-08-27"),
    (15,"James",   "Wallace",  "james.wallace@example.com",  "Denver",      "2023-09-15"),
]

statuses = ["completed", "completed", "completed", "completed", "cancelled", "returned"]

orders = []
order_id = 1
start = date(2023, 9, 1)
# Give customers uneven order counts/amounts so "top customers" is meaningful
order_profile = {
    1: (7, 220, 60), 2: (2, 60, 15), 3: (5, 150, 40), 4: (1, 40, 10),
    5: (6, 300, 80), 6: (3, 90, 20), 7: (4, 120, 30), 8: (8, 250, 70),
    9: (2, 70, 20), 10:(5, 180, 45), 11:(1, 35, 10), 12:(6, 200, 55),
    13:(3, 85, 25), 14:(4, 130, 35), 15:(9, 260, 65),
}

for cust_id, (n_orders, base_amt, spread) in order_profile.items():
    for i in range(n_orders):
        d = start + timedelta(days=random.randint(0, 200))
        amount = round(max(9.99, random.gauss(base_amt, spread)), 2)
        status = random.choice(statuses)
        orders.append((order_id, cust_id, d.isoformat(), amount, status))
        order_id += 1

orders.sort(key=lambda r: r[2])

# ---- Write schema_and_data.sql ----
lines = []
lines.append("-- Week 2 SQL Assignment: sample e-commerce database")
lines.append("-- Tables: customers, orders")
lines.append("")
lines.append("DROP TABLE IF EXISTS orders;")
lines.append("DROP TABLE IF EXISTS customers;")
lines.append("")
lines.append("""CREATE TABLE customers (
    customer_id  INTEGER PRIMARY KEY,
    first_name   TEXT NOT NULL,
    last_name    TEXT NOT NULL,
    email        TEXT NOT NULL,
    city         TEXT,
    signup_date  DATE
);""")
lines.append("")
lines.append("""CREATE TABLE orders (
    order_id     INTEGER PRIMARY KEY,
    customer_id  INTEGER NOT NULL,
    order_date   DATE NOT NULL,
    amount       REAL NOT NULL,
    status       TEXT NOT NULL CHECK (status IN ('completed','cancelled','returned')),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);""")
lines.append("")

for c in customers:
    lines.append(
        "INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) "
        "VALUES ({}, '{}', '{}', '{}', '{}', '{}');".format(*c)
    )

lines.append("")
for o in orders:
    lines.append(
        "INSERT INTO orders (order_id, customer_id, order_date, amount, status) "
        "VALUES ({}, {}, '{}', {}, '{}');".format(*o)
    )

with open("schema_and_data.sql", "w") as f:
    f.write("\n".join(lines) + "\n")

# ---- Build the actual SQLite database from the same statements ----
conn = sqlite3.connect("sample_database.db")
cur = conn.cursor()
cur.executescript("\n".join(lines))
conn.commit()

# sanity check
cur.execute("SELECT COUNT(*) FROM customers")
n_cust = cur.fetchone()[0]
cur.execute("SELECT COUNT(*) FROM orders")
n_ord = cur.fetchone()[0]
conn.close()

print(f"Built sample_database.db with {n_cust} customers and {n_ord} orders.")
print("Wrote schema_and_data.sql")
