library("stringr")

# downlaod file
download.file("http://nflsavant.com/dump/weather_20131231.csv", "~/personal/school/stats133/stat133/HW5/raw_nflweather.csv")

# read data
raw_weather_data = read.csv("~/personal/school/stats133/stat133/HW5/raw_nflweather.csv")

head(raw_weather_data)

# Weather Information
#
# converts humidity to numeric formats
raw_weather_data$humidity = str_replace_all(raw_weather_data$humidity, "%", "")
raw_weather_data$humidity = as.numeric(raw_weather_data$humidity)

# create numeric temperature2 column
raw_weather_data$temperature2 = as.numeric(raw_weather_data$temperature)

# humidity from weather -> humidity2
humidity_data = str_extract_all(raw_weather_data$weather, "[0-9]{0,3}%")
humidity_data_numeric = as.numeric(str_replace_all(humidity_data, "%", ""))
raw_weather_data$humidity2 = humidity_data_numeric

# wind speed value from weather -> wind2
wind_data = str_extract_all(raw_weather_data$weather, "[0-9]+ mph")
wind_data_numeric = as.numeric(str_replace_all(wind_data, " mph", ""))
raw_weather_data$wind2 = wind_data_numeric

# check value correctness by summary
summary(raw_weather_data$temperature)
summary(raw_weather_data$temperature2)

summary(raw_weather_data$wind_mph)
summary(raw_weather_data$wind2)

summary(raw_weather_data$humidity)
summary(raw_weather_data$humidity2)


# Date Information 
#
# date -> year
date_data = str_split(raw_weather_data$date, "/")
year_data_numeric = as.numeric(sapply(date_data, function(x) x[3]))
raw_weather_data$year = year_data_numeric

monthnum_data_numeric = as.numeric(sapply(date_data, function(x) x[1]))
raw_weather_data$monthnum = monthnum_data_numeric

month_data = sapply(monthnum_data_numeric, function(x) {
  switch(as.character(x), 
         "1" = "January",
         "2" = "Feburary",
         "3" = "March", 
         "4" = "April", 
         "5" = "May",
         "6" = "June",
         "7" = "July",
         "8" = "August",
         "9" = "September",
         "10" = "October",
         "11" = "November",
         "12" = "December")
})
raw_weather_data$month = as.factor(month_data)

decade_data = sapply(year_data_numeric, function(x) {
  paste0(as.character(x - x %% 10), "s")
})
raw_weather_data$decade = as.factor(decade_data)

# Scores Information
#
# total scores
total_score_data = raw_weather_data$home_score + raw_weather_data$away_score
raw_weather_data$total_score = total_score_data

# diff scores
diff_score_data = raw_weather_data$home_score - raw_weather_data$away_score
raw_weather_data$diff_score  = diff_score_data

# home win
win_data = raw_weather_data$home_score > raw_weather_data$away_score
raw_weather_data$home_win = win_data

# Basic exploration
#
#
home_score_summary = summary(raw_weather_data$home_score)
away_score_summary = summary(raw_weather_data$away_score)
temp_summary = summary(raw_weather_data$temperature)
wind_summary = summary(raw_weather_data$wind_mph)

#plot(raw_weather_data$home_score)
#plot(raw_weather_data$away_score)
#plot(raw_weather_data$temperature)
#plot(raw_weather_data$wind_mph)

# team with maximum home score
team_with_max_home_score = raw_weather_data[which.max(raw_weather_data$home_score),]$home_team

# team with maximum away score
team_with_max_away_score = raw_weather_data[which.max(raw_weather_data$away_score),]$away_team

# most common home score
home_score_freq = table(raw_weather_data$home_score)
m_common_home_score = subset(home_score_freq, home_score_freq == max(home_score_freq))

# most common away score
away_score_freq = table(raw_weather_data$away_score)
m_common_away_score = subset(away_score_freq, away_score_freq == max(away_score_freq))

# maximum temperature
max_temp = max(raw_weather_data$temperature)

# date of max temperature
date_max_temp = raw_weather_data[which.max(raw_weather_data$temperature),]$date

# minimum temperature
min_temp = min(raw_weather_data$temperature)

# date of minimum temperature
date_min_temp = raw_weather_data[which.min(raw_weather_data$temperature),]$date

# games played with temp > 90
games_with_high_temp = sum(raw_weather_data$temperature >= 90)

# games played with temp < 0
games_with_low_temp = sum(raw_weather_data$temperature < 0)

# most common temp
temp_freq = table(raw_weather_data$temperature)
m_common_temp = subset(temp_freq, temp_freq == max(temp_freq))

# barchart of freq table of temp
# barchart_temp = barplot(temp_freq)

# cleaned data file
selected_column = c("id", "home_team", "home_score", "away_team", "away_score", "total_score", "diff_score", "home_win", "date", "year", "month", "decade", "temperature", "humidity", "wind_mph")
cleaned_data = raw_weather_data[, selected_column]
write.csv(cleaned_data, "~/personal/school/stats133/stat133/HW5/cleandata/nflweather.csv")

# each decade data files
for (i in unique(cleaned_data$decade)) {
  write.csv(subset(cleaned_data, cleaned_data$decade == i), paste0("~/personal/school/stats133/stat133/HW5/cleandata/nflweather", i, ".csv"))
}



  