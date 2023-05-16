# --------Load libraries that the project will use-------
install.packages("here")
install.packages("tidyverse")
install.packages("RColorBrewer")
install.packages("readr")
tinytex::install_tinytex()

library(here)
library(tidyverse)
library(RColorBrewer)
library(readr)
library(ggplot2)
# ------------IMPORT DATA------------

# use library(here) to import the data.
# Importing the data from Github and setting it as a data frame
df <- read.csv("https://raw.githubusercontent.com/hannahcsx/PSY6422_Project/main/project_data.csv")
head(df)
# Converting the data we have, currently gender is represented as 1 for male and 2 for female so we need to change this so we'll use a new variable 
# Find the average of the data we're using so we'll need another variable for later
df$Gender_converted <- ifelse(df$Gender ==1, "male", "female")
avg_bs <- mean(df$BS)
avg_bi <- mean(df$BI)

# Using ggplot to create a Scatter Plot with BS vs BI 
p0 <- ggplot(df,aes(x=BS,y=BI,group=Gender_converted))+
        ggtitle("Scatter plot of BS vs BI with line of best fit for male and female")+
        geom_point(aes(color=Gender_converted))+
        scale_color_manual(values=c('Red','Blue'))+
        geom_smooth(method = "lm", se = FALSE)

#Save image
ggsave("BS_BIScatterPlot.png", plot =p0, width=6, height=4, dpi=300)

# Using ggplot to create a Histogram with male and female BS scores with a mean line

p1 <- ggplot(df, aes(x = BS, fill = Gender_converted)) +
        geom_histogram(binwidth = 1, color="grey") +
        geom_vline(xintercept = avg_bs, color="black", linetype="dashed")+
        ggtitle("Histogram of BS, by Gender") +
        xlab("Value of BS") +
        ylab("Count") 
 
#Save image
ggsave("BSHistogramWithMeanLine.png", plot =p1, width=6, height=4, dpi=300)

# Same as above but using BI instead  
  
p2 <- ggplot(df, aes(x = BI, fill = Gender_converted)) +
        geom_histogram(binwidth = 1, color="grey") +
        geom_vline(xintercept = avg_bi, color="black", linetype="dashed")+
        ggtitle("Histogram of BI, by Gender") +
        xlab("Value of BI") +
        ylab("Count")

#Save image
ggsave("BIHistogramWithMeanLine.png", plot =p2, width=6, height=4, dpi=300)

  

  
