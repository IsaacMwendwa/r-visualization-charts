# Libraries
library(readr)
library(ggplot2)
library(dplyr)
library(plotly)
library(viridis)
library(hrbrthemes)

# Use updated dataset, which is found at https://paldhous.github.io/ucb/2016/dataviz/data/week8.zip
# load data
nations <- read_csv("nations.csv")

# filter for 2014 data only
data2014 <- nations %>%
  filter(year == 2014)

# Interactive version
p <- data2014 %>%
  mutate(gdp_percap=round(gdp_percap,0)) %>%
  mutate(population=round(population/1000000,2)) %>%
  mutate(life_expect=round(life_expect,1)) %>%
  
  # Reorder countries to having big bubbles on top
  arrange(desc(population)) %>%
  mutate(country = factor(country, country)) %>%
  
  # prepare text for tooltip
  mutate(text = paste("Country: ", country, "\nRegion: ", region, "\nPopulation (M): ", population, "\nLife Expectancy: ", life_expect, "\nGdp per capita: ", gdp_percap, sep="")) %>%
  
  # Classic ggplot
  ggplot( aes(x=gdp_percap, y=life_expect, size = population, color = region, text=text)) +
  geom_point(alpha=0.7) +
  scale_size(range = c(1.4, 19), name="Region") +
  scale_color_viridis(discrete=TRUE, guide="none") +
  theme_ipsum() +
  theme(legend.position=c(0.8,0.4))

# turn ggplot interactive with plotly
pp <- ggplotly(p, tooltip="text")
pp

# save the widget
# library(htmlwidgets)
# saveWidget(pp, file=paste0( getwd(), "/HtmlWidget/ggplotlyBubblechart.html"))