

coverageplot<-function(chr1,name)
{
#pdf(file=paste(path,name,".pdf",sep=""),onefile=TRUE,paper="a4")
interval=1000
len=dim(chr1)[1]%/%interval
index=c(1,c(1:len)*1000)

covchr1=c(1:(len+1))*0
for(i in 1:(length(index)-1))
{
    covchr1[i]=sum(chr1[index[i]:(index[i+1]-1),3])/interval
}

covchr1[i]=sum(chr1[index[length(index)]:dim(chr1)[1],3])/interval
sink(file="/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/data/AspergillusNiger/bamBothReadMapped/mapqfilterd/C11CBACXX_6_3.log",append=TRUE)
print(name)
print(which(covchr1<5))
#barplot(as.vector(covchr1),xlab=paste("Feature",name,sep=""), col="red",border="darkblue")
sink(NULL)
#dev.off()
}


chr=list()
x=read.table(file="/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/data/AspergillusNiger/bamBothReadMapped/mapqfilterd/genomeCov/C11CBACXX_6_3.tsv",header=FALSE)
chr[[1]]=x[which(x[,1]=="I"),]
chr[[2]]=x[which(x[,1]=="II"),]
chr[[3]]=x[which(x[,1]=="III"),]
chr[[4]]=x[which(x[,1]=="IV"),]
chr[[5]]=x[which(x[,1]=="V"),]
chr[[6]]=x[which(x[,1]=="VI"),]
chr[[7]]=x[which(x[,1]=="VII"),]
chr[[8]]=x[which(x[,1]=="VIII"),]
path="/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/data/AspergillusNiger/bamBothReadMapped/mapqfilterd/genomeCov/C11CBACXX_6_3"

for(j in 1:8)
{
    coverageplot(chr[[j]],paste("_chr",j,sep=""))
}