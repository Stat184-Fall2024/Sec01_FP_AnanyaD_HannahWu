# Load necessary libraries
library(dplyr)
library(moments)  # For skewness and kurtosis

# Step 1: Load the dataset
file_path <- "C:\\Users\\ekans\\Desktop\\STAT 184\\Group Project\\Merged_Cotton_Cottonseed_Prices.csv"
data <- read.csv(file_path, stringsAsFactors = FALSE)

# Step 2: Ensure columns are numeric
data$Cottonseed_Price <- as.numeric(data$Cottonseed_Price)
data$Cotton_Wholesale_Price <- as.numeric(data$Cotton_Wholesale_Price)

# Step 3: Remove rows with NA values
cleaned_data <- data %>%
  filter(!is.na(Cottonseed_Price), !is.na(Cotton_Wholesale_Price))

# Step 4: Calculate summary statistics
summary_stats <- data.frame(
  Metric = c(
    "Count", "Mean", "SD", "Median", "Min", "Max", "Range", 
    "Q1", "Q3", "IQR", "Skewness", "Kurtosis"
  ),
  Cottonseed = c(
    nrow(cleaned_data),
    mean(cleaned_data$Cottonseed_Price),
    sd(cleaned_data$Cottonseed_Price),
    median(cleaned_data$Cottonseed_Price),
    min(cleaned_data$Cottonseed_Price),
    max(cleaned_data$Cottonseed_Price),
    max(cleaned_data$Cottonseed_Price) - min(cleaned_data$Cottonseed_Price),
    quantile(cleaned_data$Cottonseed_Price, 0.25),
    quantile(cleaned_data$Cottonseed_Price, 0.75),
    IQR(cleaned_data$Cottonseed_Price),
    skewness(cleaned_data$Cottonseed_Price),
    kurtosis(cleaned_data$Cottonseed_Price)
  ),
  Cotton_Wholesale = c(
    nrow(cleaned_data),
    mean(cleaned_data$Cotton_Wholesale_Price),
    sd(cleaned_data$Cotton_Wholesale_Price),
    median(cleaned_data$Cotton_Wholesale_Price),
    min(cleaned_data$Cotton_Wholesale_Price),
    max(cleaned_data$Cotton_Wholesale_Price),
    max(cleaned_data$Cotton_Wholesale_Price) - min(cleaned_data$Cotton_Wholesale_Price),
    quantile(cleaned_data$Cotton_Wholesale_Price, 0.25),
    quantile(cleaned_data$Cotton_Wholesale_Price, 0.75),
    IQR(cleaned_data$Cotton_Wholesale_Price),
    skewness(cleaned_data$Cotton_Wholesale_Price),
    kurtosis(cleaned_data$Cotton_Wholesale_Price)
  )
)

print(summary_stats)
