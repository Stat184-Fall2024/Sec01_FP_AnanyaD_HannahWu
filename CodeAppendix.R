# Cotton and Cottonseed Price From 1910 to 1938 ----
# Author: Ananya Drishti, Ekansh Bharadwaj, Hannah Wu
# Class: STAT 184 Section 1

## Goal ----
# Uncover insights into price trends
# Identify key patterns
# Provide a foundation for understanding the economic dynamics

## Necessary Work ----
# Load packages
library(dplyr)  # For data manipulation
library(readr)  # For reading and writing CSV files
library(moments)  # For calculating skewness and kurtosis
library(ggplot2)  # For creating visualizations

# Set working directory to desired path, making sure any saved files will be stored in the specified location
# Please change as needed, example: 
setwd("C:\\Users\\ekans\\Desktop\\STAT 184\\Group Project")

# Load datasets from URL, these URLs direct to NBER's Macrohistory Database
# U.S. Farm Prices of Cottonseed 09/1910-06/1938
url_CS <- "https://data.nber.org/databases/macrohistory/rectdata/04/m04006aa.dat"
# U.S. Wholesale Price of Cotton, New York; 10 Markets 09/1870-12/1945
url_C <- "https://data.nber.org/databases/macrohistory/rectdata/04/m04006a.dat"

# Read data from the URLs into R as data frames
# `skip = 1` skips the first row if it contains non-data content, such as a header
data_CS <- read.table(url_CS, header = FALSE, stringsAsFactors = FALSE, skip = 1)
data_C <- read.table(url_C, header = FALSE, stringsAsFactors = FALSE, skip = 1)



## Clean and Merge Data ----
# Assign column names to the datasets for better readability and usability
colnames(data_CS) <- c("Year", "Month", "Cottonseed_Price") 
colnames(data_C) <- c("Year", "Month", "Cotton_Wholesale_Price") 

# Ensure price columns are numeric for the compatibility of statistical calculations
data_CS$Cottonseed_Price <- as.numeric(data_CS$Cottonseed_Price)
data_C$Cotton_Wholesale_Price <- as.numeric(data_C$Cotton_Wholesale_Price)

# Filter `data_C` to include only records from 1910 to 1938
data_C_filtered <- data_C %>%
  filter(Year >= 1910 & Year <= 1938)

# Merge the two datasets base on common columns "Year" and "Month"
merged_data <- inner_join(data_CS, data_C_filtered, by = c("Year", "Month"))

# Filter out rows where "Cottonseed_Price" or "Cotton_Wholesale_Price" contains missing values
data <- merged_data %>%
  filter(!is.na(Cottonseed_Price), !is.na(Cotton_Wholesale_Price))

### Optional ----
# Save the datasets as CSV files if needed
# `row.names = FALSE` ensures that row numbers are not included in the saved file
write.csv(data_CS, file = "Cottonseed_Prices_1910_1938.csv", row.names = FALSE)
write.csv(data_C_filtered, file = "Cotton_Wholesale_Prices_1910_1938.csv", row.names = FALSE)
write.csv(data, file = "Merged_Cotton_Cottonseed_Prices.csv", row.names = FALSE)
# Print a message to confirm successful saving of the files
cat("Files successfully saved in your specified directory.")



## Summary Statistics ----
# Create a data frame summarizing various statistical metrics for both Cottonseed_Price and Cotton_Wholesale_Price
summary_stats <- data.frame(
  Metric = c(
    "Count", "Mean", "SD", "Median", "Min", "Max", "Range", 
    "Q1", "Q3", "IQR", "Skewness", "Kurtosis"  # Metrics calculated for both price columns
  ),
  # Calculate each metric for Cottonseed_Price
  Cottonseed = c(
    nrow(data),                           # Count of observations
    mean(data$Cottonseed_Price),          # Mean
    sd(data$Cottonseed_Price),            # Standard deviation
    median(data$Cottonseed_Price),        # Median
    min(data$Cottonseed_Price),           # Minimum value
    max(data$Cottonseed_Price),           # Maximum value
    max(data$Cottonseed_Price) - min(data$Cottonseed_Price),  # Range
    quantile(data$Cottonseed_Price, 0.25),  # First quartile (Q1)
    quantile(data$Cottonseed_Price, 0.75),  # Third quartile (Q3)
    IQR(data$Cottonseed_Price),           # Interquartile range
    skewness(data$Cottonseed_Price),      # Skewness
    kurtosis(data$Cottonseed_Price)       # Kurtosis
  ),
  # Calculate each metric for Cotton_Wholesale_Price
  Cotton_Wholesale = c(
    nrow(data),                           # Count of observations
    mean(data$Cotton_Wholesale_Price),    # Mean
    sd(data$Cotton_Wholesale_Price),      # Standard deviation
    median(data$Cotton_Wholesale_Price),  # Median
    min(data$Cotton_Wholesale_Price),     # Minimum value
    max(data$Cotton_Wholesale_Price),     # Maximum value
    max(data$Cotton_Wholesale_Price) - min(data$Cotton_Wholesale_Price),  # Range
    quantile(data$Cotton_Wholesale_Price, 0.25),  # First quartile (Q1)
    quantile(data$Cotton_Wholesale_Price, 0.75),  # Third quartile (Q3)
    IQR(data$Cotton_Wholesale_Price),     # Interquartile range
    skewness(data$Cotton_Wholesale_Price),  # Skewness
    kurtosis(data$Cotton_Wholesale_Price)   # Kurtosis
  )
)

### Optional ----
# Print the summary statistics (data frame will not save as file)
print(summary_stats)
# Or save the data frame as CSV files if needed
write.csv(summary_stats, file = "summary_stats.csv", row.names = FALSE)
# Print a message to confirm successful saving of the files
cat("Files successfully saved in your specified directory.")



## Visualizations ----
### Boxplots ----
# Side-by-side boxplots for cottonseed and cotton wholesale prices
# Provide a visual summary of the distribution, including medians and outliers
Boxplots <- ggplot(data) +
  # Add a boxplot for Cottonseed prices
  geom_boxplot(aes(x = "Cottonseed", y = Cottonseed_Price, fill = "Cottonseed"), alpha = 0.6) +
  # Add a boxplot for Cotton Wholesale prices
  geom_boxplot(aes(x = "Cotton Wholesale", y = Cotton_Wholesale_Price, fill = "Cotton Wholesale"), alpha = 0.6) +
  # Customize the fill colors for the boxplots
  scale_fill_manual(values = c("Cottonseed" = "blue", "Cotton Wholesale" = "red")) +
  # Add plot title and axis labels
  labs(title = "Side-by-Side Boxplots", x = "Type", y = "Price") +
  # Apply a minimal theme for a clean appearance
  theme_minimal()

#### Optional ----
# Save the plot as a PNG file with specified dimensions if needed
ggsave("Side_by_Side_Boxplots.png", plot = Boxplots, width = 8, height = 5)


### Density Plot ----
# Visualize the distributions of cottonseed and wholesale prices
DensityPlot <- ggplot() +
  # Add a density curve for Cottonseed prices
  geom_density(data = data, aes(x = Cottonseed_Price, fill = "Cottonseed"), alpha = 0.5) +
  # Add a density curve for Cotton Wholesale prices
  geom_density(data = data, aes(x = Cotton_Wholesale_Price, fill = "Cotton Wholesale"), alpha = 0.5) +
  # Customize the fill colors for the density plots
  scale_fill_manual(values = c("Cottonseed" = "blue", "Cotton Wholesale" = "red")) +
  # Add plot title and axis labels
  labs(title = "Density Plot of Cottonseed and Wholesale Prices", x = "Price", y = "Density") +
  # Apply a minimal theme for a clean appearance
  theme_minimal()

#### Optional ----
# Save the plot as a PNG file with specified dimensions if needed
ggsave("Density_Plots.png", plot = DensityPlot, width = 8, height = 5)


### Scatter Plot ----
# Scatter plot with a trend line to observe the relationship between cottonseed and wholesale prices
ScatterPlot <- ggplot(data, aes(x = Cottonseed_Price, y = Cotton_Wholesale_Price)) +
  # Add points to the scatter plot
  geom_point(color = "blue", alpha = 0.6) +
  # Add a linear regression trend line
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  # Add plot title and axis labels
  labs(title = "Scatter Plot with Trend Line", 
       x = "Cottonseed Price", 
       y = "Cotton Wholesale Price") +
  # Apply a minimal theme for a clean and professional appearance
  theme_minimal()

#### Optional ----
# Save the plot as a PNG file with specified dimensions if needed
ggsave("Scatter_Plot_Trend_Line.png", plot = ScatterPlot, width = 8, height = 5)


### Histogram ----
# Histogram to visualize the freq. dist. of prices for cotton and cottonseed
Histogram <- ggplot(data) +
  geom_histogram(aes(x = Cottonseed_Price, fill = "Cottonseed"), 
                 bins = 20, alpha = 0.6, position = "identity") +
  geom_histogram(aes(x = Cotton_Wholesale_Price, fill = "Cotton Wholesale"), 
                 bins = 20, alpha = 0.6, position = "identity") +
  # Customize the fill colors for the plot
  scale_fill_manual(values = c("Cottonseed" = "blue", 
                               "Cotton Wholesale" = "red")) +
  # Add plot title and axis labels
  labs(title = "Side-by-Side Histograms", x = "Price", y = "Frequency") +
  # Apply a minimal theme for a clean and professional appearance
  theme_minimal()

#### Optional ----
# Save the plot as a PNG file with specified dimensions if needed
ggsave("Histogram.png", plot = Histogram, width = 8, height = 5)


### Line Plot ----
# Plotting price trends over time
LinePlot <- ggplot(data, aes(x = Year)) +
  geom_line(aes(y = Cotton_Wholesale_Price, color = "Cotton Price")) +
  geom_line(aes(y = Cottonseed_Price, color = "Cottonseed Price")) +
  # Customize the fill colors for the plot
  scale_fill_manual(values =c("Cottonseed"=" blue","Cotton Wholesale"= "red")) +
  # Add plot title and axis labels
  labs(title = "Price Trends of Cotton and Cottonseed (1910-1938)--Line Plot",
       x = "Year", y = "Price (in USD)") +
  # Apply a minimal theme for a clean and professional appearance
  theme_minimal()

#### Optional ----
# Save the plot as a PNG file with specified dimensions if needed
ggsave("Line_Plot.png", plot = LinePlot, width = 8, height = 5)



## Anomaly Detection ----
### Identify Outliers Using Z-Scores ----
anamoly_data <- data %>% 
  mutate(Cottonseed_Z = (Cottonseed_Price - mean(Cottonseed_Price)) / 
           sd(Cottonseed_Price),
         Cotton_Z = (Cotton_Wholesale_Price - mean(Cotton_Wholesale_Price)) / 
           sd(Cotton_Wholesale_Price))

outliers <- anamoly_data %>% filter(abs(Cottonseed_Z) > 2 | abs(Cotton_Z) > 2)
summary_outliers <- summary(outliers)
knitr::kable( outliers, 
              caption = "Outliers in Cotton and Cottonseed Prices (1910–1938)") 

### Highlighting Outliers on the Line Plot ----
ggplot(anamoly_data, aes(x = Year)) +
  geom_line(aes(y = Cottonseed_Price, color = "Cottonseed Price")) +
  geom_line(aes(y = Cotton_Wholesale_Price, color = "Cotton Price")) +
  geom_point(data = outliers, aes(x = Year, y = Cottonseed_Price), 
             color = "yellow", size = 3) +
  labs(title = "Anomalies in Cotton and Cottonseed Prices", y = "Price (USD)") +
  theme_minimal()



## Statistical Analysis ----
### Time Series Decomposition ----
ts_data <- ts(data$Cottonseed_Price, start = c(1910, 1), frequency = 12)
ts_decomp <- decompose(ts_data)
plot(ts_decomp)

### Hypothesis Testing: Correlation ----
# Test for association between paired samples- CottonSeed & Cotton Price
cor_test <- cor.test(data$Cottonseed_Price, data$Cotton_Wholesale_Price)
cor_test

### Predictive Modeling - Linear Regression ----
# Uses Fitting Linear Model(lm) to calculate
model <- lm(Cotton_Wholesale_Price ~ Cottonseed_Price, data = data) 
summary(model)
