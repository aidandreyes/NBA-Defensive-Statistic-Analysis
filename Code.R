# **NBA Defensive Statistic Analysis (2024-25 Season)**

### **AIDAN REYES**
# ---
# This project uses preexisting data from the 2024-2025 NBA season via the NBA.com website.

# Per game data can be viewed [here](https://www.nba.com/stats/players/defense?SeasonType=Regular+Season); season total data can be viewed [here](https://www.nba.com/stats/players/defense?SeasonType=Regular+Season&PerMode=Totals).
# Defensive field goals allowed stats were taken from [this page](https://www.nba.com/stats/players/defense-dash-overall?PerMode=Totals&SeasonType=Regular+Season&Season=2024-25).

# Make sure to download and add the Excel file from [here](https://github.com/aidandreyes/NBA-Defensive-Analysis/blob/main/nba_defense.xlsx) into the local file directory before starting.

# Install packages
  install.packages("dslabs")
  install.packages("readxl")   
  install.packages("writexl") 
  install.packages("dplyr")
  install.packages("ggplot2")

# Load libraries
  library(jsonlite)
  library(rvest)
  library(ggplot2)
  library(readxl)
  library(dplyr)

# I previously exported data from the website manually to create my own Excel sheet
# Export excel sheet
  defense_excel <- read_excel("nba_defense.xlsx")

# Create csv file
  write.csv(x = defense_excel, file = "nba_defense.csv", row.names = TRUE)

# Create data frame from the csv file
  defensive_df <- as.data.frame(read.csv("nba_defense.csv"))
# Remove original player ID column
  defensive_df <- defensive_df[, -which(names(defensive_df) == "X")]
# Omit any players with missing / invalid values
  na.omit(defensive_df)

# Clean data frame to only include players that played at least 500 minutes
  defensive_df <- defensive_df[defensive_df$MIN_TOTAL >= 500, ]

# Convert categorical variables PLAYER, TEAM, POSITION into factors
  defensive_df$PLAYER <- as.factor (defensive_df$PLAYER)
  defensive_df$POSITION <- as.factor(defensive_df$POSITION)
  defensive_df$TEAM <- as.factor (defensive_df$TEAM)

# Fix position levels since C-F is same as F-C and F-G is same as G-F
  levels(defensive_df$POSITION)[levels(defensive_df$POSITION)=="C-F"] <- "F-C"
  levels(defensive_df$POSITION)[levels(defensive_df$POSITION)=="F-G"] <- "G-F"

# Use the original dataframe and plot the data onto a boxplot to visualize the best and worst teams by defensive rating and defensive win shares. This will allow for visual access to outlying players and what the league average is.

# Boxplot: Defensive Rating by Team
ggplot(defensive_df, aes(x = TEAM, y = DEF_RTG), options(repr.plot.width = 10, repr.plot.height = 8)) +
  geom_boxplot(color = "red") +
  geom_jitter(width = 0.05, alpha = 0.5) +
  geom_hline(yintercept = mean(defensive_df$DEF_RTG), color = "blue", linetype = "dashed") + # league average
  geom_text(aes(x = 0, y = mean(DEF_RTG),label = "League Average"), color = "blue", hjust = 0, vjust = -0.5) +
  labs(title = "Defensive Rating by Team",
        x = "Team",
        y = "Defensive Rating")

# Boxplot: Defensive Win Shares by Team
ggplot(defensive_df, aes(x = TEAM, y = DEF_WS_TOTAL), options(repr.plot.width = 10, repr.plot.height = 8)) +
  geom_boxplot(color = "red") +
  geom_jitter(width = 0.05, alpha = 0.5) +
  geom_hline(yintercept = mean(defensive_df$DEF_WS_TOTAL), color = "blue", linetype = "dashed") + # league average
  geom_text(aes(x = 0, y = mean(DEF_WS_TOTAL),label = "League Average"), color = "blue", hjust = 0, vjust = -0.5) +
  labs(title = "Defensive Win Shares by Team",
        x = "Team",
        y = "Defensive Win Shares")

# I wanted to find the players with the best and worst defensive ratings and compare them to league average.
lowest_drtg <- min(defensive_df$DEF_RTG, na.rm = TRUE)
print(paste("BEST DEFENSIVE RATING: ", lowest_drtg, "-" ,defensive_df[defensive_df$DEF_RTG == lowest_drtg, "PLAYER"]))

highest_drtg <- max(defensive_df$DEF_RTG, na.rm = TRUE)
print(paste("WORST DEFENSIVE RATING: ", highest_drtg, "-" ,defensive_df[defensive_df$DEF_RTG == highest_drtg, "PLAYER"]))

average_drtg <- mean(defensive_df$DEF_RTG, na.rm = TRUE)
print(paste("AVERAGE DEFENSIVE RATING: ", average_drtg))

# Acquire the average defensive rating for each team by grouping players by what teams they play for. 
# This will give a better idea of how team defensive stats will affect a player's individual defensive stats. 
# There is a good chance there will be players with good individual stats but play on teams with bad defensive stats.

# Defensive Rating
# Group by team
avg_drtg_by_team <- defensive_df %>%
  group_by(TEAM)%>%
  summarise(Mean_DEF_RTG = mean(DEF_RTG, na.rm = TRUE, 1))

# Create data frame for team defensive rating
avg_drtg_by_team <- as.data.frame(avg_drtg_by_team)
names(avg_drtg_by_team) <- c("TEAM", "DEF_RTG")

# Defensive Rating in order from best to worst
avg_drtg_by_team[order(avg_drtg_by_team$DEF_RTG),]

# Win Shares
# Group by team
avg_dws_by_team <- defensive_df %>%
  group_by(TEAM)%>%
  summarise(Mean_DEF_WS_TOTAL = mean(DEF_WS_TOTAL, na.rm = TRUE, 1))

# Create data frame for team defensive win shares
avg_dws_by_team <- as.data.frame(avg_dws_by_team)
names(avg_dws_by_team) <- c("TEAM", "DEF_WS_TOTAL")

# Defensive Win Shares in order from best to worst
avg_dws_by_team[order(avg_dws_by_team$DEF_WS_TOTAL, decreasing = TRUE), ]
 
