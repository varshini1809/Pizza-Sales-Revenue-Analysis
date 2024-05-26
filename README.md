# Pizza-Sales-Revenue-Analysis
Database empowers store managers to make precise adjustments to enhance customer experience and profitability

**Project Overview:**

This SQL project focuses on a database schema designed to manage and analyze data for a pizza store. The database comprises four main tables: `order_details`, `pizzas`, `orders`, and `pizza_types`. Each table captures different aspects of the store's operations, from individual orders to the types of pizzas available. Below is a detailed description of each table and its columns:

1. **order_details**:
   - `order_details_id`: A unique identifier for each order detail entry.
   - `order_id`: References the ID from the orders table, linking the detail to a specific order.
   - `pizza_id`: References the ID from the pizzas table, identifying the pizza ordered.
   - `quantity`: The number of pizzas ordered of the specified type.

2. **pizzas**:
   - `pizza_id`: A unique identifier for each type of pizza.
   - `pizza_type_id`: Links to the pizza_types table, specifying the type of pizza.
   - `size`: The size of the pizza (e.g., small, medium, large).
   - `price`: The cost of the pizza.

3. **orders**:
   - `order_id`: A unique identifier for each order.
   - `date`: The date the order was placed.
   - `time`: The time the order was placed.

4. **pizza_types**:
   - `pizza_type_id`: A unique identifier for each type of pizza.
   - `name`: The name of the pizza type (e.g., Margherita, Pepperoni).
   - `category`: The category of the pizza (e.g., Vegetarian, Non-Vegetarian).
   - `ingredients`: The ingredients used in the pizza.

**Relevance to a Pizza Sales Store Manager:**

A pizza sales store manager can leverage this SQL project to gain valuable insights and perform detailed data analysis, aiding informed decision-making and efficient store management. Here are some key benefits for the store manager:

- **Sales Analysis**: By querying the `order_details` and `pizzas` tables, managers can identify best-selling pizzas, assess revenue from different pizza sizes, and evaluate pricing strategies.
- **Inventory Management**: Analyzing the `pizza_types` and their ingredients helps manage inventory efficiently, ensuring ingredients are stocked according to demand and minimizing waste.
- **Customer Preferences**: Data from the `orders` and `pizzas` tables allow managers to track customer preferences over time, adjust the menu to popular choices, and introduce new or seasonal offerings.
- **Operational Efficiency**: Date and time data from the `orders` table enable managers to identify peak hours, optimize staffing, and ensure smooth operations and customer satisfaction.
- **Marketing Insights**: Data analysis can support targeted marketing campaigns, such as promotions on popular pizzas or on days with typically lower sales.

**Conclusion:**

- This SQL project serves as both a robust data management system and a strategic business intelligence tool. 
- By maintaining comprehensive data on all aspects of store operations, the database empowers store managers to make precise adjustments to enhance customer experience and profitability.
- When shared on a blog, this project can demonstrate how structured SQL queries can be used to harness data for real-world business applications, providing valuable insights for aspiring data analysts and business owners.          
