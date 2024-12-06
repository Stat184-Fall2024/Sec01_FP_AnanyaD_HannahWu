# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load dataset
file_path <- "C:\\Users\\ekans\\Desktop\\STAT 184\\Group Project\\Merged_Cotton_Cottonseed_Prices.csv"
data <- read.csv(file_path, stringsAsFactors = FALSE)

# Ensure columns are numeric
data$Cottonseed_Price <- as.numeric(data$Cottonseed_Price)
data$Cotton_Wholesale_Price <- as.numeric(data$Cotton_Wholesale_Price)

# Filter out NA values
cleaned_data <- data %>%
  filter(!is.na(Cottonseed_Price) & !is.na(Cotton_Wholesale_Price))

# Create a line plot for trends
ggplot(cleaned_data, aes(x = 1:nrow(cleaned_data))) +
  geom_line(aes(y = Cottonseed_Price, color = "Cottonseed"), size = 1) +
  geom_line(aes(y = Cotton_Wholesale_Price, color = "Cotton Wholesale"), size = 1) +
  scale_color_manual(values = c("Cottonseed" = "blue", "Cotton Wholesale" = "red")) +
  labs(title = "Trend of Cottonseed and Wholesale Prices Over Time", 
       x = "Index (Time)", y = "Price", color = "Type") +
  theme_minimal() +
  ggsave("Line_Plot_Trends.png", width = 8, height = 5)
