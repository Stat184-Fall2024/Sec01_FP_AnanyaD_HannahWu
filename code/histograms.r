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

# Create side-by-side histograms to compare the distributions of cottonseed and wholesale prices
ggplot(cleaned_data) +
  # Add a histogram for Cottonseed prices
  geom_histogram(aes(x = Cottonseed_Price, fill = "Cottonseed"), 
                 bins = 20, alpha = 0.6, position = "identity") +
  # Add a histogram for Cotton Wholesale prices
  geom_histogram(aes(x = Cotton_Wholesale_Price, fill = "Cotton Wholesale"), 
                 bins = 20, alpha = 0.6, position = "identity") +
  # Customize the fill colors for the histograms
  scale_fill_manual(values = c("Cottonseed" = "blue", "Cotton Wholesale" = "red")) +
  # Add plot title and axis labels
  labs(title = "Side-by-Side Histograms", x = "Price", y = "Frequency") +
  # Apply a minimal theme for a clean and professional appearance
  theme_minimal() +
  # Save the plot as a PNG file with specified dimensions
  ggsave("Side_by_Side_Histograms.png", width = 8, height = 5)
