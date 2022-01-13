#intsalling the required packages
#tidyverse - for data cleaning and wrangling
#ggplot - for visualization
#lubridate - for date manipulations
install.packages("tidyverse")
library("tidyverse")
library("readr")
library("lubridate")
library("ggplot2")

getwd() # to get current working directory
#setting the current working directory
setwd("/Users/Admin/OneDrive/Google_Data_Analytics_Capstone/case study files") 

#loading datasets
tripdata_202101 = read_csv("202101-divvy-tripdata.csv")
tripdata_202102 = read_csv("202102-divvy-tripdata.csv")
tripdata_202103 = read_csv("202103-divvy-tripdata.csv")
tripdata_202104 = read_csv("202104-divvy-tripdata.csv")
tripdata_202105 = read_csv("202105-divvy-tripdata.csv")
tripdata_202106 = read_csv("202106-divvy-tripdata.csv")
tripdata_202107 = read_csv("202107-divvy-tripdata.csv")
tripdata_202108 = read_csv("202108-divvy-tripdata.csv")
tripdata_202109 = read_csv("202109-divvy-tripdata.csv")
tripdata_202110 = read_csv("202110-divvy-tripdata.csv")
tripdata_202111 = read_csv("202111-divvy-tripdata.csv")
tripdata_202112 = read_csv("202112-divvy-tripdata.csv")

#checking column names for consistency to join the tables.
colnames(tripdata_202101)
colnames(tripdata_202102)
colnames(tripdata_202103)
colnames(tripdata_202104)
colnames(tripdata_202105)
colnames(tripdata_202106)
colnames(tripdata_202107)
colnames(tripdata_202108)
colnames(tripdata_202109)
colnames(tripdata_202110)
colnames(tripdata_202111)
colnames(tripdata_202112)

#checking the data frames for any discrepancies
str(tripdata_202101)
str(tripdata_202102)
str(tripdata_202103)
str(tripdata_202104)
str(tripdata_202105)
str(tripdata_202106)
str(tripdata_202107)
str(tripdata_202108)
str(tripdata_202109)
str(tripdata_202110)
str(tripdata_202111)
str(tripdata_202112)

# Processing
#combining the individual data frames into one single frame
all_trips_data = bind_rows(tripdata_202101,tripdata_202102,tripdata_202103,tripdata_202104,tripdata_202105,
                           tripdata_202106,tripdata_202107,tripdata_202108,tripdata_202109,tripdata_202110,
                           tripdata_202111,tripdata_202112)

#removing the columns related to latitude and longitude since it won't be much required
all_trips_data <- all_trips_data %>% 
  select(-c(start_lat,start_lng, end_lat, end_lng))

glimpse(all_trips_data)
dim(all_trips_data) #to know the number of rows and columns
summary(all_trips_data) #to check statistical summary of data

#adding new column - day of the week to know when trip started
all_trips_data$day_of_the_week = format(as.Date(all_trips_data$started_at),'%a')

#adding column - month when trip started
all_trips_data$month = format(as.Date(all_trips_data$started_at),'%b')

#adding column trip duration - difference between starttime and end time
#extracting hours and minutes from started time.
all_trips_data$time = format(all_trips_data$started_at,format="%H:%M")
all_trips_data$time = as.POSIXct(all_trips_data$time,format ="%H:%M")
all_trips_data$trip_duration = (as.double(difftime(all_trips_data$ended_at, all_trips_data$started_at)))/60

glimpse(all_trips_data)

#few problems to be checked and fixed
#checking the values in member casual column
table(all_trips_data$member_casual)

#checking if any negative values are there in trip duration
nrow(subset(all_trips_data, trip_duration<0))

#removing the negative trip duration values
all_trips_data <- all_trips_data[!(all_trips_data$trip_duration<0),]

# Descriptive analysis
#summary of trip duration for all trips
summary(all_trips_data$trip_duration)

#comparing members and casual users
all_trips_data %>% 
  group_by(member_casual) %>% 
  summarise(max_trip_duration = max(trip_duration), min_trip_duration = min(trip_duration),
            mean_trip_duration = mean(trip_duration), median_trip_duration = median(trip_duration))

# See the average ride time by each day for members vs casual users
aggregate(all_trips_data$trip_duration~ all_trips_data$member_casual + 
            all_trips_data$day_of_the_week, FUN = mean)

#days of the week are not in order. 
all_trips_data$day_of_the_week = ordered(all_trips_data$day_of_the_week, 
                                               levels = c("Sun","Mon","Tue","Wed",
                                                          "Thu","Fri","Sat"))

#Now let's see statistical analysis of total number of trips by customer type and days
all_trips_data %>% 
  group_by(member_casual, day_of_the_week) %>% 
  summarise(number_of_rides = n(), average_duration = mean(trip_duration)) %>% 
  arrange(member_casual, desc(number_of_rides))

# Visualization
# Let's visualize the number of rides by rider type
all_trips_data %>% 
  group_by(member_casual, day_of_the_week) %>% 
  summarise(number_of_rides = n()) %>% 
  arrange(member_casual, day_of_the_week)  %>% 
  ggplot(aes(x = day_of_the_week, y = number_of_rides, fill = member_casual)) +
  labs(title = 'Total Number of rides vs day of the week by customer types')+
  geom_col(position = "dodge")+
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

# Let's create a visualization for average duration
all_trips_data %>% 
  group_by(member_casual, day_of_the_week) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(trip_duration)) %>% 
  arrange(member_casual, day_of_the_week)  %>% 
  ggplot(aes(x = day_of_the_week, y = average_duration, fill = member_casual)) +
  labs(title ='Average duration of customers by the days of the week')+
  geom_col(position = "dodge")

#total rides per month vs member type
#arranging the months in order
all_trips_data$month = ordered(all_trips_data$month, 
                                         levels = c("Jan","Feb","Mar","Apr",
                                                    "May","Jun","Jul","Aug","Sep","Oct",
                                                    "Nov","Dec"))

all_trips_data%>%
  group_by(month,member_casual) %>%
  summarise(number_of_rides=n())%>%
  ggplot(aes(x=month,y= number_of_rides, fill=member_casual)) +
  labs(title="Total rides per month") +
  geom_col(position = "dodge")+
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

#Average trip duration by customer type in months.
all_trips_data %>%  
  group_by(member_casual, month) %>% 
  summarise(average_trip_duration = mean(trip_duration)) %>%
  ggplot(aes(x = month, y = average_trip_duration, fill = member_casual)) +
  geom_col(width=0.5, position = position_dodge(width=0.5)) + 
  labs(title ="Average trip duration by customer type Vs. Month")

#riders preference of bikes
all_trips_data %>%  
  group_by(rideable_type, member_casual) %>% 
  summarise(number_of_rides = n()) %>%
  ggplot(aes(x = rideable_type, y = number_of_rides , fill = member_casual)) +
  geom_col(position = "dodge") + 
  labs(title ="Total Rides Vs Rideable type")


# Export the summary file for further analysis
data_for_viz <- aggregate(all_trips_data$trip_duration ~ all_trips_data$member_casual + all_trips_data$day_of_the_week+ 
                          all_trips_data$month+all_trips_data$rideable_type+all_trips_data$ride_id, FUN = mean)
write_csv(data_for_viz, file = "data_fo_viz.csv")


  

