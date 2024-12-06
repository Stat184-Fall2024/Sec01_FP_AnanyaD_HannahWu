library(ggplot2)

# Load dataset
file_path <- "C:\\Users\\ekans\\Desktop\\STAT 184\\Group Project\\Merged_Cotton_Cottonseed_Prices.csv"
data <- read.csv(file_path, stringsAsFactors = FALSE)

# Ensure columns are numeric
data$Cottonseed_Price <- as.numeric(data$Cottonseed_Price)
data$Cotton_Wholesale_Price <- as.numeric(data$Cotton_Wholesale_Price)

# Filter out NA values
cleaned_data <- data %>%
  filter(!is.na(Cottonseed_Price) & !is.na(Cotton_Wholesale_Price))

# scatter plot with trend line
ggplot(cleaned_data, aes(x = Cottonseed_Price, y = Cotton_Wholesale_Price)) +
  geom_point(color = "blue", alpha = 0.6) +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Scatter Plot with Trend Line", 
       x = "Cottonseed Price", y = "Cotton Wholesale Price") +
  theme_minimal() +
  ggsave("Scatter_Plot_Trend_Line.png", width = 8, height = 5)
