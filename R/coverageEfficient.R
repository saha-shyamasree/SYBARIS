
chr=list()
#sample="C1WU4ACXX_2_13nf.bed"
sample="C11CBACXX_6_3.bed"
#bedPath="/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/data/AspergillusNiger/batch2/Sybaris_23/20130417/FASTQ/sam/Filtered/Coverage/"
bedPath="/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/data/AspergillusNiger/sam/Filtered/Coverage/"
x=read.table(file=paste(bedPath,sample,sep=""),header=FALSE)  #/Volumes/ma-home/shyama/DATA/SYBARIS/Alergenetica/data/Cladosporium/rerun_cladosporium_um/samContigsAlign/Filtered/Coverage/C11CBACXX_6_7_coverage.bed
contig_names=unique(as.character(x[,1]))
x.ordered=x[order(x[,1],x[,2]),]

for(i in 1:length(contig_names))
{
    chr[[i]]=x.ordered[which(x.ordered[,1]==contig_names[i]),]
}

#path="/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/data/AspergillusNiger/batch2/Sybaris_23/20130417/FASTQ/sam/Filtered/CoveragePlot/" #path="/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/data/Cladosporium/rerun_cladosporium_um/samContigsAlign/Filtered/Coverage/C11CBACXX_6_7"
#path="/Volumes/ma-home/shyama/DATA/SYBARIS/Alergenetica/data/AspergillusNiger/batch2/Sybaris_23/20130403/FASTQ/sam/Filtered/vcf/sorted/CoveragePlot/"
path="/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/data/AspergillusNiger/sam/Filtered/CoveragePlot/"
sample=strsplit(sample,".",fixed=TRUE)[[1]][1]
dir.create(paste(path,sample,sep=""))
for(j in 1:length(contig_names))
{
    
    len=length(chr[[j]][,4])
    at=floor(len/500)
    pdfwidth=(len/1750)
    pdfheight=(max(chr[[j]][,4])/1000)
    print(j)
    print(pdfwidth)
    print(pdfheight)
    pdf(file=paste(path,sample,"/",sample,"_chr","_",j,"_scaled.pdf",sep=""),width=(1+pdfwidth),height=(1.5+pdfheight),title=sample)
    
    #b<-barplot(chr[[j]][,4]/1000,plot=TRUE)
    
    b<-plot(chr[[j]][,4],type="h",col="gray30", ylim=c(0,max(chr[[j]][,4])))
    par(pin=c(pdfwidth,pdfheight))
    print("success")
    
    #axis(side=1,at=b[c(1,c(1:(len/100))*100)],labels=seq(0,len,by=100))
    dev.off()
    
}

ind=0
mlen=0
lendist=NULL

for(j in 1:length(contig_names))
{
    lendist=rbind(lendist,dim(chr[[j]])[1])
}

indices=which(lendist>=50)
merged=c()
for(j in 1:length(contig_names))
{
    #if(length(which(chr[[j]][,4]>60000)))
    #{
     #   print(j)
    #}    
    merged=c(merged,chr[[j]][,4])
}

pdf(file=paste(path,sample,"/",sample,".pdf",sep=""),title=sample)
barplot(merged,plot=TRUE)
dev.off()
