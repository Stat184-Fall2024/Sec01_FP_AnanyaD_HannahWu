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

# Create Density Plot
ggplot() +
  geom_density(data = cleaned_data, aes(x = Cottonseed_Price, fill = "Cottonseed"), alpha = 0.5) +
  geom_density(data = cleaned_data, aes(x = Cotton_Wholesale_Price, fill = "Cotton Wholesale"), alpha = 0.5) +
  scale_fill_manual(values = c("Cottonseed" = "blue", "Cotton Wholesale" = "red")) +
  labs(title = "Density Plot of Cottonseed and Wholesale Prices", x = "Price", y = "Density") +
  theme_minimal() +
  ggsave("Density_Plots.png", width = 8, height = 5)
