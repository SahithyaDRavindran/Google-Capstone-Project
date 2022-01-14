# Google-Capstone-Project
As part of Google Data Analytics Professional Certificate, a case study was analysed and inferences were made with summaries and visualizations.
**Case Study: How Does a Bike-Share Navigate Speedy Success?**

This exploratory analysis case study is done for Capstone project requirement for the Google Data Analytics Professional Certificate. The case study involves a bikeshare company's data of its customer's trip details over a 12 month period (January 2021 - December 2021). The data has been made available by Motivate International Inc.

The analysis will follow the 6 phases of the Data Analysis process: Ask, Prepare, Process, Analyze, Share and Act.

**Objective**:
Marketing team needs to design strategies at converting casual riders into annual members. In order to proceed with it, the marketing analyst team needs a better understanding on how annual members and casual members differ. So the objective is to analyse the behaviour of two types of customers: annual and casual members using the cyclistic bikeshare data effectively.

**Stakeholders:**
Director of marketing
Cyclistic executive team

**Deliverables:**

Insights on how annual and casual riders use Cyclistic bikes differently
Provide appealing and effective viz and relevant data to support insights
Use the insights obtained to give three recommendations to convert casual to annual members.

All the pre processing such as checking for duplicates, data types of columns, for null values was done. Since combined data set counted to nearly 1gb, data pre processing and preparation of data were done in R. Some prechecks were made with single datasets in excel also. 

Statistical analysis were made on the refined data and visualisations were also created for better understanding.

![image](https://user-images.githubusercontent.com/17703491/149427441-00c6c275-b4b8-4e8c-a092-e74f3327d5f6.png)


![Rplot](https://user-images.githubusercontent.com/17703491/149427148-665b13d4-51c4-44ab-90cc-f1c4d6bce3f5.png)

From the table screenshot and graph above, casual customers are most busy on Sundays followed by Saturdays, while annual members are most busy on later half of the week extending into the weekend. Interesting pattern to note is that casual members take up rides mostly on weekends and there's no much raise in week days. But annual members trend seems to be the same.

![Rplot01](https://user-images.githubusercontent.com/17703491/149427792-363fbb5d-336c-41c5-a68d-ae31f1610525.png)

The data shows that the months June, July, August and September are the most busy time of the year among both members and casual riders. This could be attributed to an external factor (eg. cold weather, major quality issue) that might have hindered with customer needs. However,the number of trips made by members is always higher than the casual riders across all months of the year.

![Rplot02](https://user-images.githubusercontent.com/17703491/149428044-ccf9ba42-960a-41aa-9e9b-5619bab2e8e7.png)

The average trip duration of a casual rider is more than twice that of a member. Note that this necessarily does not mean that casual riders travel farther distance. It is also interesting to note that weekends not only contribute to more number of trips but also longer trips on average when compared to weekdays.

![Rplot03](https://user-images.githubusercontent.com/17703491/149428139-4fdf57ec-69e3-44d3-b08b-1ac5dbcf9856.png)

Average trip duration of annual members is between 10-20 minutes throughout the year. However, there seems to be a distinct pattern when it comes to casual riders, whose average trip duration swings from as low as ~25 minutes to nearly an hour depending on time of the year. It is worth noting unusually long trip durations by casual riders are in the month of February.

![Rplot04](https://user-images.githubusercontent.com/17703491/149428390-f3f2bb69-9098-470f-8eeb-7bbc467c317d.png)

Classic bikes are most liked and predominantly used by both members. Docked bikes are only used by casual members. Electric bikes are used by both members equally.

**Inferences**
Casual riders made 41% of total trips contributing to 66% of total trip duration between Apr'20 - Mar'21. Member riders make up 59% of total trips contributing to 34% of total trip duration between Jan'21 - Dec'21

Usage (based on trip duration) of bikes by casual riders is almost twice that of member riders.

Casual customers use bikeshare services more during weekends, while annual members use them consistently over the entire week.

Average trip duration of casual riders is more than twice that of member rider over any given day of the week cumulatively.

Classic and electric bikes are used predominently.
