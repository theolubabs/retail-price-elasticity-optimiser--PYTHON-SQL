# retail-price-elasticity-optimiser--PYTHON-SQL
A retail pricing analytics project that calculates price elasticity for 52 products, classifies them as Elastic, Inelastic or Premium, and delivers optimal markdown recommendations through an interactive Power BI dashboard.

## The Business Problem

Most retailers run blanket promotions across their entire product range without knowing which products actually respond to price changes.

The result is predictable. Some products get discounted when they should not be, destroying margin without driving any extra volume. 
Other products that would massively reward a targeted discount never get one. And some premium products lose loyal customers the moment 
they go on sale because buyers associate the lower price with lower quality.

This project answers the question every retail pricing manager needs answered:

**Which products should we discount, by how much, and what will 
the revenue impact be?**

---

## Solution Overview

This is a full end to end analytics project built across three tools:

- **SQL Server** for data cleaning, preparation, and feature engineering
- **Python** for elasticity modelling and product classification
- **Power BI** for interactive dashboard delivery

The final output is a two page Power BI dashboard that gives retail teams clear, data backed pricing decisions they can act on immediately.

---

## Tools and Technologies

| Tool | Purpose |
|---|---|
| SQL Server | Data ingestion, cleaning, LAG() window functions, feature engineering |
| Python (pandas, numpy, matplotlib) | Elasticity calculation, classification, markdown optimisation |
| Power BI | Interactive dashboard, DAX measures, markdown simulator |
| Excel | Data inspection and CSV export |

---


---

## Insight and Recomendation

### The Data at a Glance
- 52 products analysed across 9 retail categories
- 24 products had sufficient price variation for reliable elasticity calculation
- 12 products classified as Elastic — price cuts drive strong volume increases
- 12 products classified as Inelastic or Premium — price cuts destroy margin with little volume gain
- 5 out of 9 categories are priced ABOVE the competitor average
- 4 out of 9 categories are priced BELOW the competitor average

---

### Insight 1 — The Watches Category Is Leaving Revenue on the Table
Every single watch product in this dataset sits on the elastic side. 
watches6 has an elasticity score of -15.78, watches5 at -9.49, watches7 at -8.16, and watches2 at -5.59.

What this means: when watch prices drop, customers respond immediately and volume increases significantly.

But here is the problem. The watches category is priced an average of $30.12 ABOVE the competitor average. Customers are being asked to 
pay more for products they are already price sensitive about. That combination of high elasticity and above market pricing is a direct 
cause of lost sales.

**Recommendation:** Run targeted price reductions on watch products bringing them closer to the competitor average. 
Based on the elasticity scores the optimal discounts range from 5.96% to 15.18%. These are not blanket promotions. They are surgical price adjustments that will drive measurable volume increases.

---

### Insight 2 — Health and Beauty Products Are Being Under-Priced by Perception
health5 has an elasticity of +39.93 and health3 sits at +25.90. 
These are positive elasticity scores meaning when prices go up, demand goes up too.

The health beauty category is also priced an average of $66 ABOVE the competitor average — the highest premium gap of all 9 categories.

What this tells us is that customers in this category are not shopping on price. They are shopping on perceived quality and brand trust. A higher price signals a better product to them.

**Recommendation:** Never discount health and beauty products. Not even during sale seasons. Every time these products go 
on sale you are sending a signal to your most loyal customers that the product is not as premium as they believed. Instead invest in 
packaging, storytelling, and positioning to justify and even increase the price premium further.

---

### Insight 3 — The Bed Bath Table Category Has a Hidden Revenue Engine
bed3 is the single most elastic product in the entire dataset with a score of -19.16. A 5% price reduction on bed3 drives approximately 
a 95% increase in units sold. That is not a promotion. That is a revenue engine sitting completely unused.

Meanwhile bed2 sits at +35.56 — a strongly premium product in the same category. And the bed bath table category overall is priced 
almost exactly at the competitor average with a gap of just -$0.26.

**Recommendation:** Split the bed bath table category into two completely different pricing strategies. Run 
aggressive targeted discounts on bed3 and bed4 to drive volume. Protect and position bed2 as a premium product with zero discounting. 
These two products should never be treated the same way in a promotion again.

---

### Insight 4 — Computers and Accessories Are Priced Too Low Against Competitors
The computers accessories category is priced an average of $12.72 BELOW the competitor average — the largest negative gap of all 9 
categories. Yet computers2 shows an elasticity of +27.92 indicating premium buying behaviour from customers.

This means the business is under-charging for products that customers would happily pay more for.

**Recommendation:** Test a gradual price increase on computers2 and computers3. Based on the positive elasticity 
scores, raising prices on these products is likely to maintain or even increase demand while significantly improving margin per unit.

---

### Insight 5 — Furniture Decor Is Sending Mixed Signals
furniture1 has an elasticity of -2.22 meaning it responds to discounts. But furniture3 sits at +40.37 — the highest premium 
signal in the entire dataset. Yet the furniture decor category is priced an average of $9.96 BELOW the competitor average.

This means a premium product is being sold at a discount to the market without any strategic reason.

**Recomendation:** Immediately stop discounting furniture3. Raise its price to at least the competitor average and 
monitor whether demand holds. Based on the elasticity score it almost certainly will. For furniture1 small targeted discounts 
of around 30% are justified to drive volume since it genuinely responds to price reductions.

---

## Business Impact Summary

| Category | Pricing Position | Strategy |
|---|---|---|
| health_beauty | $66 above market | Never discount. Protect premium. |
| watches_gifts | $30 above market | Targeted discounts 6% to 15% |
| garden_tools | $24 above market | Mixed — discount garden1-3, protect garden5 |
| cool_stuff | $12.50 above market | Protect inelastic products |
| perfumery | $8 above market | Monitor — small price adjustments only |
| consoles_games | At market | Maintain current pricing |
| bed_bath_table | At market | Split strategy — discount bed3, protect bed2 |
| furniture_decor | $10 below market | Raise furniture3 price immediately |
| computers_accessories | $12.72 below market | Test price increases on premium products |

---

## Key Recommendation

A blanket 20% weekend discount applied across all 9 categories would simultaneously reward the right products and destroy the wrong ones. The watches and garden tool products would respond well. The health beauty, furniture3, and computers2 products would lose loyal customers and margin at the same time.

The difference between a retailer that runs profitable promotions and one that just runs busy ones is knowing which products to discount, which to protect, and which to quietly raise the price on.

That is exactly what this analysis delivers.

## Dashboard Pages

### Page 1 — Elasticity Overview
Shows every product plotted by elasticity score. Red bars indicate elastic products that reward discounting. Green bars indicate inelastic 
or premium products. Includes KPI cards for total products, elastic count, and inelastic count. Interactive category slicer filters all 
visuals simultaneously.

### Page 2 — Markdown Simulator
Select any product from the dropdown. Adjust the discount percentage using the slider. Cards update in real time showing current price, 
current quantity sold, elasticity score, and projected revenue impact of the chosen discount. Turns a gut feel pricing decision into a 
data backed one.

---


## How to Run This Project

### SQL
1. Open SQL Server Management Studio
2. Create a new database called `retail_price_analysis`
3. Import `retail_pricing_final.csv` using the Import Flat File wizard
4. Run the full script in `sql/Retail Price Query.sql`

### Python
1. Open Jupyter Notebook
2. Navigate to the `python/` folder
3. Open `price_elasticity_analysis.ipynb`
4. Run all cells in order
5. Output files will be saved automatically

### Power BI
1. Open Power BI Desktop
2. Open `dashboard/Price_Elasticity_Dashboard.pbix`
3. If prompted to refresh data, point to the CSV files in the 
`data/` folder

---

## Dataset

Source: Kaggle — Retail Price Optimization Case Study
Link: https://www.kaggle.com/datasets/bhanupratapbiswas/retail-price-optimization-case-study

---

## Contact

**Babatunde Oluwatimilehin Isaac**
- LinkedIn: https://www.linkedin.com/in/theolubabs
- Email: theolubabs@gmail.com
- GitHub: https://github.com/theolubabs
