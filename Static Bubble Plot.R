# Libraries
library(ggplot2)
library(dplyr)
library(readr)
library(scales)

# load data
# The dataset is provided in the gapminder library
library(gapminder)
data2007 <- gapminder %>% filter(year=="2007") %>% dplyr::select(-year)


# make bubble chart
ggplot(data2007, aes(x = gdpPercap, y = lifeExp)) +
  xlab("GDP per capita") +
  ylab("Life expectancy at birth") +
  theme_minimal(base_size = 12, base_family = "Georgia") +
  geom_point(aes(size = pop, color = continent), alpha = 0.7) +
  scale_size_area(guide = FALSE, max_size = 15) +
  scale_x_continuous(labels = dollar) +
  stat_smooth(formula = y ~ log10(x), se = FALSE, size = 0.5, color = "black", linetype="dotted") +
  scale_color_brewer(name = "", palette = "Set2") +
  theme(legend.position=c(0.8,0.4))

