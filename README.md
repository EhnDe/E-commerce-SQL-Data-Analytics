# 🛒 E-commerce-SQL-Data-Analytics (ZEPTO)

A real-world **data analytics portfolio project** using Zepto e-commerce inventory data to explore product performance, pricing, discounts, stock availability, and key business insights. The project simulates an end-to-end analyst workflow, from raw data exploration and cleaning to SQL-based analysis and business-focused insights, demonstrating how data can be transformed into actionable decisions.
The dataset was scraped from [Zepto](https://www.zeptonow.com/) — one of India’s fastest-growing quick-commerce startups. This project simulates real analyst workflows, from raw data exploration to business-focused data analysis.


(https://www.zeptonow.com/) — one of India’s fastest-growing quick-commerce startups. This project simulates real analyst workflows, from raw data exploration to business-focused data analysis.


## 📌 Project Overview

The goal is to simulate how actual data analysts in the e-commerce or retail industries work behind the scenes to use SQL to:

✅ Set up a messy, real-world e-commerce inventory **database**

✅ Perform **Exploratory Data Analysis (EDA)** to explore product categories, availability, and pricing inconsistencies

✅ Implement **Data Cleaning** to handle null values, remove invalid entries, and convert pricing from paise to rupees

✅ Write **business-driven SQL queries** to derive insights around **pricing, inventory, stock availability, revenue** and more

## 📁 Dataset Overview
The dataset was sourced from [Kaggle](https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset/data?select=zepto_v2.csv) and was originally scraped from Zepto’s official product listings. It mimics what you’d typically encounter in a real-world e-commerce inventory system.

Each row represents a unique SKU (Stock Keeping Unit) for a product. Duplicate product names exist because the same product may appear multiple times in different package sizes, weights, discounts, or categories to improve visibility – exactly how real catalog data looks.

🧾 Columns:
- **sku_id:** Unique identifier for each product entry (Synthetic Primary Key)

- **name:** Product name as it appears on the app

- **category:** Product category like Fruits, Snacks, Beverages, etc.

- **mrp:** Maximum Retail Price (originally in paise, converted to ₹)

- **discountPercent:** Discount applied on MRP

- **discountedSellingPrice:** Final price after discount (also converted to ₹)

- **availableQuantity:** Units available in inventory

- **weightInGms:** Product weight in grams

- **outOfStock:** Boolean flag indicating stock availability

- **quantity:** Number of units per package (mixed with grams for loose produce)

## 🔧 Project Workflow

Here’s a step-by-step breakdown of what we do in this project:

### 1. Database & Table Creation
We start by creating a SQL table with appropriate data types:

```sql
CREATE TABLE zepto (
  sku_id SERIAL PRIMARY KEY,
  category VARCHAR(120),
  name VARCHAR(150) NOT NULL,
  mrp NUMERIC(8,2),
  discountPercent NUMERIC(5,2),
  availableQuantity INTEGER,
  discountedSellingPrice NUMERIC(8,2),
  weightInGms INTEGER,
  outOfStock BOOLEAN,
  quantity INTEGER
);
```

### 2. Data Import
- Loaded CSV using pgAdmin's import feature.

 - If you're not able to use the import feature, write this code instead:
```sql
   \copy zepto(category,name,mrp,discountPercent,availableQuantity,
            discountedSellingPrice,weightInGms,outOfStock,quantity)
  FROM 'data/zepto_v2.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF8');
```
- Faced encoding issues (UTF-8 error), which were fixed by saving the CSV file using CSV UTF-8 format.

### 3. 🔍 Data Exploration
- Counted the total number of records in the dataset

- Viewed a sample of the dataset to understand structure and content

- Checked for null values across all columns

- Identified distinct product categories available in the dataset

- Compared in-stock vs out-of-stock product counts

- Detected products present multiple times, representing different SKUs

### 4. 🧹 Data Cleaning
- Identified and removed rows where MRP or discounted selling price was zero

- Converted mrp and discountedSellingPrice from paise to rupees for consistency and readability
  
### 5. 📊 Business Insights
- Found top 10 best-value products based on discount percentage

- Identified high-MRP products that are currently out of stock

- Estimated potential revenue for each product category

- Filtered expensive products (MRP > ₹500) with minimal discount

- Ranked top 5 categories offering highest average discounts

- Calculated price per gram to identify value-for-money products

- Grouped products based on weight into Low, Medium, and Bulk categories

- Measured total inventory weight per product category


## 🛠️ Project Procedures
1. **Open zepto_SQL_data_analysis.sql**

    This file contains:

      - Table creation

      - Data exploration

      - Data cleaning

      - SQL Business analysis
  
2. **Load the dataset into pgAdmin or any other PostgreSQL client**

      - Create a database and run the SQL file

      - Import the dataset (convert to UTF-8 if necessary)
      
      - Data exploration 

2. **Key Business Insights**

# 📊 Zepto Inventory Data Analytics — Project Insights

This project analyzes Zepto's e-commerce inventory data to uncover insights into **product pricing, discounts, inventory availability, category performance, and value-for-money opportunities**.

## 🔍 Key Business Insights

### 1. 🏷️ Top 10 Best-Value Products by Discount

The analysis identified the products offering the highest discount percentages:

| Product                                        | MRP (₹) | Discount (%) |
| ---------------------------------------------- | ------: | -----------: |
| Dukes Waffy Chocolate Wafers                   |      45 |          51% |
| Dukes Waffy Orange Wafers                      |      45 |          51% |
| Dukes Waffy Strawberry Wafers                  |      45 |          51% |
| Ceres Foods Fish Mustard Instant Liquid Masala |     220 |          50% |
| Ceres Foods Laal Maas Instant Liquid Masala    |     220 |          50% |
| Ceres Foods Nalli Nihari Instant Liquid Masala |     220 |          50% |
| Chef's Basket Durum Wheat Elbow Pasta          |     160 |          50% |
| Chef's Basket Durum Wheat Fusilli Pasta        |     160 |          50% |
| Chef's Basket Durum Wheat Penne Pasta          |     160 |          50% |
| Dukes Waffy Chocolate Wafer Rolls              |     150 |          50% |

**Insight:** The highest discounts reached **51%**, with Dukes Waffy wafer products offering the strongest discounts. Several pasta and instant-meal products also offered discounts of **50%**, indicating aggressive promotional pricing in these product segments.

---

### 2. 📦 High-MRP Products That Are Out of Stock

Several relatively high-value products were unavailable despite having high MRP values:

| Product                                      | MRP (₹) |
| -------------------------------------------- | ------: |
| Patanjali Cow's Ghee                         |     565 |
| MamyPoko Pants Standard Diapers, Extra Large |     399 |
| Aashirvaad Atta With Multigrains             |     315 |
| Everest Kashmiri Lal Chilli Powder           |     310 |

**Insight:** Stockouts among higher-priced products may represent **lost revenue opportunities** and highlight products that could require closer inventory monitoring.

---

### 3. 💰 Estimated Revenue by Category

The estimated revenue analysis shows significant variation across product categories.

| Category              | Estimated Revenue (₹) |
| --------------------- | --------------------: |
| Cooking Essentials    |               337,131 |
| Munchies              |               337,131 |
| Personal Care         |               270,849 |
| Paan Corner           |               270,849 |
| Packaged Food         |               224,385 |
| Ice Cream & Desserts  |               224,385 |
| Chocolates & Candies  |               224,385 |
| Home & Cleaning       |               122,661 |
| Health & Hygiene      |                64,180 |
| Dairy, Bread & Batter |                55,051 |
| Beverages             |                55,051 |
| Biscuits              |                25,019 |
| Meats, Fish & Eggs    |                20,693 |
| Fruits & Vegetables   |                10,846 |

**Insight:** **Cooking Essentials and Munchies** generated the highest estimated revenue, while **Fruits & Vegetables** generated the lowest. This highlights major differences in revenue contribution across categories.

---

### 4. 💎 High-MRP Products with Low Discounts

The analysis identified products with an **MRP above ₹500 and discounts below 10%**.

Examples include:

| Product                                | MRP (₹) | Discount (%) |
| -------------------------------------- | ------: | -----------: |
| Dhara Kachi Ghani Mustard Oil Jar      |   1,250 |           8% |
| Saffola Gold (Jar)                     |   1,240 |           0% |
| Dhara Filtered Groundnut Oil (Jar)     |   1,050 |           1% |
| Fortune Rice Bran Health Oil           |   1,050 |           1% |
| Fortune Soyabean Oil                   |   1,005 |           0% |
| Surf Excel Matic Powder Front Load     |     810 |           7% |
| Surf Excel Matic Top Load              |     720 |           9% |
| Pedigree Puppy Dry Dog Food            |     690 |           6% |
| Lizol Double Concentrate Floor Cleaner |     650 |           8% |
| Dove Daily Shine Shampoo               |     645 |           5% |

**Insight:** Several premium and household products maintain **very low discounts despite high MRP**, suggesting stronger pricing power or lower promotional dependency in these product segments.

---

### 5. 🥬 Top 5 Categories by Average Discount

| Category             | Average Discount (%) |
| -------------------- | -------------------: |
| Fruits & Vegetables  |               15.46% |
| Meats, Fish & Eggs   |               11.03% |
| Packaged Food        |                8.32% |
| Ice Cream & Desserts |                8.32% |
| Chocolates & Candies |                8.32% |

**Insight:** **Fruits & Vegetables** offered the highest average discount at **15.46%**, followed by **Meats, Fish & Eggs at 11.03%**. This suggests that fresh-food categories rely more heavily on promotional pricing.

---

### 6. ⚖️ Best Value by Price per Gram

Products weighing more than 100g were evaluated based on their **discounted selling price per gram**.

| Product                                    | Weight (g) | Selling Price (₹) | Price/g (₹) |
| ------------------------------------------ | ---------: | ----------------: | ----------: |
| Aashirvaad Iodised Salt                    |      1,000 |                19 |        0.02 |
| Onion                                      |      1,000 |                21 |        0.02 |
| Onion                                      |      3,000 |                57 |        0.02 |
| Shubh Kart Nirmal Sugandhi Mogra Wet Dhoop |      1,160 |                28 |        0.02 |
| Tata Salt                                  |      1,000 |                24 |        0.02 |
| Vicks Cough Drops Menthol                  |      1,160 |                20 |        0.02 |
| Baby Potato                                |        500 |                16 |        0.03 |
| Beetroot                                   |        500 |                13 |        0.03 |
| Carrot                                     |        500 |                15 |        0.03 |
| Potato                                     |      1,000 |                29 |        0.03 |

**Insight:** Bulk and larger-pack products generally provide strong value when measured on a per-gram basis. Staples such as **salt, onions, and potatoes** demonstrate particularly low unit costs.

---

### 7. 📏 Product Weight Classification

Products were grouped into **Low, Medium, and Bulk** weight categories to better understand inventory characteristics.

| Product          | Weight (g) | Weight Category |
| ---------------- | ---------: | --------------- |
| Onion            |      1,000 | Medium          |
| Tomato Hybrid    |      1,000 | Medium          |
| Tender Coconut   |         58 | Low             |
| Coriander Leaves |        100 | Low             |
| Ladies Finger    |        250 | Low             |
| Potato           |      1,000 | Medium          |
| Lemon            |        200 | Low             |
| Watermelon       |         58 | Low             |
| Capsicum Green   |        250 | Low             |
| Chilli Green     |        100 | Low             |

**Insight:** Most of the analyzed products fall into the **Low-weight category**, while staple vegetables such as onions, potatoes, and tomatoes fall into the Medium category.

---

### 8. 📦 Inventory Weight by Category

Inventory weight analysis was used to understand the physical volume represented by different product groups.

| Product          | Weight (g) | Weight Category |
| ---------------- | ---------: | --------------- |
| Onion            |      1,000 | Medium          |
| Tomato Hybrid    |      1,000 | Medium          |
| Potato           |      1,000 | Medium          |
| Tender Coconut   |         58 | Low             |
| Coriander Leaves |        100 | Low             |
| Ladies Finger    |        250 | Low             |
| Lemon            |        200 | Low             |
| Watermelon       |         58 | Low             |
| Capsicum Green   |        250 | Low             |
| Chilli Green     |        100 | Low             |

**Insight:** Weight classification provides an additional perspective on inventory management by highlighting products that may require different **storage, handling, and replenishment strategies**.

---

## 📌 Overall Business Takeaways

The analysis highlights several important business patterns:

* **Cooking Essentials and Munchies** are the strongest estimated revenue contributors.
* **Fruits & Vegetables** have the highest average discount, indicating greater promotional activity.
* Several **high-MRP products have minimal discounts**, suggesting stronger pricing power.
* **High-value stockouts** represent potential lost-sales opportunities.
* Bulk products can provide significantly better **value per gram**.
* Weight-based segmentation can support more effective **inventory, storage, and logistics planning**.
* Discount analysis can help identify opportunities for **pricing optimization and promotional strategy**.

### 🎯 Conclusion

This project demonstrates how e-commerce inventory data can be transformed into **actionable business insights**. By combining pricing, discount, revenue, availability, and inventory-weight analysis, the project provides a practical view of how data analytics can support **pricing decisions, inventory optimization, revenue growth, and operational efficiency**.

