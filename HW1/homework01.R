# =====================================================
# Stat133: HW 1
# Description: Basics of character vectors
# Data: Teams that played the superbowl
# =====================================================

# Please submit your own R script to bcourses

# Write your full name
# Name: Junyu Wang


# =====================================================
# Loading the Data in file "superbowl_teams.RData" 
# superbowl_teams.RData contains 3 vectors:
# 1) year:   year of superbowl from 1967 to 2015
# 2) winner: champion teams
# 3) loser:  losing teams
# =====================================================

# Start a new R session (in RStudio)
# Install the package "httr", and load it
install.packages("httr")
library(httr)

# now load the data from the github repository of the course
response <- GET(url="https://github.com/gastonstat/stat133/raw/master/datasets/superbowl_teams.RData")
load(rawConnection(response$content))
rm(response)

# inspect the objects with ls()
# (you should be able to see three vectors)
ls()

# year: year of superbowl from 1967 to 2015
# winner: champions
# loser: losing teams

# find the class of each vector (year, winner, loser)
class(year)
class(winner)
class(loser)
# use length() to determine whether the three vectors
# have the same number of elements

length(year)
length(winner)
length(loser)
# =====================================================
# Winning teams
# Write the commands to answer the following questions
# =====================================================

# get the first 5 champions
winner[1:5]

# get the last 5 champions
tail(winner, n = 5)

# how many unique champions?
length(unique(winner))

# sort unique champions alphabetically (from A to Z)
sort(unique(winner))

# decreasingly sort unique champions alphabetically (from Z to A)
sort(unique(winner), decreasing = TRUE)

# get the champions in even positions (2, 4, 6, 8, etc)
winner[c(FALSE, TRUE)]

# get the champions in odd positions (1, 3, 5, 7, etc)
winner[c(TRUE, FALSE)]

# use the function table() to get a 
# table of frequencies for the winning teams
# (assign the table to the object 'win_freqs')
win_freqs <- table(winner)

# what team has won the superbowl most times?
# and how many times?
which.max(win_freqs)
win_freqs[which.max(win_freqs)]


# apply table() on 'win_freqs', this will give you
# how many teams have won how many superbowls
table(win_freqs)


# create a vector 'champions' by sorting the frequencies
# 'win_freqs' in decreasing order
champions <- order(win_freqs, decreasing = TRUE)

# make a barplot of 'champions' with barplot()
barplot(champions)

# try this command
barplot(champions, las = 2)

# try this other command
op <- par(mar = c(2, 11, 1, 2))
barplot(champions, horiz = TRUE, las = 2)
par(op)


# What are the championships (i.e. years) of "San Francisco 49ers"
year[winner == "San Francisco 49ers"]

# What are the championships (i.e. years) of "Oakland Raiders" 
year[winner == "Oakland Raiders"]

# when was the last time Denver Broncos won a superbowl?
year[winner == "Denver Broncos"][length(year[winner == "Denver Broncos"])]

# create 'winner2', a copy of the vector 'winner'
winner2 <- winner

# replace some team names in 'winner2' as follows:
# "New York Giants" to "NYG"
# "New York Jets" to "NYJ"
# "Kansas City Chiefs" to "KCC"
winner2[winner == "New York Giants"] <- "NYG"
winner2[winner == "New York Jets"] <- "NYJ"
winner2[winner == "Kansas City Chiefs"] <- "KCC"

# =====================================================
# Losing team
# Write the commands to answer the following questions
# =====================================================

# get the losing teams of the first 5 superbowls
head(loser, n=5)


# get the losing teams of the last 5 superbowls
tail(loser, n=5)
# get the losing teams in even positions (2, 4, 6, 8, etc)
loser[c(FALSE, TRUE)]

# get the losing teams in odd positions (1, 3, 5, 7, etc)
loser[c(TRUE, FALSE)]

# create the frequency table 'los_freqs'
# of losing teams
los_freqs <- table(loser)

# What is the team that have lost the superbowl
# the most times?, and how many times?
which.max(los_freqs)
los_freqs[which.max(los_freqs)]


# =====================================================
# Winners and Losers
# Write the commands to answer the following questions
# =====================================================

# how many different teams have played the superbowl?
length(union(winner, loser))

# teams that have played the superbowl and have never lost
setdiff(winner, loser)

# teams that have played the superbowl and have never won
setdiff(loser, winner)

# teams that have played the superbowl (both won and lost)?
intersect(winner, loser)

# how many teams have both won and lost the superbowl?
length(intersect(winner, loser))


# what team won the superbowl in 2000
winner[year == 2000]

# what team lost the superbowl in 2000
loser[year == 2000]

# What are the champions of years 1970, 1980, 1990, 2000 & 2010?
winner[year %in% c(1970, 1980, 1990, 2000, 2010)]

# what teams won the superbowl in the 1970s (1970-1979)
winner[year %in% 1970:1979]

# what teams lost the superbowl in the 1990s (1990-1999)
loser[year %in% 1990:1999]

# create a data frame 'superbowl_df' with the three vectors:
# year, winner, loser
superbowl_df <- data.frame(year, winner, loser)

# create a list 'superbowl' with the three vectors:
# year, winner, loser (each vector as an element of the list)
superbowl <- list(year, winner, loser)
