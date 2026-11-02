#Assignment 3

#This assignment will create 2 different visualizations, run summary statistics
#And show documentation of changes as we update the file

#Set working directory using file.path() function for printing. We removed setwd()
#as we are working in RStudio through git

TextMSG <- read.csv("TextMessages.csv")

#_____________________________________________________________________________
#Importing libraries to be used throughout the data 

#install.packages("tidyverse")
library (tidyverse)
#install.packages("gglplot2")
library(ggplot2)
#install.packages("Hmisc")
library(Hmisc)


#______________________________________________________________________________
#Looking at the data and understanding how it is broken down in the file

is.data.frame (TextMSG)
#The response of "True" suggests that our data is a data frame

str(TextMSG)
#This indicates structure and we can see that we have 50 objects with 4 
#different variables and data types. Based on this information we have:
#confirms that our dataset is listed as a data frame, we have a total of 50 
#observations, four columns, and all the variables (baseline, group, Six_month,
#and participant) are stored as integers.In addition, we can see that our 
#dataset is in the wide format with each participant having separate columns for
#measurements taken at different times.
#In addition it shows that each participant has two measurements: baseline and 
#Six_months

#Checking if it is a factor: 
is.factor (TextMSG$Group)
#This confirms that our group variable needs to be adjusted to be a categorical
#variable. To double check what the groups look like:
table(TextMSG$Group)
#This shows us that we have 2 groups total, each with 25 observations.
#We can now convert Group into a factor:

TextMSG$Group <- factor (TextMSG$Group)
#Double checking that it now conversted:
is.factor(TextMSG$Group)

head(TextMSG)
#based on how the first 6 lines of the data look, we can also see that the 
#"Participant" variable is just the random number assigned to a participant. 
#This gives a clearer breakdown of what the data looks like.

#______________________________________________________________________________
#Visualization 1
#The first visualization is focused on looking at boxplots by group and time.
#Since our data is in the wide format, we may do better by changing this into 
#long format to help with analysing this data

#To convert the data into the long format we can do the following:
#We will use tidyverse, which was already imported above

TextMSG_long <- TextMSG %>% pivot_longer (cols = c(Baseline, Six_months),
                                          names_to = "Time",
                                          values_to = "TextMessages")

#View (TextMSG_long)
#This confirms that we now have 100 observations, which means that our data was
#transformed to the longer format with a new variable called Time containing the
#original column names (combining Baseline and Six_months into a single column)

#We also can check what the data now looks like:
head (TextMSG_long)
#Both show that the data has been transformed.

#Since the variable Time is also two measurement, we want to check if that is a
#factor as well, and we look at the levels to identify if it needs to be adjusted:
is.factor (TextMSG_long$Time)
#This confirms that it is not, so we can convert it:

TextMSG_long$Time <- factor (TextMSG_long$Time, 
                             levels = c("Baseline", "Six_months"))

is.factor(TextMSG_long$Time)
#Now we see that the variable Time has been converted into a factor.

#Double checking that all of the variables are in the correct formats:
str(TextMSG_long)
#We can see that we have two variables that are factors (group and time) and 
#two variables that are still names integers (participant and TextMessages)

#Faceted Boxplot
#using ggplot2, which was loaded earlier
#This plot also has the data points plotted in the background to make it clearer
#to show the spread.

boxplot_TextMSG_long <- ggplot(TextMSG_long, aes(x=Group, 
                                                 y = TextMessages, 
                                                 fill = Group))+
  geom_boxplot(alpha =0.4, outlier.shape = NA)+ 
  geom_jitter(width = 0.20, alpha = 0.4) +
  facet_wrap(~Time) + 
  labs (title = "Distribution of text messages by group and time",
        x = "Group",
        y = "Number of text messages" ) +
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        axis.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 12, face = "bold"), 
        legend.position = "none") +
  scale_y_continuous(breaks = seq(from =0, to =70, by=5)) 

#Since we are plotting the points, we took out the outliers so they are not
#plotted twice

#View the plot:
boxplot_TextMSG_long

#Based on the box plot, at the baseline, both groups have very similar medians and 
#also looks like they have similar spread and distribution of text messages, 
#with no visible outliers. Their median numbers of messages were approximately
# 64 for Group 1 and 65 for Group 2. In addition, and their boxes overlapped 
#considerably, indicating similar central tendencies and variability.
#However after 6 months, there is a visual differences between the two groups
#At six months, the median decreased in both groups. Group 1 decreased to 
#approximately 58 messages, whereas Group 2 decreased to approximately 62 messages.
#Group 1 also showed greater variability at six months and had several unusually 
#low observations, including values below 20 messages. 
#The outliers for group 1 appear to be more spread out and both above
#and below group data.
#In comparison, Group 2 had a somewhat higher median and a more tightly clustered 
#distribution at six months.
#Overall, the graph suggests a larger decrease and greater variability for 
#Group 1, although a statistical test is needed as these are just visual 
#observations.

#______________________________________________________________________________
#Visualization 2

#Create barplot with desired formatting, using color blind accessible colors, 
#and assign to barplot_TextMSG_long object:
barplot_TextMSG_long <- ggplot(TextMSG_long, 
                               aes(Group, TextMessages, fill = Group)) + 
  stat_summary(fun = mean, geom = "bar", colour = "Black", alpha = 0.75) + 
  stat_summary(fun.data = mean_cl_normal, geom ="errorbar", colour = "black",
               width = 0.25) +
  facet_wrap(~Time) +
  scale_fill_manual(values = c("#56B4E9", "#E69F00")) +
  labs(x="Group", y="Number of Text Messages", 
       title = "Mean Number of Text Messages by Group and Time", 
       subtitle = "with 95% Confidence Intervals") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        axis.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 12, face = "bold"), 
        legend.position = "none") +
  scale_y_continuous(breaks = seq(from =0, to =70, by=5)) 

#Display bar plot:
barplot_TextMSG_long

#The bar plots depict the mean number of text messages by group and time 
#with superimposed error bars in black. The error bars represent the 95% 
#confidence intervals about the mean. 

#The bar plots show that the mean number of text messages for the groups at 
#the baseline time are both around 65. The plots at six months show group 1
#had a noticeable drop in number of text messages with a mean around 53 while 
#the mean for group 2 dropped to about 62. The confidence intervals at six 
#months overlap partially, so the plot alone does not establish whether the 
#groups differ significantly; a formal statistical test would be needed to draw 
#that conclusion.

#______________________________________________________________________________
#Summary statistics

#Summarize text messages by group and time 
TextMSG_long %>% 
  group_by(Group, Time) %>%
  summarise(n=n(), 
            mean=mean(TextMessages),
            SD=sd(TextMessages),
            median=median(TextMessages),
            Q1=quantile(TextMessages, 0.25),
            Q3=quantile(TextMessages, 0.75),
            .groups = "drop")

#The summary statistics describe the number of text messages by group and time.

#At baseline, the two groups are very similar. Group 1 has a mean of 64.8
#(SD = 10.7) and a median of 64, and Group 2 has a mean of 65.6 (SD = 10.8)
#and a median of 65.

#At six months, both groups sent fewer text messages, but the drop was larger
#for Group 1. Group 1's mean fell to 53.0 and its median fell to 58, while 
#Group 2's mean fell to 61.8 and its median to 62.

#At six months, Group 1's mean (53.0) is noticeably lower than its median (58),
#and its standard deviation increased to 16.3, which is consistent with the low
#outliers shown in the boxplot in Visualization 1. These outliers pull the mean 
#down for Group 1 at six months. Group 1's middle 50% of values 
#(Q1 to Q3: 50 to 61) became more concentrated at six months, even as SD 
#increased. Group 2's spread decreased slightly at six months (SD = 9.41, 
#Q1 to Q3: 56 to 64).

#These means are consistent with the bar chart in Visualization 2.
#Note: the SD describes the spread of individual text message counts, while
#the error bars in Visualization 2 show 95% confidence intervals for each mean.
#______________________________________________________________________________

#Conclusions
#This assignment focused on creating 2 different visualizations using ggplot () 
#for both box plot and bar plot. Both sets of plots show similar patterns with 
#decrease in medians from the baseline to six months. 

#Based on the summary statistics and the plots, at baseline, the two groups 
#were very similar in their number of text messages, with means of 64.8 for 
#Group 1 and 65.6 for Group 2. At six months, the mean decreased in both groups, 
#but the reduction was larger in Group 1. Group 1 decreased by 11.8 messages on 
#average, from 64.8 to 53.0, whereas Group 2 decreased by 3.8 messages, from 
#65.6 to 61.8. Group 1 also showed greater variability at six months, with its 
#standard deviation increasing from 10.7 to 16.3. In contrast, Group 2 remained
#more consistent, with its standard deviation decreasing slightly from 10.8 to 
#9.41. Overall, these descriptive results suggest that Group 1 experienced a 
#larger reduction in text messages and more variation among participants than 
#Group 2. However, an inferential statistical test would be required to 
#determine whether these changes and the difference between groups are 
#statistically significant.


