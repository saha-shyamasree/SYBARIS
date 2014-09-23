############# GetORF vs PITORFAll ############

blastMatgetORFFEval
blastMatPITORFFEval
blastMatgetORF
blastMatPITORF

vec1 <- data.frame(x=rnorm(2000, 0, 1))
vec2 <- data.frame(x=rnorm(3000, 1, 1.5))

library(ggplot2)

ggplot() + geom_density(aes(x=x), colour="red", data=vec1) +
geom_density(aes(x=x), colour="blue", data=vec2)

#################  DB protein length dist  #######################

	 library(reshape)
 library(ggplot2)
a = read.delim("C:/Users/shyama/Dropbox/results/Human_adenovirus/humanAdenoProteinLengths.csv",sep=",",header=T)
#b=a[1:88687,]
X = rep( 1:dim(a)[1], 3)
a_melted = cbind( melt(a) , X )
## Line Plot ##
p1 <- ggplot(a_melted, aes( x = X, y = value, colour=variable, group=variable)) + geom_line() + ggtitle(" Proteins/ORFs Lendth")
p1
## Box Plot ##
p2 <- ggplot(a_melted, aes( factor( variable ), value, colour=variable ) ) + geom_boxplot() + ggtitle(" Proteins/ORFs Length")
p2