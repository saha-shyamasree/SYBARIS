library(gplots)

## ---- ===== Import Required functions ====== ----- ##
	#source("/nfs/users/nfs_r/rm8/My_Code/R/Data_Analysis_Functions/GeneExpression_Stats.R");
#	source("/nfs/users/nfs_r/rm8/My_Code/R/Data_Analysis_Functions/linearModel.R")	
#	source("/Users/rm8/Sanger/My_Code/R/Annotation_Functions/annotateWithBiomaRt.R");
#	source("/Users/rm8/Sanger/My_Code/R/Pathway_Analysis/gene_ontology_analysis.R");
#	source("/Users/rm8/Sanger/My_Code/R/Plotting_Functions/modified.heatmap.plus.R");
## ---- ===== Import Required functions ====== ----- ##
	

## New Analysis - Heatmap Creation for Top 20 over and under expressed genes ##

#heatmap_plotter( filePath = "/nfs/ma/home/shyama/DATA/SYBARIS/data/ortholog/orthologous_only_orthologs.csv", sep ="," , rownames = 1, dendrogram = "col", col_range = 3, main_label = "Aspergillus", pdf_path = "/nfs/ma/home/shyama/DATA/SYBARIS/data/ortholog/orthologous_protein_seq_only_orthologs.pdf", Colv = TRUE );

heatmap_plotter <- function( filePath = "/nfs/ma/home/shyama/DATA/SYBARIS/data/ortholog/orthologous_only_orthologs.csv", sep ="\t" , rownames = 1, dendrogram = "none", col_range = 3, main_label = "Aspergillus", pdf_path = "/nfs/ma/home/shyama/DATA/SYBARIS/data/ortholog/orthologous_protein_seq_only_orthologs.pdf", col = c( colors()[c(1,133,657)] ), Colv = FALSE, Rowv = FALSE )
{
	
	data = read.delim( filePath , sep = sep , header = TRUE, stringsAsFactors = F , row.names = 1 ) ;
	print(dim(data));
	data = as.matrix(data);
	pdf( file = pdf_path , width = 12, height = 16 );
	par(oma=c(5,2,2,1))
	heatmap.2( data , scale = c("none") , col = col , trace = "none" , main = main_label , dendrogram = dendrogram, Colv = Colv, Rowv = Rowv );
	dev.off();
}
	
	
	
