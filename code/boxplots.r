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

# Create Side-by-Side Boxplots
ggplot(cleaned_data) +
  geom_boxplot(aes(x = "Cottonseed", y = Cottonseed_Price, fill = "Cottonseed"), alpha = 0.6) +
  geom_boxplot(aes(x = "Cotton Wholesale", y = Cotton_Wholesale_Price, fill = "Cotton Wholesale"), alpha = 0.6) +
  scale_fill_manual(values = c("Cottonseed" = "blue", "Cotton Wholesale" = "red")) +
  labs(title = "Side-by-Side Boxplots", x = "Type", y = "Price") +
  theme_minimal() +
  ggsave("Side_by_Side_Boxplots.png", width = 8, height = 5)
