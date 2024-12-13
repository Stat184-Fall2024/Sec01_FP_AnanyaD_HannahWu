# Cotton and Cottonseed Price Trends (1910-1938)
## Overview
This project explores historical trends in cotton and cottonseed prices from 1910 to 1938. Using data analysis and visualization techniques, it provides insights into pricing patterns and market behavior over time. The repository includes R scripts for data processing, statistical analysis, and graphical representation.

## Repository Contents
### Data Files
- Cotton_Wholesale_Prices_1910_1938.csv: Wholesale prices of cotton from 1910 to 1938.
- Cottonseed_Prices_1910_1938.csv: Cottonseed prices over the same period.
- Merged_Cotton_Cottonseed_Prices.csv: Merged dataset for comparative analysis.
### Scripts
- Clean_merge_data.R: Cleans and merges the raw datasets.
- boxplots.r: Generates boxplots for visualizing price distributions.
- density.r: Creates density plots for a smooth visualization of price trends.
- histograms.r: Produces histograms for price frequency analysis.
- lines.r: Plots line graphs showing pricing trends over time.
- moving_avg.r: Calculates and visualizes moving averages for smoothing trends.
- scatter.r: Draws scatter plots to show relationships between datasets.
- summary_statistics.r: Computes statistical summaries of the data.
### Visualizations
- Density_Plots.png
- Line_Plot_Trends.png
- Scatter_Plot_Trend_Line.png
- Side_by_Side_Boxplots.png
- Side_by_Side_Histograms.png

## How to Use
Prerequisites
- Install R and RStudio.
Ensure the following R packages are installed:

  - **dplyr**: For data manipulation
  - **readr**: For reading and writing CSV files
  - **kableExtra**: For stats and tables 
  - **ggplot2** : For creating visualizations
  - **forecast**: For time series analysis
  - **tsoutliers**: For anomaly detection

## Steps
1. Clone this repository using the following CMD prompt:
   
        git clone https://github.com/Stat184-Fall2024/Sec01_FP_AnanyaD_HannahWu_EkanshB.git

2. Open RStudio and load the desired script file.
3. Run the script to execute the analysis or generate the visualizations.

## Insights
-   **Observed Patterns Price Variability:** Cottonseed prices demonstrated greater variability compared to cotton prices, likely reflecting its emerging market status.

-   **Trends Over Time:** Both commodities exhibited significant price fluctuations during the Great Depression, underscoring the economic impact of the era.

-   **Correlation:** A positive correlation was observed between cotton and cottonseed prices, suggesting interdependence in their market dynamics.

-   **Outliers/Anomalies**: Significant deviations were observed in specific years (e.g., 1929, 1933), corresponding to economic crises like the Great Depression.

-   **Statistical Findings**: A strong positive correlation was confirmed between cotton and cottonseed prices. This suggests interdependence in their market dynamics. There were some years where cottonseed prices were huge compared to the cotton whole sale prices. This shows that there was a bad harvest/oversaturation of cotton etc.

-   **Regression Insights**: The linear regression model highlights a significant positive relationship between cottonseed and wholesale prices, with cottonseed price explaining nearly 73% of the variance.

## Contact

Ananya Drishti - azd6012@psu.edu

Hannah Wu - zmj5109@psu.edu

Ekansh Bharadwaj - ejb6255@psu.edu
