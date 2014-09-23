path="/Volumes/ma-home/shyama/DATA/SYBARIS/data/vcf/"
fileNames=list.files(path=path,pattern="*.vcf")
vcf_r=list()
vcf_s=list()

all_files=list()
for(i in 1:length(fileNames))
{
    vcf_obj=read.table(file=paste(path,fileNames[i],sep=""),sep="\t")
    all_files[[fileNames[i]]]=vcf_obj
}

resistants=c("C023MABXX_3_7.vcf","C023MABXX_3_6.vcf","C023MABXX_3_5.vcf","C023MABXX_3_4.vcf","C023MABXX_3_3.vcf","C023MABXX_3_2.vcf","C023MABXX_3_1.vcf","D0ACKACXX_1_2.vcf","D0ACKACXX_1_3.vcf","D0ACKACXX_1_6.vcf","D0ACKACXX_1_8.vcf","D0ACKACXX_1_9.vcf","D0ACKACXX_2_14.vcf")
j=1
k=1
for(i in 1:length(fileNames))
{
    vcf_obj=read.table(file=paste(path,fileNames[i],sep=""),sep="\t")
    if(length(which(resistants==fileNames[i]))>0)
    {
        vcf_r[[fileNames[i]]]=vcf_obj[,c(1,2)]
        j=j+1
    }
    else
    {
        vcf_s[[fileNames[i]]]=vcf_obj[,c(1,2)]
        k=k+1
    }
}

first=list()
for(i in 1:(length(vcf_r)-1))
{
    for(j in 2:length(vcf_r))
    {
        first[[paste(i,j,sep="_")]]=vcf_r[[j]][unlist(apply(vcf_r[[i]],1,function(x) { which(x[1]==vcf_r[[j]][,1] & x[2]==vcf_r[[j]][,2])})),]
    }
}

sensitive=list()
for(i in 1:(length(vcf_s)-1))
{
    for(j in 2:length(vcf_s))
    {
        sensitive[[paste(i,j,sep="_")]]=vcf_s[[j]][unlist(apply(vcf_s[[i]],1,function(x) { which(x[1]==vcf_s[[j]][,1] & x[2]==vcf_s[[j]][,2])})),]
    }
}

sink(file="overlap_sensitive.txt")
print(sensitive)
sink(NULL)

all_over=first[[1]]
for(i in 2:length(first))
{
    all_over=all_over[unlist(apply(first[[i]],1,function(x) { which(x[1]==all_over[,1] & x[2]==all_over[,2])})),]
}



all_over_sensitive=sensitive[[1]]
for(i in 2:length(sensitive))
{
    all_over_sensitive=all_over_sensitive[unlist(apply(sensitive[[i]],1,function(x) { which(x[1]==all_over_sensitive[,1] & x[2]==all_over_sensitive[,2])})),]
}

all_files_mutation=list()
for(i in 1:length(fileNames))
{
    if(length(which(resistants==fileNames[i]))>0)
    {
        all_files_mutation[[fileNames[i]]]=all_files[[fileNames[i]]][unlist(apply(all_over,1,function(x) { which(x[1]==all_files[[fileNames[i]]][,1] & x[2]==all_files[[fileNames[i]]][,2])})),]
    }
}

for(i in names(all_files_mutation))
{
    print(all_files_mutation[[i]][,c(1,2,4,5)])
}