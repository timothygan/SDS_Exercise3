library(ggplot2)
library(LICORS)  # for kmeans++
library(foreach)
library(mosaic)
library(factoextra)
library(ggplot2)
#wine = read.csv("wine.csv", stringsAsFactors = FALSE)
summary(wine)

# Center and scale the data
wine$color[wine$color == 'red'] <- 0
wine$color[wine$color == 'white'] <- 1
summary(wine)
X_wine = wine[, (0:10)]
X_wine = scale(X_wine, center=TRUE, scale=TRUE)

mu = attr(X_wine,"scaled:center")
sigma = attr(X_wine,"scaled:scale")

clust1 = kmeanspp(X_wine, 2, nstart=25)
clust2 = kmeanspp(X_wine, 6, nstart=25)

#clust1$center  # not super helpful
#clust1$center[1,]*sigma + mu
#clust1$center[2,]*sigma + mu


# Which cars are in which clusters?
# which(clust1$cluster == 1)
# which(clust1$cluster == 2)


length(which(wine$color[which(clust1$cluster == 1)] == "1"))
length(which(wine$color[which(clust1$cluster == 1)] == "0"))
length(which(wine$color[which(clust1$cluster == 2)] == "1"))
length(which(wine$color[which(clust1$cluster == 2)] == "0"))

mean(wine$quality[which(clust2$cluster == 1)])
mean(wine$quality[which(clust2$cluster == 2)])
mean(wine$quality[which(clust2$cluster == 3)])
mean(wine$quality[which(clust2$cluster == 4)])
mean(wine$quality[which(clust2$cluster == 5)])
mean(wine$quality[which(clust2$cluster == 6)])

pc2 = prcomp(X_wine, scale=TRUE, rank=2)
loadings = pc2$rotation
scores = pc2$x

qplot(scores[,1], scores[,2], color=wine$color, xlab='Component 1', ylab='Component 2')
loadings[,1] %>% sort %>% head(20)
loadings[,1] %>% sort %>% tail(20)
#qplot(citric.acid, quality, data=wine, color=factor(clust1$cluster))

