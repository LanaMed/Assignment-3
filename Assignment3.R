#Assignment 3

#Initial set up of the GitHub for the assignment


#This assignment will create 4 different visualizations, run summary statistics
#And show documentation of changes as we update the file

#Set working directory using file.path() function for printing 
setwd(file.path("~/Desktop", "Brown", 
                "1 BHDS2010 Statistical Programming for Health Data Science", 
                "Assignment 3", "Assignment-3"))

TextMSG <- read.csv("TextMessages.csv")

#_____________________________________________________________________________
#Importing libraries to be used throughout the data 
install.packages("tidyverse")
library (tidyverse)
#install.packages("gglplot2")
library(ggplot2)
install.packages("Hmisc")
library(Hmisc)


#______________________________________________________________________________
#Looking at the data and understanding how it is broken down in the file

names(TextMSG)
#This produces 4 variable names that are present in the file

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

#The data is showing that our group variable is likely an integer, even though it
#should likely be a chategory. Double checking:
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
str (TextMSG_long)
head (TextMSG_long)
#Both show that the data has been transformed.

#Since the variable Time is also two measurement, we want to check if that is a
#factor as well, and we look at the levels to identify if it needs to be adjusted:
levels (TextMSG_long$Time)
#Since we see NULL as the response, Time variable is not likely a factor. 
class(TextMSG_long$Time)
#This notes that it is stored as a "character"
is.factor (TextMSG_long$Time)
#This confirms that it is not, so we can convert it:

TextMSG_long$Time <- factor (TextMSG_long$Time, 
                             levels = c("Baseline", "Six_months"))

is.factor(TextMSG_long$Time)
levels (TextMSG_long$Time)
#Now we see that the variable Time has been converted into a factor and has 
#two levels.

#Double checking that all of the variables are in the correct formats:
str(TextMSG_long)
#We can see that we have two variables that are factors (group and time) and 
#two variables that are still names integers (participant and TextMessages)

#Faceted Boxplot
#using ggplot2, which was loaded earlier
#This plot also has the data points plotted in the background to make it clearer
#to show the spread.

ggplot(TextMSG_long, aes(x=Group, y = TextMessages, fill = Group))+
       geom_boxplot(alpha =0.4)+ 
  geom_jitter(width = 0.20, alpha = 0.4) +
  facet_wrap(~Time) + 
  labs (title = "Distribution of text messages by group and time",
        x = "Group",
        y = "Number of text messages" ) +
  theme_minimal() 
       
#Based on the box plot, at the baseline, both groups have very similar medians and 
#also looks like they have similar spread, with no visible outliers. 
#However after 6 months, there is a visual difference, where the medians for both 
#groups appear to have changed, with  Group 1 showing lower median and much more 
#outliers. Group 1 also appears to show a skew towareds lower number of text 
#messages. The outliers for group 1 appear to be more spread out and both above
#and below group data. Group 2's median visually appears slightly lower then 
#the baseline, but it is not clear if it is lower statistically just by looking
#at the boxplot. the data for Group 2 also appears slightly more condenced and
#does not appear to show as much outliers as are seen in Group 1 after six months, 
# and most of the outliers seem to be in above the data, suggesting higher number 
#of messages. Group 2 is still showing some skew in the data. 


#______________________________________________________________________________
#Visualization 2


#Create bar plot for global use and assign to object barplot_TextMSG_long
barplot_TextMSG_long <- ggplot(TextMSG_long, 
                               aes(Group, TextMessages, fill = Group))

#Create barplot with desired formatting, using color blind accessible colors:
barplot_TextMSG_long + stat_summary(fun = mean, geom = "bar", 
                                    colour = "Black", alpha = 0.75) + 
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
#______________________________________________________________________________
#Conclusions
