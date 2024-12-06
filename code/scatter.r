# Load necessary library
library(ggplot2)  # For creating visualizations

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

# Create a scatter plot with a trend line to observe the relationship between cottonseed and wholesale prices
ggplot(cleaned_data, aes(x = Cottonseed_Price, y = Cotton_Wholesale_Price)) +
  # Add points to the scatter plot
  geom_point(color = "blue", alpha = 0.6) +
  # Add a linear regression trend line
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  # Add plot title and axis labels
  labs(title = "Scatter Plot with Trend Line", 
       x = "Cottonseed Price", 
       y = "Cotton Wholesale Price") +
  # Apply a minimal theme for a clean and professional appearance
  theme_minimal() +
  # Save the plot as a PNG file with specified dimensions
  ggsave("Scatter_Plot_Trend_Line.png", width = 8, height = 5)
