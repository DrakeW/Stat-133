library("ggplot2")

# data to analyze
data = read.csv("~/personal/school/stats133/stat133/HW5/cleandata/nflweather.csv")


years = unique(data$year)
diffs = NULL

# home win loss differences per year

for (i in years) {
  win_lose_data = subset(data, data$year == i)
  wins = subset(win_lose_data, win_lose_data$home_win == TRUE)
  diff = nrow(wins) - (nrow(win_lose_data) - nrow(wins))
  diffs = c(diffs, diff)
}

result = data.frame(years = years, diffs = diffs)

# ggplot(data = result, aes(years, diffs)) +
#   geom_bar(color = "#000000", fill = "#515252", stat = "identity") +
#   ggtitle("Difference between home wins and home loses by year") +
#   ylab("Difference") +
#   scale_x_continuous(name = "Year",
#                      breaks = years) +
#   theme(axis.text.x = element_text(angle= 90))

# average score points per year

avg_homescore = NULL
avg_awayscore = NULL

for (i in years) {
  scores_data = subset(data, data$year == i)
  avg_home = sum(scores_data$home_score)/nrow(scores_data)
  avg_away = sum(scores_data$away_score)/nrow(scores_data)
  avg_homescore = c(avg_homescore, avg_home)
  avg_awayscore = c(avg_awayscore, avg_away)
}

avgs = data.frame(years = years, avg_homescore = avg_homescore, avg_awayscore = avg_awayscore)

# ggplot(data = avgs) + 
#   geom_line(aes(x = years, y = avg_homescore), color = "#DB5FE4", size = 1.5) +
#   geom_line(aes(x = years, y = avg_awayscore), color = "#5FE4DB", size = 1.5) +
#   geom_point(aes(x = years, y = avg_homescore), color = "#DB5FE4", size = 3.0) + 
#   geom_point(aes(x = years, y = avg_awayscore), color = "#5FE4DB", size = 3.0) + 
#   ggtitle("Average score points per year") + 
#   ylab("scores")

# has the total number of scored points changed overtime

avg_total_score = NULL

for (i in years) {
  scores_data = subset(data, data$year == i)
  avg_total = sum(scores_data$total_score)/nrow(scores_data)
  avg_total_score = c(avg_total_score, avg_total)
}

avg_scores = data.frame(years = years, avg_totalscore = avg_total_score)

# ggplot(data = avg_scores) +
#   geom_line(aes(x = years, y = avg_totalscore), color = "#000000", size = 1.5) +
#   geom_point(aes(x = years, y = avg_totalscore), color = "#000000", size = 3.0) +
#   ggtitle("Average total scored points per year")
