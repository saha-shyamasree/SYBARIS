threshold=0.97
nohitContigs<-function(list_map)
{
    noHitContigs=matrix(ncol=2,dimnames=list(c(),c("filename","contigNode")))
    for(i in 1:length(list_map))
    {
        contigs=sub('^\\s+','',as.character(list_map[[i]][which(list_map[[i]][,"match"]=="no"),"query_name"]))
        noHitContigs=rbind(noHitContigs,cbind(sub('^\\s+','',as.character(list_map[[i]][which(list_map[[i]][,"match"]=="no"),"file"])),contigs))
    }
    write.csv(noHitContigs,file="/Volumes/ma-home/shyama/outputs/SYBARIS/R/OG/gap_penalty/noHitContigs.csv")
}

nohitContigsByCoverage<-function(list_map)
{
    noHitContigs=matrix(ncol=2,dimnames=list(c(),c("filename","contigNode")))
    for(i in 1:length(list_map))
    {
        contigs=sub('^\\s+','',as.character(list_map[[i]][which(list_map[[i]][,"coverage."]<threshold),"query_name"]))
        noHitContigs=rbind(noHitContigs,cbind(sub('^\\s+','',as.character(list_map[[i]][which(list_map[[i]][,"coverage."]<threshold),"file"])),contigs))
    }
    write.csv(noHitContigs,file="/Volumes/ma-home/shyama/outputs/SYBARIS/R/OG/gap_penalty/noHitContigsByCoverage.csv")
}

mismatchCount<-function(map_mat)
{
    #map_mat[,"match"]=sub('^\\s+','',map_mat[,"match"])
    unmatch=length(which(map_mat[,"match"]=="no"))
    #print(unmatch)
    #print(dim(map_mat))
    #perc=(unmatch/dim(map_mat)[1])*100
    #perc
}

mismatchCountIncludeLowCoverage<-function(map_mat)
{
    #map_mat[,"match"]=sub('^\\s+','',map_mat[,"match"])
    unmatch=length(which(map_mat[,"match"]=="no"))+length(which(map_mat[,"coverage."]<threshold))

    #print(unmatch)
    #print(dim(map_mat))
    #perc=(unmatch/dim(map_mat)[1])*100
    #perc
}

checkGap<-function(list_map)
{
    gap_info<-matrix(nrow=length(list_map),ncol=)
    for(i in 1:length(list_map))
    {
        nongapped_match=list_map[[i]][which(list_map[[i]][,"gap"]==0)]
        gapped_match=list_map[[i]][which(list_map[[i]][,"gap"]!=0)]
        
    }
}

#it arrange data per sample, per organism gene found.
geneInfo<-function(list_map,tab2,file_names)
{
    hit_def_all=sub('Aspergillus fumigatus A1163(.*)?','Aspergillus fumigatus A1163',tab2[,"hit_def"])
    hit_def_all=sub('Neosartorya fischeri NRRL(.*)?','Neosartorya fischeri NRRL',hit_def_all)
    overCoverage_all=hit_def[which(tab2[,"coverage."]>=threshold)]
    classes=unique(overCoverage_all,na.rm=TRUE)
    classes=classes[!is.na(classes)]
    count_sample_wise=matrix(nrow=length(list_map),ncol=length(classes),dimnames=list(c(file_names),c(classes)))
    for(j in 1:length(list_map))
    {
        hit_def=sub('Aspergillus fumigatus A1163(.*)?','Aspergillus fumigatus A1163',list_map[[j]][,"hit_def"])
        hit_def=sub('Neosartorya fischeri NRRL(.*)?','Neosartorya fischeri NRRL',hit_def)
        overCoverage=hit_def[which(list_map[[j]][,"coverage."]>=threshold)]
        
        count=matrix(nrow=length(classes),ncol=2,dimnames=list(c(),c("match","count")))
        for(i in 1:length(classes))
        {
            #count[i,"match"]=classes[i]
            #count[i,"count"]=length(which(overCoverage==classes[i]))
            count_sample_wise[sub('\\.out','',list_map[[j]][1,"file"]),classes[i]]=length(which(overCoverage==classes[i]))
        }
    }
    write.csv(count_sample_wise,file="/Volumes/ma-home/shyama/outputs/SYBARIS/R/OG/match_count_all_sample_wise.csv",quote=FALSE)
}

#following function arranges matches for each sample. We want to see see how many matches are there from each organism.
matchReference<-function(list_map,tab2,file_names)
{
    hit_def_all=sub('Aspergillus fumigatus A1163(.*)?','Aspergillus fumigatus A1163',tab2[,"hit_def"])
    hit_def_all=sub('Neosartorya fischeri NRRL(.*)?','Neosartorya fischeri NRRL',hit_def_all)
    overCoverage_all=hit_def[which(tab2[,"coverage."]>=threshold)]
    classes=unique(overCoverage_all,na.rm=TRUE)
    classes=classes[!is.na(classes)]
    count_sample_wise=matrix(nrow=length(list_map),ncol=length(classes),dimnames=list(c(file_names),c(classes)))
    for(j in 1:length(list_map))
    {
        hit_def=sub('Aspergillus fumigatus A1163(.*)?','Aspergillus fumigatus A1163',list_map[[j]][,"hit_def"])
        hit_def=sub('Neosartorya fischeri NRRL(.*)?','Neosartorya fischeri NRRL',hit_def)
        overCoverage=hit_def[which(list_map[[j]][,"coverage."]>=threshold)]
        
        count=matrix(nrow=length(classes),ncol=2,dimnames=list(c(),c("match","count")))
        for(i in 1:length(classes))
        {
            #count[i,"match"]=classes[i]
            #count[i,"count"]=length(which(overCoverage==classes[i]))
            count_sample_wise[sub('\\.out','',list_map[[j]][1,"file"]),classes[i]]=length(which(overCoverage==classes[i]))
        }
    }
    write.csv(count_sample_wise,file="/Volumes/ma-home/shyama/outputs/SYBARIS/R/OG/match_count_all_sample_wise.csv",quote=FALSE)
}
main<-function()
{
    #tab2=read.csv(file="/Volumes/ma-home/shyama/outputs/SYBARIS/Python/output/contig_blast_stat2.csv",header=TRUE)
    #tab2=read.csv(file="/Volumes/ma-home/shyama/outputs/SYBARIS/Python/output/contig_blast_AF293_gap_penalty_stat.csv",header=TRUE) 
    tab1=read.csv(file="/Volumes/ma-home/shyama/outputs/SYBARIS/Python/output/contig_blast_OG_gap_penalty_coverage_stat.csv",header=TRUE)
    tab2=read.csv(file="/Volumes/ma-home/shyama/outputs/SYBARIS/Python/output/contig_blast_OG_gap_penalty_stat.csv",header=TRUE)
    tab2=rbind(tab2,tab1)
    tab2[,"match"]=sub('^\\s+','',tab2[,"match"])
    file_names=sort(sub('\\.out','',unique(tab2[,"file"])))
    list_map=NULL
    matchPercent=matrix(nrow=length(file_names),ncol=3,dimnames=list(c(),c("sample","NotAligned","TotalContigs")),)
    matchPercent[,"sample"]=file_names
    
    matchPercentCoverage=matrix(nrow=length(file_names),ncol=3,dimnames=list(c(),c("sample","NotAligned","TotalContigs")),)
    matchPercentCoverage[,"sample"]=file_names
    
    for(f in file_names)
    {
        temp_list=tab2[which(tab2[,"file"]==paste(f,".out",sep="")),]
        matchPercent[which(matchPercent[,"sample"]==f),2:3]=c(mismatchCount(temp_list),dim(temp_list)[1])
        matchPercentCoverage[which(matchPercentCoverage[,"sample"]==f),2:3]=c(mismatchCountIncludeLowCoverage(temp_list),dim(temp_list)[1])
        list_map=c(list_map,list(temp_list))
    }
    nohitContigs(list_map)
    nohitContigsByCoverage(list_map)
    write.csv(matchPercent,file="/Volumes/ma-home/shyama/outputs/SYBARIS/R/OG/gap_penalty/unaligned.csv")
    write.csv(matchPercentCoverage,file="/Volumes/ma-home/shyama/outputs/SYBARIS/R/OG/gap_penalty/unalignedCoverage.csv")
    #density_plot(list_map)
    #hist_plot(list_map)
}

density_plot<-function(list_map)
{
    pdf(file="/Volumes/ma-home/shyama/outputs/SYBARIS/R/OG/gap_penalty/identityVSlength_Coverage1.pdf",width=10,height=11,paper="a4")
    par(mfcol=c(5,2))
    for(i in 1:10)
    {
        cov=list_map[[i]][,"coverage."]
        plot.density(density(cov,na.rm=TRUE),xlab=paste(as.character(list_map[[i]][1,"file"]),",qlen mean:",round(mean(list_map[[i]][,"query_length"])),",align length:",round(mean(list_map[[i]][,"align_length"],na.rm=TRUE)),sep=""))
    }
    dev.off()
    pdf(file="/Volumes/ma-home-1/shyama/outputs/SYBARIS/R/OG/gap_penalty/identityVSlength_Coverage2.pdf",width=10,height=11,paper="a4")
    par(mfcol=c(5,2))
    for(i in 11:length(list_map))
    {
        cov=list_map[[i]][,"coverage."]
        plot.density(density(cov,na.rm=TRUE),xlab=paste(as.character(list_map[[i]][1,"file"]),", qlen mean:",round(mean(list_map[[i]][,"query_length"])),",align length:",round(mean(list_map[[i]][,"align_length"],na.rm=TRUE)),sep=""))
    }
    dev.off()

}

hist_plot<-function(list_map)
{
    pdf(file="/Volumes/ma-home/shyama/outputs/SYBARIS/R/OG/gap_penalty/identityVSlength_hist1.pdf",width=10,height=11,paper="a4")
    par(mfcol=c(5,2))
    for(i in 1:10)
    {
        coverage=list_map[[i]][,"coverage."]
        hist(coverage,xlab=paste(as.character(list_map[[i]][1,"file"]),",qlen mean:",round(mean(list_map[[i]][,"query_length"])),",align length:",round(mean(list_map[[i]][,"align_length"],na.rm=TRUE)),sep=""),freq=TRUE)
    }
    dev.off()
    pdf(file="/Volumes/ma-home/shyama/outputs/SYBARIS/R/OG/gap_penalty/identityVSlength_hist2.pdf",width=10,height=11,paper="a4")
    par(mfcol=c(5,2))
    for(i in 11:length(list_map))
    {
        coverage=list_map[[i]][,"coverage."]
        hist(coverage,xlab=paste(as.character(list_map[[i]][1,"file"]),", qlen mean:",round(mean(list_map[[i]][,"query_length"])),",align length:",round(mean(list_map[[i]][,"align_length"],na.rm=TRUE)),sep=""),freq=TRUE)
    }
    dev.off()

}