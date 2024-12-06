# Load necessary packages
library(dplyr)  # For data manipulation
library(readr)  # For reading and writing CSV files

# Set the working directory to the desired path
# This ensures that all saved files will be stored in the specified location
setwd("C:\\Users\\ekans\\Desktop\\STAT 184\\Group Project")

# Load the datasets from the given URLs
# These URLs point to cottonseed and cotton wholesale price data from the NBER macrohistory database
url1 <- "https://data.nber.org/databases/macrohistory/rectdata/04/m04006aa.dat"
url2 <- "https://data.nber.org/databases/macrohistory/rectdata/04/m04006a.dat"

# Read the data from the URLs
# The data is read into R as data frames
# `skip = 1` skips the first row if it contains non-data content, such as a header
data1 <- read.table(url1, header = FALSE, stringsAsFactors = FALSE, skip = 1)
data2 <- read.table(url2, header = FALSE, stringsAsFactors = FALSE, skip = 1)

# Assign column names to the datasets for better readability and usability
colnames(data1) <- c("Year", "Month", "Cottonseed_Price")  # Columns: Year, Month, Cottonseed Price
colnames(data2) <- c("Year", "Month", "Cotton_Wholesale_Price")  # Columns: Year, Month, Cotton Wholesale Price

# Filter the second dataset (`data2`) to include only records from 1910 to 1938
# This step limits the dataset to the specified time range
data2_filtered <- data2 %>%
  filter(Year >= 1910 & Year <= 1938)

# Save the datasets as CSV files for future use
# `row.names = FALSE` ensures that row numbers are not included in the saved file
write.csv(data1, file = "Cottonseed_Prices_1910_1938.csv", row.names = FALSE)
write.csv(data2_filtered, file = "Cotton_Wholesale_Prices_1910_1938.csv", row.names = FALSE)

# Optional: Merge the two datasets based on the common columns "Year" and "Month"
# This creates a combined dataset for analysis where both price types exist for the same Year-Month
merged_data <- inner_join(data1, data2_filtered, by = c("Year", "Month"))

# Save the merged dataset as a CSV file
write.csv(merged_data, file = "Merged_Cotton_Cottonseed_Prices.csv", row.names = FALSE)

# Print a message to confirm successful saving of the files
cat("Files successfully saved in your specified directory.")
