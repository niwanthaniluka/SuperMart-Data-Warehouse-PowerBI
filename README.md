# SuperMart Data Warehouse & Power BI Dashboard

An end-to-end retail analytics project that combines MySQL source databases, a Python ETL pipeline, a dimensional data warehouse, and an interactive Power BI report.

## Project overview

The SuperMart project demonstrates how retail sales and inventory data can be collected from operational databases, transformed with Python, stored in a MySQL data warehouse, and explored through Power BI dashboards.

### Main components

- **MySQL 8.0** — source databases and destination data warehouse.
- **Python ETL** — extracts, validates, transforms, and loads sales, product, customer, branch, date, payment, and inventory data.
- **CSV inventory source** — inventory movement input files used by the inventory ETL.
- **Power BI Desktop** — interactive Sales and Inventory dashboard pages.
- **SQL export** — database schemas and sample data for setting up the project.

## Repository structure

```text
SuperMart-PowerBI-GitHub/
├── SuperMart_Dashboard.pbix
├── SuperMart_Full_Database.sql
├── SuperMart_Complete_Installation_Guide.pdf
├── .gitignore
└── SuperMart_Python_Project/
    ├── .env.example
    ├── requirements.txt
    ├── data_sources/
    │   ├── inventory_movements.csv
    │   └── inventory_movements_before_refresh.csv
    └── etl/
        ├── db_connection.py
        ├── load_dimensions.py
        ├── load_fact_sales.py
        ├── load_fact_inventory.py
        ├── test_connections.py
        ├── test_read_data.py
        └── test_setup.py
```

## Technology stack

| Technology | Purpose |
|---|---|
| MySQL 8.0 | Relational databases and data warehouse |
| Python 3 | ETL processing |
| Pandas | Data extraction and transformation |
| SQLAlchemy | Python-to-MySQL connectivity |
| PyMySQL | MySQL driver |
| python-dotenv | Local environment configuration |
| Power BI Desktop | Data modelling, visualisation, and reporting |

## Data architecture

The SQL export creates three schemas:

1. `supermart_pos` — point-of-sale data, including branches, customers, sales, sale items, and payments.
2. `supermart_products` — product catalogue data, including products, categories, and suppliers.
3. `supermart_dw` — analytical warehouse containing dimensions and fact tables for reporting.

The Python ETL reads from the operational schemas and loads analytical data into `supermart_dw`. The Power BI report is designed to analyse the warehouse.

### ETL workflow

1. Extract sales and product information from the source databases.
2. Validate and transform the extracted records.
3. Load dimension tables into the warehouse.
4. Load sales and inventory fact data.
5. Connect Power BI to the warehouse and refresh the report.

## Getting started

### Prerequisites

Install the following on Windows:

- MySQL Server 8.0
- MySQL Workbench
- Python 3 (64-bit recommended)
- Power BI Desktop
- A MySQL account allowed to create databases and tables

For Power BI refresh, install a compatible MySQL connector/driver if Power BI requests one.

### 1. Download or clone this repository

```bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
cd YOUR-REPOSITORY
```

Alternatively, use **Code → Download ZIP** on GitHub and extract the archive.

### 2. Import the MySQL databases

> **Important:** The SQL file contains `CREATE DATABASE`, `DROP TABLE`, and data insertion statements. Use a clean local MySQL instance or back up any existing databases first. Do not import it over databases containing data you need.

1. Open MySQL Workbench and connect to your local MySQL Server.
2. Select **Server → Data Import**.
3. Choose **Import from Self-Contained File**.
4. Select `SuperMart_Full_Database.sql`.
5. If Workbench allows it, leave the default target schema unset because the dump creates and selects its own schemas.
6. Start the import and inspect the import log for errors.
7. Refresh the Schemas panel.

The expected schemas are:

```text
supermart_pos
supermart_products
supermart_dw
```

You can verify the warehouse tables with:

```sql
SELECT 'fact_sales' AS table_name, COUNT(*) AS total_rows
FROM supermart_dw.fact_sales
UNION ALL
SELECT 'fact_inventory', COUNT(*)
FROM supermart_dw.fact_inventory
UNION ALL
SELECT 'dim_product', COUNT(*)
FROM supermart_dw.dim_product
UNION ALL
SELECT 'dim_customer', COUNT(*)
FROM supermart_dw.dim_customer;
```

The original installation guide records the export-time reference counts as 40 sales fact rows, 150 inventory fact rows, 10 products, and 20 customers. Counts can differ if the database export is updated.

### 3. Configure the Python ETL project

Open a terminal in the `SuperMart_Python_Project` folder:

```powershell
cd SuperMart_Python_Project
```

Create and activate a virtual environment:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

If PowerShell blocks activation, run this for the current terminal session and activate again:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
.\.venv\Scripts\Activate.ps1
```

Install the dependencies:

```powershell
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

Create your local `.env` file by copying `.env.example`:

```powershell
Copy-Item .env.example .env
```

Open `.env` and enter the connection details for your own MySQL installation:

```dotenv
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=YOUR_LOCAL_MYSQL_PASSWORD

POS_DB=supermart_pos
PRODUCT_DB=supermart_products
DW_DB=supermart_dw
```

Change the port if your MySQL Server uses a different one. Replace the password placeholder with your local MySQL password.

**Never commit `.env` or real database credentials to GitHub.** The `.gitignore` in this repository excludes `.env` and virtual environments.

### 4. Test the Python environment and database connection

With the virtual environment active, run:

```powershell
python etl/test_setup.py
python etl/test_connections.py
```

The first command checks the installed Python packages. The second tests connectivity to all three configured databases. Resolve any connection errors before running ETL scripts.

### 5. Open the Power BI dashboard

1. Open `SuperMart_Dashboard.pbix` using Power BI Desktop.
2. Check the report pages, including Sales and Inventory.
3. In Power BI, go to **File → Options and settings → Data source settings**.
4. Select the MySQL data source and update its server/database details for your local MySQL instance if required.
5. Update credentials under **Edit Permissions** if prompted.
6. Select **Home → Refresh**.
7. If Power BI asks for a MySQL driver, install the compatible connector requested by your Power BI version, restart Power BI, and refresh again.
8. Save a local copy of the PBIX after a successful refresh.

Cached visuals may appear before a live refresh. A successful refresh is needed to confirm the report is connected to your own database.

## Running the ETL scripts

The database dump already contains warehouse data, so **you do not need to run ETL scripts just to open and view the dashboard**.

After confirming that the source tables, destination tables, `.env` configuration, and CSV inputs are correct, the ETL scripts can be run from the `SuperMart_Python_Project` directory:

```powershell
python etl/load_dimensions.py
python etl/load_fact_sales.py
python etl/load_fact_inventory.py
```

Run only the scripts you intend to execute and understand their load behaviour first. In particular, the inventory loader performs a full-refresh operation and can replace existing inventory fact data. Back up the warehouse before running it. Do not run these commands against a database containing important data without reviewing the scripts and confirming the intended refresh process.

## Troubleshooting

| Problem | What to check |
|---|---|
| MySQL connection fails | Confirm the MySQL service is running; verify host, port, username, and password in `.env`. |
| `ModuleNotFoundError` | Activate the project virtual environment and run `python -m pip install -r requirements.txt`. |
| PowerShell activation is blocked | Use the process-scoped execution policy command shown above. |
| Power BI refresh fails | Check the MySQL driver, source server, database, credentials, and schema names. |
| CSV file not found | Keep the `data_sources` folder in the Python project root beside `etl`. |
| Dashboard numbers differ | Check that Power BI is connected to `supermart_dw` and compare the current warehouse data with the export-time reference counts. |
| SQL import reports existing objects | Stop and inspect the target schemas; do not repeatedly import without checking for partial imports or backing up existing data. |

## Security and data handling

- Do not upload `.env`, passwords, private keys, or personal credentials.
- Do not upload real customer or business-sensitive data without permission.
- Review the SQL dump and CSV files before making the repository public. Replace personal or confidential records with synthetic/anonymised sample data where necessary.
- The SQL dump can create and drop tables. Import it only into a suitable test environment or after taking a backup.
- Do not commit `.venv`, IDE folders, temporary archives, or generated cache files.

## Project documentation

See [`SuperMart_Complete_Installation_Guide.pdf`](SuperMart_Complete_Installation_Guide.pdf) for the original Windows installation and transfer guide.

## Project purpose

This project is intended as a learning and demonstration example of a retail data warehouse, Python-based ETL processing, and Power BI business intelligence reporting.

## Author

Add your name and GitHub profile here.

## License

No license has been specified. Unless you add a license file, standard copyright applies and others do not automatically receive permission to reuse or distribute this project.
