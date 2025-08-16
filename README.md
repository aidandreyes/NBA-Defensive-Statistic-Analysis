# NBA Defensive Statistic Analysis (in progress)

Start date: 7/28/2025

This project aims to use R to analyze individual player defensive stats from the 2024-25 NBA season to project the best defensive players in the league this season. 

This project uses preexisting data from the 2024-2025 NBA season via the NBA.com website.

Per game data can be viewed at https://www.nba.com/stats/players/defense?SeasonType=Regular+Season. 
Season total data can be viewed at https://www.nba.com/stats/players/defense?SeasonType=Regular+Season&PerMode=Totals. 
Defensive field goals allowed stats were taken from https://www.nba.com/stats/players/defense-dash-overall?PerMode=Totals&SeasonType=Regular+Season&Season=2024-25.

Make sure to download and add the Excel file from here into the local file directory before starting. A glossary for all the abbreviated basketball statistic terms used can be found at https://github.com/aidandreyes/NBA-Defensive-Statistic-Analysis/blob/main/StatGlossary.md.

This analysis aims to analyze which advanced defense statistic categories are best indicative of predicting a player's defensive rating and win shares.

Defensive rating in basketball refers to the metric that measures how many points a player allows while on the court per 100 possessions. A lower rating indicates better defensive performance, while higher indicates worse. However, this stat can be flawed due to its heavily reliance on team-level statistics and does not accurately take into account a player's defensive off-ball contributions. For example, a player can lead the league in simple box score statistics such as steals or blocks, but have a lower defensive rating due to the rest of their team's cumulative struggles.

Defensive win shares estimate how many wins a player contributes to their team solely through defensive contributions. This is calculated by a formula of (player minutes played / team minutes played) * (team defensive possessions) * (1.08 * (league points per possession) - ((Defensive Rating) / 100)).

I wanted to perform this analysis to highlight both the best defensive players in the league (numbers-wise), but also the fact that statistics do not always tell the whole story as these stats can misrepresent an individual's true on-court defensive impact. Certain metrics can overlook aspects like help defense, defensive positioning, team communication, and other impact plays that do not show up on the box score.
