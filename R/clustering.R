
heatmap(final, Rowv=FALSE,Colv=TRUE,dendrogram="col")

d <- dist(t(data), method="euclidean")
h <- hclust
pdf(file='hclust.pdf', height=15, width=10)
plot
dev.off()

pvcust_clustering <- function( Matrix = NULL, filePath = "PV_clust.pdf" , header = " PV : Bootstrap hierarchical Cluster"  )
{
       
       library(pvclust);
       result <- pvclust( Matrix, method.dist="cor", method.hclust="average", nboot=1000);
       
       pdf( paste( filePath , "PV_clust.pdf" , sep ="") , width = 24, height = 18 );
       plot(result)
       dev.off();
       
}
 
