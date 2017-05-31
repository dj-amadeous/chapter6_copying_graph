#boxplot from homework udemy course chapter 6
getwd()
setwd("/home/evan/Desktop/data_science_files/chaper_6")
movies <- read.csv("Section6-Homework-Data.csv")
head(movies)

#install and library activation
#install.packages("ggplot2")
library(ggplot2)
str(movies)
summary(movies)

#change names to something easier
library(data.table)
oldNames <- c("Release.Date", "Adjusted.Gross...mill.", "Budget...mill.", "Gross...mill.", "IMDb.Rating", "MovieLens.Rating",
              "Overseas...mill.", "Overseas.", "Profit...mill.", "Profit.", "Runtime..min.", "US...mill.", "Gross...US")
newNames <- c("ReleaseDate", "AdjustedGrossMill", "BudgetMill", "GrossMill", "IMDbRate", "MovieLensRate", 
              "OverseasMill", "OverSeas", "ProfitMill", "Profit", "RunTimeMin", "USMill", "GrossUS")

setnames(movies, oldNames, newNames)

colnames(movies)
colnames(movies)[1] <- "DayOfWeek"
colnames(movies)[4] <- "movieTitle"


#filter dataset for required genre
head(movies)
#filter for genre
filterGenre <- (movies$Genre=="action") | (movies$Genre=="adventure") | (movies$Genre=="animation") | (movies$Genre=="comedy") | (movies$Genre=="drama")
filterStudio <- (movies$Studio=="Buena Vista Studios") | (movies$Studio=="Fox") | (movies$Studio=="Paramount Pictures") | (movies$Studio=="Sony") | (movies$Studio=="Universal") | (movies$Studio=="WB")

moviesFiltered <- movies[filterGenre & filterStudio,]
head(moviesFiltered)

#visualization components
p <- ggplot(data=moviesFiltered, aes(x=Genre, y=GrossUS))
final_graph <- p +
  geom_jitter(aes(color=Studio, size=BudgetMill)) +
  geom_boxplot(alpha=0.7, outlier.color=NA) 
  
 
final_graph <- final_graph + 
  xlab("Genre") +
  ylab("Gross % US") +
  ggtitle("Domestic Gross % by Genre")
final_graph

#fix theme
final_graph + 
  theme(
    axis.title.x = element_text(color="Blue", size=20),
    axis.title.y = element_text(color="Blue", size=20),
    axis.text.x = element_text(size=20),
    axis.text.y = element_text(size=20),
    
    plot.title = element_text(size=40),
    
    legend.title = element_text(size = 20),
    legend.text = element_text(size=20),
    
    text = element_text(family="Comic Sans MS")
  )
#change titles
final_graph$labels$size <- "Budget $M"
final_graph
