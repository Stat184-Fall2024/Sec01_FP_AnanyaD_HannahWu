# Load necessary libraries
library(ggplot2)  # For creating visualizations
library(dplyr)    # For data manipulation
library(zoo)      # For calculating rolling (moving) averages

# Load the dataset from the specified file path
# The dataset contains cottonseed and cotton wholesale price data
file_path <- "C:\\Users\\ekans\\Desktop\\STAT 184\\Group Project\\Merged_Cotton_Cottonseed_Prices.csv"
data <- read.csv(file_path, stringsAsFactors = FALSE)

# Ensure the relevant columns are numeric
# Convert the Cottonseed_Price and Cotton_Wholesale_Price columns to numeric format
# This step ensures the data is suitable for mathematical operations and plotting
data$Cottonseed_Price <- as.numeric(data$Cottonseed_Price)
data$Cotton_Wholesale_Price <- as.numeric(data$Cotton_Wholesale_Price)

# Filter out rows with missing values (NA) in the relevant columns
# This step cleans the dataset to ensure accurate calculations and visualizations
cleaned_data <- data %>%
  filter(!is.na(Cottonseed_Price) & !is.na(Cotton_Wholesale_Price))

# Calculate moving averages with a 5-point rolling window
# `zoo::rollmean()` is used to compute the rolling mean for Cottonseed_Price and Cotton_Wholesale_Price
# `fill = NA` ensures that missing values are filled for indices without enough data points
# `align = "right"` aligns the moving average to the right, meaning the average includes the current and prior 4 points
cleaned_data <- cleaned_data %>%
  mutate(
    MA_Cottonseed = zoo::rollmean(Cottonseed_Price, 5, fill = NA, align = "right"),
    MA_Cotton_Wholesale = zoo::rollmean(Cotton_Wholesale_Price, 5, fill = NA, align = "right")
  )

# Plot the moving averages to observe smoothed trends over time
ggplot(cleaned_data, aes(x = 1:nrow(cleaned_data))) +
  # Add a line for the moving average of Cottonseed prices
  geom_line(aes(y = MA_Cottonseed, color = "Cottonseed (MA)"), size = 1) +
  # Add a line for the moving average of Cotton Wholesale prices
  geom_line(aes(y = MA_Cotton_Wholesale, color = "Cotton Wholesale (MA)"), size = 1) +
  # Customize the colors for the moving average lines
  scale_color_manual(values = c("Cottonseed (MA)" = "blue", "Cotton Wholesale (MA)" = "red")) +
  # Add plot title, axis labels, and legend title
  labs(title = "Moving Average Trend of Cottonseed and Wholesale Prices", 
       x = "Index (Time)",  # Since no explicit time variable exists, an index is used
       y = "Price (Moving Average)", 
       color = "Type") +
  # Apply a minimal theme for a clean and professional appearance
  theme_minimal() +
  # Save the plot as a PNG file with specified dimensions
  ggsave("Moving_Average_Trends.png", width = 8, height = 5)
