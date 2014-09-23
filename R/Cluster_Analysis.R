library(cluster);
library(e1071);
library(gplots);


## Cluster Main function ##

call_cluster <- function( Matrix = NULL , filePath = "Cluster.pdf" , header = "Cluster" , cluster_type = "k_means,hierarchical,hamming_distance,spearman", method = "complete" , no_of_centers = 4, no_of_iterations = 100, nstart = 1 ){
	
	cluster_type_arr = unlist(strsplit( cluster_type , split = "," , fixed = TRUE ) );
	cluster_type_arr = cluster_type_arr[ !is.na(cluster_type_arr) ];
	
	Matrix = as.matrix(Matrix);
	mode(Matrix) = "numeric";
	
	print( cluster_type_arr )
	
	for( i in 1:length(cluster_type_arr) ){
		
		if( cluster_type_arr[i] == "k_means"  ){
			hierarchical_cluster ( Matrix = Matrix, filePath = filePath , header = header , method = method );
		}
		if( cluster_type_arr[i] == "hierarchical"  ){
			kmeans_cluster ( Matrix = Matrix, filePath = filePath , header = header , no_of_centers = no_of_centers , no_of_iterations = no_of_centers, nstart = nstart );
		}
		if( cluster_type_arr[i] == "hamming_distance"  ){
			hamming_cluster ( Matrix = Matrix, filePath = filePath , header = header );
		}
		if( cluster_type_arr[i] == "spearman"  ){
			spearman_cluster ( Matrix = Matrix, filePath = filePath , header = header  );	
		}
	}	
	
}



# ----- ##
## -- Clustering based on euclidian distance -- ##
# ----- ##

hierarchical_cluster <- function( Matrix = NULL, filePath = "H_Clust.pdf" , header = "Hierarchical_Cluster" , method = "complete" )
{

	Matrix_hc = hclust(dist(t(Matrix)) , method = method );
	par(oma = c(12, 5, 5, 12));
	pdf( paste( filePath , method , "_Hierarchical_Cluster.pdf" , sep ="") , width = 24, height = 18 );
	plot( Matrix_hc , hang = -1 , main = paste( "Hierarchical Cluster : " , header , sep = "" )  )
	dev.off();
	
}


# ------ #
# Try with K-means clustering
# ------ #

kmeans_cluster <- function( Matrix = NULL, filePath = "./" , header = "Kmeans_Cluster" , no_of_centers = 4, no_of_iterations = 100, nstart = 1 )
{
	
	Matrix_kmeans = kmeans( t(Matrix) , centers = no_of_centers, iter.max = no_of_iterations, nstart = nstart  );
	par(oma = c(5, 5, 5, 5) );
	pdf( paste( filePath , "K_Means_Cluster.pdf" , sep ="") , width = 24, height = 18 );
	plot( t(Matrix) , col = Matrix_kmeans$cluster , main = paste( " K_Means Cluster : " , header , sep = "" ) )
	dev.off();
	
}



# ------ #
# Try with Hamming Distance
# ------ #

hamming_cluster <- function( Matrix = NULL, filePath = "Hamming_Distance.pdf" , header = "Hamming Distance"  ){

	hamming_distance = hamming.distance ( t(Matrix) );
	par(oma = c(10, 5, 5, 10) );
	pdf( paste( filePath , "Hamming_Distance_Cluster.pdf" , sep ="") , width = 24, height = 18 );
	heatmap.2(hamming_distance , scale = c("none") , col = rev(redgreen(128)) , trace = "none" , main = paste( "Hamming Distance : " , header , sep = "" ) );
	dev.off();
 
}


## Spearman Rank Test Clstering ##

spearman_cluster <- function( Matrix = NULL, filePath = "Spearman_Correlation.pdf" , header = "Spearman Correlation"  ){
	
	print(class(Matrix));
	print(head(Matrix));
	Matrix_spearman = cor( Matrix , method = "spearman" );
	par(oma = c(10, 5, 5, 10) );
	pdf( paste( filePath , "Spearman_Cluster.pdf" , sep ="") , width = 24, height = 18 );
	heatmap.2( Matrix_spearman , col = rev(terrain.colors(10)) , main = paste( "Spearman Correlation : " , header , sep = "" ) , trace = "none" ) ;
	dev.off();
}



## Principle Component Analysis ##

pca_clustering <- {

	require(snpStats)
	data(for.exercise)
	controls <- rownames(subject.support)[subject.support$cc==0]
	use <- seq(1, ncol(snps.10), 10)
	ctl.10 <- snps.10[controls,use]
	
	snpsum <- col.summary(snps.10)
	par(mfrow = c(1, 2))
	
	hist(snpsum$MAF)
	hist(snpsum$z.HWE)
	
	
}





# ---------------- #
# Now Try with fuzzy c means clustering #

#
#cmeans(x, centers, iter.max = 100, verbose = FALSE,
#		dist = "euclidean", method = "cmeans", m = 2,
#		rate.par = NULL, weights = 1, control = list())

