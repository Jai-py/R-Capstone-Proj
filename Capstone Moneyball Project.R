#setting batting data frame
batting <- read.csv('Batting.csv')

head(batting)
str(batting)

head(batting$AB)
head(batting$X2B)

#Setting new columns
batting$BA <- batting$H / batting$AB
batting$OBP <- (batting$H + batting$BB + batting$HBP) / (batting$AB + batting$BB + batting$HBP + batting$SF)
batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR
batting$SLG <-((1* batting$X1B) + (2 * batting$X2B) + (3 * batting$X3B) + (4 * batting$HR)) / batting$AB

tail(batting$BA,5)
str(batting)
#Setting the salary data to sal
sal <- read.csv('Salaries.csv')
summary(batting)

#merging the salary and batting data together by playerID and yearID
combo <- merge(batting,sal, by=c('playerID','yearID'))
summary(combo)

#Subsetting the lost players in 2001
lost_players <- subset(combo, playerID %in% c('giambja01','damonjo01','saenzol01'))
lost_players = subset(lost_players,yearID == 2001)

library(dplyr)
#Selecting specific columns 
lost_players<-select(lost_players,'playerID','H','X2B','X3B','HR','OBP','SLG','BA','AB')
combo<-subset(combo,yearID == 2001)

#Removing null values
na.omit(combo)

library(ggplot2)

#plotting the OBP against salary
ggplot(combo,aes(x=OBP,y=salary)) + geom_point()

#filtering salary and OBP as well as AB
combo <- subset(combo, salary < 8000000 & OBP>0)
combo<-filter(combo,AB>500)

#Finding my best three(3) players
possible <- head(arrange(combo,desc(OBP)),10)
possible <- possible[,c('playerID','OBP','AB','salary')]
possible[2:4,]