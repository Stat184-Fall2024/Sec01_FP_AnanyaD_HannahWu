# Load necessary packages
library(dplyr)
library(readr)

# Set working directory to your desired path
setwd("C:\\Users\\ekans\\Desktop\\STAT 184\\Group Project")

# Load the datasets from the URLs
url1 <- "https://data.nber.org/databases/macrohistory/rectdata/04/m04006aa.dat"
url2 <- "https://data.nber.org/databases/macrohistory/rectdata/04/m04006a.dat"

# Read the data from the URLs
data1 <- read.table(url1, header = FALSE, stringsAsFactors = FALSE, skip = 1)
data2 <- read.table(url2, header = FALSE, stringsAsFactors = FALSE, skip = 1)

# Assign column names
colnames(data1) <- c("Year", "Month", "Cottonseed_Price")
colnames(data2) <- c("Year", "Month", "Cotton_Wholesale_Price")

# Filter data2 for 1910-1938
data2_filtered <- data2 %>%
  filter(Year >= 1910 & Year <= 1938)

# Save the files explicitly
write.csv(data1, file = "Cottonseed_Prices_1910_1938.csv", row.names = FALSE)
write.csv(data2_filtered, file = "Cotton_Wholesale_Prices_1910_1938.csv", row.names = FALSE)

# Optional: Merge datasets and save
merged_data <- inner_join(data1, data2_filtered, by = c("Year", "Month"))
write.csv(merged_data, file = "Merged_Cotton_Cottonseed_Prices.csv", row.names = FALSE)

cat("Files successfully saved in your specified directory.")
