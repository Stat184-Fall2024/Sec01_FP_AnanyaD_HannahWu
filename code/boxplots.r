library(ggplot2)  # For creating visualizations
library(dplyr)    # For data manipulation

# Load the dataset from the specified file path
# The dataset contains information about cottonseed and cotton wholesale prices
file_path <- "C:\\Users\\ekans\\Desktop\\STAT 184\\Group Project\\Merged_Cotton_Cottonseed_Prices.csv"
data <- read.csv(file_path, stringsAsFactors = FALSE)

# Ensure columns are numeric
# Convert the Cottonseed_Price and Cotton_Wholesale_Price columns to numeric format
# This step ensures compatibility for mathematical operations and plotting
data$Cottonseed_Price <- as.numeric(data$Cottonseed_Price)
data$Cotton_Wholesale_Price <- as.numeric(data$Cotton_Wholesale_Price)

# Filter out rows with missing values (NA) in the relevant columns
# This step cleans the data to prevent issues during analysis or visualization
cleaned_data <- data %>%
  filter(!is.na(Cottonseed_Price) & !is.na(Cotton_Wholesale_Price))

# Create side-by-side boxplots for cottonseed and cotton wholesale prices
# Boxplots provide a visual summary of the distribution, including medians and outliers
ggplot(cleaned_data) +
  # Add a boxplot for Cottonseed prices
  geom_boxplot(aes(x = "Cottonseed", y = Cottonseed_Price, fill = "Cottonseed"), alpha = 0.6) +
  # Add a boxplot for Cotton Wholesale prices
  geom_boxplot(aes(x = "Cotton Wholesale", y = Cotton_Wholesale_Price, fill = "Cotton Wholesale"), alpha = 0.6) +
  # Customize the fill colors for the boxplots
  scale_fill_manual(values = c("Cottonseed" = "blue", "Cotton Wholesale" = "red")) +
  # Add plot title and axis labels
  labs(title = "Side-by-Side Boxplots", x = "Type", y = "Price") +
  # Apply a minimal theme for a clean appearance
  theme_minimal() +
  # Save the plot as a PNG file with specified dimensions
  ggsave("Side_by_Side_Boxplots.png", width = 8, height = 5)
