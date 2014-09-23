library(VennDiagram);

## Create a 1kb SNP Rate ##
interval_1kb_file = read.delim( "/Volumes/ma-home/shyama/DATA/SYBARIS/Alergenetica/interval.bed" , sep = "\t" , header = F);

## Interval [ Perl Kilobase ] SNP count was generated as follows ## 
cat C11CBACXX_6_4.bed | awk '{print $1"\t"$2"\t"$2}' > C11CBACXX_6_4.mod.bed
cat C11CBACXX_6_4.mod.bed | sed 's/chr//g' > C11CBACXX_6_4.bed
/Users/rm8/Software/Bioinformatics/BEDTools-Version-2.15.0/bin/bedtools coverage -a C11CBACXX_6_4.bed -b ../../Aspergillius_1k_interval.bed > C11CBACXX_6_4.per_kb_SNP.bed

C11CBACXX_6_1 = read.delim( "/Users/rm8/Mamun/Shyama_Analysis/VCF_Files/VCF_Files/C11CBACXX_6_1.per_kb_SNP.bed" , sep = "\t" , header = F )
C11CBACXX_6_2 = read.delim( "/Users/rm8/Mamun/Shyama_Analysis/VCF_Files/VCF_Files/C11CBACXX_6_2.per_kb_SNP.bed" , sep = "\t" , header = F )
C11CBACXX_6_3 = read.delim( "/Users/rm8/Mamun/Shyama_Analysis/VCF_Files/VCF_Files/C11CBACXX_6_3.per_kb_SNP.bed" , sep = "\t" , header = F )
C11CBACXX_6_4 = read.delim( "/Users/rm8/Mamun/Shyama_Analysis/VCF_Files/VCF_Files/C11CBACXX_6_4.per_kb_SNP.bed" , sep = "\t" , header = F )

C11CBACXX_All_Sample_Per_KB_SNP_Count = cbind( C11CBACXX_6_1[,4] , C11CBACXX_6_2[,4] , C11CBACXX_6_3[,4] , C11CBACXX_6_4[,4] )
colnames(C11CBACXX_All_Sample_Per_KB_SNP_Count) = c( "C11CBACXX_6_1" , "C11CBACXX_6_2" , "C11CBACXX_6_3" , "C11CBACXX_6_4" );
row.names( C11CBACXX_All_Sample_Per_KB_SNP_Count ) = paste( C11CBACXX_6_1[,1] , C11CBACXX_6_1[,2] , C11CBACXX_6_1[,3] , sep = "-" ) 
write.table( C11CBACXX_All_Sample_Per_KB_SNP_Count , "AsperGillius_Strains.txt" , sep = "\t")

C11CBACXX_All_Sample_Per_KB_SNP_Count_Sorted = read.delim( "AsperGillius_Strains.txt" , sep = "\t" , row.names = 1, stringsAsFactors = F)
pdf( file = " AsperGillius_Strains.pdf", width = 18, height = 14 );
par( mfrow = c(4,1) );
barplot( as.numeric(C11CBACXX_All_Sample_Per_KB_SNP_Count_Sorted[,1]) , beside = T , main = " AsperGillius Strains :  " , col = c("dodgerblue4") )
barplot( as.numeric(C11CBACXX_All_Sample_Per_KB_SNP_Count_Sorted[,2]) , beside = T , main = " AsperGillius Strains :  " , col = "dodgerblue4" )
barplot( as.numeric(C11CBACXX_All_Sample_Per_KB_SNP_Count_Sorted[,3]) , beside = T , main = " AsperGillius Strains :  " , col = "dodgerblue4" )
barplot( as.numeric(C11CBACXX_All_Sample_Per_KB_SNP_Count_Sorted[,4]) , beside = T , main = " AsperGillius Strains :  " , col = "dodgerblue4" , names = row.names ( C11CBACXX_All_Sample_Per_KB_SNP_Count_Sorted ) , las = 2 )
dev.off()


source("~/Sanger/My_Code/R/Plotting_Functions/mutation_pattern_plot.R"); 
## set working direcotry ##
setwd("/Users/rm8/Mamun/Shyama_Analysis/VCF_Files/VCF_Files/");

C11CBACXX_6_1 = "/Volumes/ma-home/shyama/DATA/SYBARIS/Alergenetica/data/AspergillusNiger/vcf/C11CBACXX_6_1.vcf"
mutation_pattern_plot ( File = C11CBACXX_6_1 , vcf_mode = TRUE , file_header = "C11CBACXX_6_1", nucColumn =  c("REF","ALT"));

C11CBACXX_6_2 = "/Volumes/ma-home/shyama/DATA/SYBARIS/Alergenetica/data/AspergillusNiger/vcf/C11CBACXX_6_2.vcf"
mutation_pattern_plot ( File = C11CBACXX_6_2 , vcf_mode = TRUE , file_header = "C11CBACXX_6_2", nucColumn =  c("REF","ALT"));




C11CBACXX_6_3 = "/Volumes/ma-home/shyama/DATA/SYBARIS/Alergenetica/data/AspergillusNiger/vcf/C11CBACXX_6_3.vcf"
mutation_pattern_plot ( File = C11CBACXX_6_3 , vcf_mode = TRUE , file_header = "C11CBACXX_6_3", nucColumn =  c("REF","ALT"));

C11CBACXX_6_4 = "/Volumes/ma-home/shyama/DATA/SYBARIS/Alergenetica/data/AspergillusNiger/vcf/C11CBACXX_6_4.vcf"
mutation_pattern_plot ( File = C11CBACXX_6_4 , vcf_mode = TRUE , file_header = "C11CBACXX_6_4", nucColumn =  c("REF","ALT"));




perl /Users/rm8/Sanger/My_Code/Perl/Perl_Lib/Somatic_Caller/My_Scripts/scientist_friendly_format.pl -v /Users/rm8/Mamun/Shyama_Analysis/VCF_Files/VCF_Files/Merged.sorted.duplicateRemoved.vcf -s mouse -o /Users/rm8/Mamun/Shyama_Analysis/VCF_Files/VCF_Files/Merged.sorted.duplicateRemoved.csv -db NCBIM36 -st 1



### New  Rcurrent Mutation Pattern  12 - 02 - 2013 ###

	## Plot Recurrent Mutation Pattern Plot ##
	mutationFilePath = "/Users/rm8/Mamun/Shyama_Analysis/VCF_Files/VCF_Files/Merged.sorted.duplicateRemoved_SNP.txt";
	sampleInfoPath = "/Users/rm8/Sanger/NGS_Analysis/experiments/Second_Site_Malignancy/SampleInfo/Second_Malignant_Neoplasms.csv";
	heatmapFileName =  "/Users/rm8/Sanger/NGS_Analysis/experiments/Second_Site_Malignancy/Results/Second_Site_Neoplasm_4_of_4_VAR_0.1.sorted.duplicateRemoved_Recurrent_Mutation_1.pdf";
	heatmapMainLabel = " Second Site Malignancy : Mutation pattern 4 of 4 Callers";
	# New Color Pallet for Transition Type 
	#	A - > G = 1 ; A - > C = 2; A - > T = 3     [ Look for Dark red to light Red ] ; 
	#	T - > G = 4 ; T - > C = 5; T - > A = 6;    [ Look for Dark Green to light Green ] ;
	#	C - > A = 7 ; C - > T = 8; C - > G = 9;    [ Look for Dark Blue to light blue ] ;
	#	G - > T = 10; G - > A = 11; G - > C = 12;  [ Look for Orange to Yellow ] ;
	redTransitionColor = c(556, 554, 134);
	greenTransitionColor = c(139, 50, 494 );
	blueTransitionColor = c(491, 131, 68 );
	orangeTransitionColor = c(585, 142, 410 );
	
	transitionColorPal = colors()[ c( redTransitionColor , greenTransitionColor, blueTransitionColor , orangeTransitionColor )  ];	
	transitionColorPal =  c( "grey99" , transitionColorPal); 
	
	for_transition_type = c( "orangered4","dodgerblue4","darkolivegreen1","darkorchid1","darkgreen","yellow2" )
	transitionColorPal =  c( "grey99" , for_transition_type);
	
	source("/Users/rm8/Sanger/My_Code/R/Plotting_Functions/recurrence_mutation_plot.R");
	mutationPlot( mutationFilePath = mutationFilePath , sampleInfoPath = sampleInfoPath , sampleIDCol = "SampleID", cohortColumns = c("Cohort","Type") , 
			annotationColumn = c("Chromosome","Start","End","Gene_Name") , pointMutation = TRUE, sampleColStart = 17  , skipRow = 0 , fileName = heatmapFileName , 
			mainLabel = heatmapMainLabel , transitionColorPal = transitionColorPal ); 
	
	
	
	
	## Sample Wise Alteration types 2 of 4 callers ##
	
		second_site_neoplasm_2_of_4_file = read.delim("/Users/rm8/Sanger/NGS_Analysis/experiments/Second_Site_Malignancy/Results/Second_Site_Neoplasm_2_of_4_VAR_0.1.sorted.duplicateRemoved_Alteration_Added_Copy.txt", sep = "\t" , header = T, stringsAsFactors = F )
		second_site_neoplasm_2_of_4_file_alteration_types = unique(second_site_neoplasm_2_of_4_file$Alteration)    
		second_site_neoplasm_2_of_4_file_alteration_types = second_site_neoplasm_2_of_4_file_alteration_types[second_site_neoplasm_2_of_4_file_alteration_types!= ""]
		alteration_by_sample = c();
		
		for( i in 1:length( second_site_neoplasm_2_of_4_file_alteration_types ) )
		{
			temp = second_site_neoplasm_2_of_4_file [ which ( second_site_neoplasm_2_of_4_file$Alteration == second_site_neoplasm_2_of_4_file_alteration_types[i] ) ,  ];  
			temp = temp[ , 17 : ( dim(temp)[2] - 1 )  ];
			temp  = as.matrix( temp );
			mode(temp) = "numeric"
			if( i == 1)
			{ 
				alteration_by_sample = colSums(temp); 
			}
			else
			{
				alteration_by_sample = rbind( alteration_by_sample , colSums(temp) )
				
			}
		}
		
		
		rownames( alteration_by_sample ) = second_site_neoplasm_2_of_4_file_alteration_types;
		write.table( alteration_by_sample, "/Users/rm8/Sanger/NGS_Analysis/experiments/Second_Site_Malignancy/Data/Second_Site_Neoplasm_2_of_4_VAR_0.1_alteration_by_sample.txt" , sep = "\t" );
		pdf( file = "/Users/rm8/Sanger/NGS_Analysis/experiments/Second_Site_Malignancy/Plots/Second_Site_Neoplasm_4_of_4_Genotype_2_VAR_0.1_alteration_by_sample.pdf", width = 18, height = 12 );
		par(oma = c(10,2,2,3));
		barplot( alteration_by_sample ,  col = colors()[ c(404,504,36,43,68,125,654,149,54,494,257,139) ] , main = paste("Distrubition of Mutation Pattern Across Samples \n", "Second Site Neoplasms 4 of 4 caller Approach [ Genotype Matched across 2 callers ]" ,"\nTotal Mutation : ", 5592 ,sep=""), xlab = "Samples ", ylab = "  Alteration Types ", legend.text= rownames (alteration_by_sample) , las = 2 ); 
		dev.off();	
	
	#### -------------------  ####
	
	
	
	