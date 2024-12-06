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

# Create Side-by-Side Histograms
ggplot(cleaned_data) +
  geom_histogram(aes(x = Cottonseed_Price, fill = "Cottonseed"), 
                 bins = 20, alpha = 0.6, position = "identity") +
  geom_histogram(aes(x = Cotton_Wholesale_Price, fill = "Cotton Wholesale"), 
                 bins = 20, alpha = 0.6, position = "identity") +
  scale_fill_manual(values = c("Cottonseed" = "blue", "Cotton Wholesale" = "red")) +
  labs(title = "Side-by-Side Histograms", x = "Price", y = "Frequency") +
  theme_minimal() +
  ggsave("Side_by_Side_Histograms.png", width = 8, height = 5)
