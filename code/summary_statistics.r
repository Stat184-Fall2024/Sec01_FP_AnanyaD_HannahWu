# Load necessary libraries
library(dplyr)    # For data manipulation
library(moments)  # For calculating skewness and kurtosis

# Step 1: Load the dataset
# Load the data from the specified file path
# The dataset contains cottonseed and cotton wholesale price data
file_path <- "C:\\Users\\ekans\\Desktop\\STAT 184\\Group Project\\Merged_Cotton_Cottonseed_Prices.csv"
data <- read.csv(file_path, stringsAsFactors = FALSE)

# Step 2: Ensure columns are numeric
# Convert Cottonseed_Price and Cotton_Wholesale_Price columns to numeric format
# This ensures compatibility for statistical calculations
data$Cottonseed_Price <- as.numeric(data$Cottonseed_Price)
data$Cotton_Wholesale_Price <- as.numeric(data$Cotton_Wholesale_Price)

# Step 3: Remove rows with NA values
# Filter out rows where Cottonseed_Price or Cotton_Wholesale_Price contains missing values
# This step cleans the data to ensure accurate calculations
cleaned_data <- data %>%
  filter(!is.na(Cottonseed_Price), !is.na(Cotton_Wholesale_Price))

# Step 4: Calculate summary statistics
# Create a data frame summarizing various statistical metrics for both Cottonseed_Price and Cotton_Wholesale_Price
summary_stats <- data.frame(
  Metric = c(
    "Count", "Mean", "SD", "Median", "Min", "Max", "Range", 
    "Q1", "Q3", "IQR", "Skewness", "Kurtosis"  # Metrics calculated for both price columns
  ),
  # Calculate each metric for Cottonseed_Price
  Cottonseed = c(
    nrow(cleaned_data),                           # Count of observations
    mean(cleaned_data$Cottonseed_Price),          # Mean
    sd(cleaned_data$Cottonseed_Price),            # Standard deviation
    median(cleaned_data$Cottonseed_Price),        # Median
    min(cleaned_data$Cottonseed_Price),           # Minimum value
    max(cleaned_data$Cottonseed_Price),           # Maximum value
    max(cleaned_data$Cottonseed_Price) - min(cleaned_data$Cottonseed_Price),  # Range
    quantile(cleaned_data$Cottonseed_Price, 0.25),  # First quartile (Q1)
    quantile(cleaned_data$Cottonseed_Price, 0.75),  # Third quartile (Q3)
    IQR(cleaned_data$Cottonseed_Price),           # Interquartile range
    skewness(cleaned_data$Cottonseed_Price),      # Skewness
    kurtosis(cleaned_data$Cottonseed_Price)       # Kurtosis
  ),
  # Calculate each metric for Cotton_Wholesale_Price
  Cotton_Wholesale = c(
    nrow(cleaned_data),                           # Count of observations
    mean(cleaned_data$Cotton_Wholesale_Price),    # Mean
    sd(cleaned_data$Cotton_Wholesale_Price),      # Standard deviation
    median(cleaned_data$Cotton_Wholesale_Price),  # Median
    min(cleaned_data$Cotton_Wholesale_Price),     # Minimum value
    max(cleaned_data$Cotton_Wholesale_Price),     # Maximum value
    max(cleaned_data$Cotton_Wholesale_Price) - min(cleaned_data$Cotton_Wholesale_Price),  # Range
    quantile(cleaned_data$Cotton_Wholesale_Price, 0.25),  # First quartile (Q1)
    quantile(cleaned_data$Cotton_Wholesale_Price, 0.75),  # Third quartile (Q3)
    IQR(cleaned_data$Cotton_Wholesale_Price),     # Interquartile range
    skewness(cleaned_data$Cotton_Wholesale_Price),  # Skewness
    kurtosis(cleaned_data$Cotton_Wholesale_Price)   # Kurtosis
  )
)

# Print the summary statistics data frame
print(summary_stats)
