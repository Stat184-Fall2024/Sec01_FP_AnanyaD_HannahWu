# Load necessary libraries
library(ggplot2)  # For creating visualizations
library(dplyr)    # For data manipulation

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
# This step cleans the dataset to ensure accurate plotting and analysis
cleaned_data <- data %>%
  filter(!is.na(Cottonseed_Price) & !is.na(Cotton_Wholesale_Price))

# Create a line plot to visualize trends in cottonseed and wholesale prices over time
ggplot(cleaned_data, aes(x = 1:nrow(cleaned_data))) +
  # Add a line for Cottonseed prices
  geom_line(aes(y = Cottonseed_Price, color = "Cottonseed"), size = 1) +
  # Add a line for Cotton Wholesale prices
  geom_line(aes(y = Cotton_Wholesale_Price, color = "Cotton Wholesale"), size = 1) +
  # Customize the colors for the lines
  scale_color_manual(values = c("Cottonseed" = "blue", "Cotton Wholesale" = "red")) +
  # Add plot title, axis labels, and legend title
  labs(title = "Trend of Cottonseed and Wholesale Prices Over Time", 
       x = "Index (Time)",  # Since no explicit time variable exists, an index is used
       y = "Price", 
       color = "Type") +
  # Apply a minimal theme for a clean and professional appearance
  theme_minimal() +
  # Save the plot as a PNG file with specified dimensions
  ggsave("Line_Plot_Trends.png", width = 8, height = 5)
