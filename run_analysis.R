# Download and unzip the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "UCI_HAR_Dataset.zip")
unzip("UCI_HAR_Dataset.zip")

# Load necessary library
library(dplyr)

# Step 1: Read the training and test datasets
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Step 2: Merge the training and test sets
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# Step 3: Extract mean and standard deviation features
features <- read.table("UCI HAR Dataset/features.txt")
mean_std_features <- grep("mean\\(\\)|std\\(\\)", features$V2)
x_data <- x_data[, mean_std_features]

# Step 4: Apply descriptive activity names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
y_data$V1 <- factor(y_data$V1, levels = activity_labels$V1, labels = activity_labels$V2)

# Step 5: Label the data set with descriptive variable names
colnames(x_data) <- features$V2[mean_std_features]

# Step 6: Create a tidy data set with averages for each subject and activity
tidy_data <- cbind(subject_data, y_data, x_data)
colnames(tidy_data)[1:2] <- c("Subject", "Activity")

# Create the tidy data set with the average of each variable for each activity and each subject
tidy_avg_data <- tidy_data %>%
  group_by(Subject, Activity) %>%
  summarise(across(everything(), list(mean = mean), .names = "mean_{col}"))

# Step 7: Save the tidy data set
write.table(tidy_avg_data, "tidy_data.txt", row.name = FALSE)

# Optional: Print a message confirming the process is complete
print("Tidy data set has been created and saved as tidy_data.txt.")
