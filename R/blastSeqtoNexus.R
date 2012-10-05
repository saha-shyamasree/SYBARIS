splitString<-function(str,length)
{
    strlen=nchar(str)
    qt=strlen%/%length
    rem=strlen%%length
    
    strVector=NULL
    if(qt>0)
    {
        idx <- 1:nchar(z)
        odds <- idx[(idx %% length) == 1]
        evens <- idx[(idx %% length) == 0]
        strVector=substring(z, odds, evens)
        #print(strVector)
        strVector[length(strVector)]=paste(substr(str,strlen-rem+1,strlen),paste(rep('_',(length-rem)),collapse=""),sep="")
    }
    else
    {
        strVector=rbind(strVector,paste(substr(str,strlen-rem+1,strlen),paste(rep('_',(length-rem)),collapse=""),sep=""))
    }
    return(strVector)
}



#strVec=splitString(as.character(all[1,13]),100)

#cn=colnames(presence)
seqQInd=13
protIdInd=1
samInd=2
length=100
#sink(file="NEXUS/blastedNexus.nex")
allSampleNames=sort(c("AF293","AF293_VKBR1","AF293_VKBR3","AF293_VKWH2","AF300-2","F17999","F18329","F18454","F20451","F21572","F21732","F21857","AF300","F18149","F4S1B","F18304","F20063","CF098","CF337","JN10","D17","F20140","M128","SF2S6","SF4S10","RSF2S8","AP65","SF1S5","SF1S6","SF2S9","SF3S1","SF3S10","CEA10","CEA10-2"))
sampleName=sort(unique(all[,samInd]))
for(i in 1:dim(presence)[1])
{
    ind=which(all$ProteinID==as.character(presence[i,protIdInd]))
    match=as.character(all[ind,seqQInd])
    seqQLen=unlist(lapply(match,function(x){return(nchar(x))}))
    maxInd=which(seqQLen==max(seqQLen))
    tab=NULL
    strVecs=NULL
    strVecs=lapply(match,splitString,length)
    maxSplit=max(unlist(lapply(strVecs,function(X){return(length(X))})))
    for(j in 1:maxSplit)
    {
        for(k in 1:length(allSampleNames))
        {
            if(allSampleNames[k]=="AF293")
            {
                tab=rbind(tab,c(allSampleNames[k],paste(rep("_",length),collapse="")))
            }
            else
            {
                sid=which(ind %in% which(allSampleNames[k]==all[,samInd]))
                
                #print(paste("strVecs:",length(strVecs)))
                if(length(sid)>0)
                {
                #print(sid)
                #print(ind)
                    if(length(strVecs[[sid]])>=j)
                    {
                        tab=rbind(tab,c(allSampleNames[k],strVecs[[sid]][j])) 
                    }
                    else
                    {
                        tab=rbind(tab,c(allSampleNames[k],paste(rep("_",length),collapse=""))) 
                    }
                }
                else
                {
                    tab=rbind(tab,c(allSampleNames[k],paste(rep("_",length),collapse="")))
                }
            }
        }
    }
    #print(t(tab))
    write.table(tab,file="NEXUS/blastNexus.nex",append=TRUE,sep="\t",row.names=FALSE,col.names=FALSE,quote=FALSE)
}
