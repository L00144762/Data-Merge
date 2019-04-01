



# Enter data into vectors before constructing the data frame
date_col <- c("2018-15-10", "2018-01-11", "2018-21-10", "2018-28-10", "2018-01-05")
country_col <- c("US", "US", "IRL", "IRL", "IRL")
gender_col <- c("M", "F", "F", "M", "F")
age_col <- c(32, 45, 25, 39, 99) # 99 is one of the values in the age attribute - will require recoding
q1_col <- c(5, 3, 3, 3, 2)
q2_col <- c(4, 5, 5, 3, 2)
q3_col <- c(5, 2, 5, 4, 1)
q4_col <- c(5, 5, 5, NA, 2) # NA is inserted in place of the missing data for this attribute
q5_col <- c(5, 5, 2, NA, 1)

# Create column names for data frame
column_names <- c("Date", "Country", "Gender", "Age", "Q1", "Q2", "Q3", "Q4", "Q5")

# Construct a data frame using the data from all vectors above
managers <- data.frame(date_col, country_col, gender_col, age_col, q1_col, q2_col, q3_col, q4_col, q5_col)

# Add column names to data frame using column_names vector
colnames(managers) <- column_names

# Refer to blackboard notes for an understanding
# why the following steps are required

# Recode the incorrect 'age' data to NA
managers$Age[managers$Age == 99] <- NA

# Create a new attribute called AgeCat and set valuess
# in AgeCat to the following if true:
# <= 25 = Young
# >= 26 & <= 44 = Middle Aged
# >= 45 = Elderly
# We will also recode age 'NA' to Elderly

managers$AgeCat[managers$Age >= 45] <- "Elderly"
managers$AgeCat[managers$Age >= 26 & managers$Age <= 44] <- "Middle Aged"
managers$AgeCat[managers$Age <= 25] <- "Young"
managers$AgeCat[is.na(managers$Age)] <- "Elderly"

# Recode AgeCat so that is ordinal and factored with the
# order Young, Middle aged, Elder
# We'll srore the ordinal factored data in variable 'AgeCat'
AgeCat <- factor(managers$AgeCat, order = TRUE, levels = c("Young", "Middle Aged", "Elderly"))

# Replace managers's AgeCat attribute with newly ordinal foctored data
managers$AgeCat <- AgeCat

# Create a new column called 'summary_col' that
# contains a summary of each row
summary_col <- managers$Q1 + managers$Q2 + managers$Q3 + managers$Q4 + managers$Q5
summary_col

# Add summary_col to the end of the data frame
managers <- data.frame(managers, summary_col)


# Calculate mean value for each row
mean_value <- rowMeans(managers[5:9])

# Add mean_value to end of managers data frame
managers <- data.frame(managers, mean_value)

# Show data frame contents
managers

# Change the name of this column to "mean value"
names(managers)[12] <- "mean value"

# Change name of summary_col to "Answer total"
names(managers)[11] <- "Answer total"

#Show 
str(managers)

new_managers_data <- read.csv("MoreData.csv")
new_managers_data
head(new_managers_data)

search()

#rbind(managers, new_managers_data)
#attach(new_managers_data)
#converted_date <- as.Date(Date, format= "%m/d/%Y")
#str(new_managers_data)
#converted_date <- format(converted_date, "%d/%m/%Y")

#converted_date
managers$Date
converted_date <- as.Date(managers$Date, "%Y-%d-%m")
managers$Date = converted_date
managers$Date

str(managers)
str(new_managers_data)
new_managers_data$Date
converted_date_new_managers <- as.Date(
  new_managers_data$Date, "%Y-%d-%m")
new_managers_data$Date = converted_date_new_managers
new_managers_data$Date

# Select records within 15-10-18 and 01-11-18
startdate <- as.Date("2018-10-15")
enddate <- as.Date("2018-11-01")
new_data <- managers[managers$Date >= startdate & managers$Date <= enddate,]
new_data
str(managers)

# Dropping attributes from data
# This command shows all attributes where Q3 or Q4 are contained
# The ! operator reverses this choice
include_list <- names(managers) %in% c("Q3", "Q4")
include_list


# This list can then be used to extract this data
new_data <- managers[(include_list)]
# or
new_data <- managers[names(managers) %in% c("Q3", "Q4")]
# Show contents
new_data

# Here's an alternative method (count starts at 0)
# This keeps everything apart from the 2 values
new_data <- managers[c(-6, -7, -8, -9)]
new_data

# Using the subset function
# to extract all records from managers where age > 35 or age < 24. 
# Only select the listed attributes
attach(managers)
new_data <- subset(managers, Age >= 35 | Age < 24, select = c(Q1, Q2, Q3, Q4))
new_data

# Select a subset of managers
# where gender = M and age > 25. Only show records 
# from Gender to Q4 includive
new_data <- subset(managers, Gender == "M" & Age > 25, select = Gender:Q4)
new_data

# Try this out ....
new_managers <- subset(managers, Gender == "M" & Age > 25)
new_managers
detach(managers)


# Random sampling --------------------------------------------------------
# Selecting a random sample from managers
my_sample <- managers[sample(1:nrow(managers), 3, replace = FALSE),]
my_sample

# Extracting 10 random samples from managers
# Adds number to represent no of iterations taken from that record
my_sample <- managers[sample(1:nrow(managers), 10, replace = TRUE),]
my_sample

# Sorting data ------------------------------------------------------------
#Sorting data by age
attach(managers)
new_data <- managers[order(Age),]
new_data

# Sort by Gender and then age within each gender
str(Age)
str(Gender)
new_data <- managers[order(Gender, Age),]
new_data

