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

# Calculate moving averages (5 pt average)
cleaned_data <- cleaned_data %>%
  mutate(
    MA_Cottonseed = zoo::rollmean(Cottonseed_Price, 5, fill = NA, align = "right"),
    MA_Cotton_Wholesale = zoo::rollmean(Cotton_Wholesale_Price, 5, fill = NA, align = "right")
  )

# Plot moving averages
ggplot(cleaned_data, aes(x = 1:nrow(cleaned_data))) +
  geom_line(aes(y = MA_Cottonseed, color = "Cottonseed (MA)"), size = 1) +
  geom_line(aes(y = MA_Cotton_Wholesale, color = "Cotton Wholesale (MA)"), size = 1) +
  scale_color_manual(values = c("Cottonseed (MA)" = "blue", "Cotton Wholesale (MA)" = "red")) +
  labs(title = "Moving Average Trend of Cottonseed and Wholesale Prices", 
       x = "Index (Time)", y = "Price (Moving Average)", color = "Type") +
  theme_minimal() +
  ggsave("Moving_Average_Trends.png", width = 8, height = 5)
