batting <- read.csv('Batting.csv')
head(batting)
str(batting)
head(batting$AB)
head(batting$X2B)
batting$BA <- batting$H / batting$AB
batting$OBP <- (batting$H + batting$BB + batting$HBP) / (batting$AB + batting$BB + batting$HBP + batting$SF)
batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR
batting$SLG <-((1* batting$X1B) + (2 * batting$X2B) + (3 * batting$X3B) + (4 * batting$HR)) / batting$AB
tail(batting$BA,5)
str(batting)
sal <- read.csv('Salaries.csv')
summary(batting)
combo <- merge(batting,sal, by=c('playerID','yearID'))
summary(combo)
lost_players <- subset(combo, playerID %in% c('giambja01','damonjo01','saenzol01'))