

rownames(binary_nexus)=binary_nexus[,1]
binary_nexus=binary_nexus[,-1]

final=NULL
nex.af293=binary_nexus[,6:39]
nex.af293.final=nex.af293[min(which(nex.af293[,1]==1)):max(which(nex.af293[,1]==1)),]

nex.f4s9a_ref=binary_nexus[,1:2]
nex.f4s9a_ref.final=nex.f4s9a_ref[min(which(nex.f4s9a_ref[,1]==1)):max(which(nex.f4s9a_ref[,1]==1)),]

nex.f8226_ref=binary_nexus[,3:5]
nex.f8226_ref.final=nex.f8226_ref[min(which(nex.f8226_ref[,1]==1)):max(which(nex.f8226_ref[,1]==1)),]

nex.a1163=binary_nexus[,40:42]
nex.a1163.final=nex.a1163[min(which(nex.a1163[,1]==1)):max(which(nex.a1163[,1]==1)),]
ortholog=ortholog[!duplicated(ortholog[,"Ensembl.Protein.ID"]),]

ortho_a1163=ortholog[,c(1,2,7)]
ortho_a1163_final=ortho_a1163[which(ortho_a1163[,2]=="ortholog_one2one"),]

ortho_f4s9a=ortholog[,c(5,6,7)]
ortho_f4s9a_final=ortho_f4s9a[which(ortho_f4s9a[,2]=="ortholog_one2one"),]

ortho_f8226=ortholog[,c(3,4,7)]
ortho_f8226_final=ortho_f8226[which(ortho_f8226[,2]=="ortholog_one2one"),]

for(i in 1:dim(nex.af293.final)[1])
{
    pid=rownames(nex.af293.final[i,])
    print(paste("i:",i))
    print(pid)
    newrow=NULL
    
    ortho_pid_2=as.character(ortho_f4s9a_final[which(ortho_f4s9a_final[,"Ensembl.Protein.ID"]==pid),1])
    #print(paste("ortho_pid_2",ortho_pid_2))
    if(length(ortho_pid_2)!=0)
    {
     
        newrow=nex.f4s9a_ref.final[ortho_pid_2,]
        nex.f4s9a_ref.final=nex.f4s9a_ref.final[!rownames(nex.f4s9a_ref.final) %in% ortho_pid_2,]
        #print("ortho_pid_2 exists")
    }
    else
    {
        
        newrow=matrix(0,ncol=dim(nex.f4s9a_ref.final)[2])
        #print("ortho_pid_2 does not exists")
    }
    
    ortho_pid_3=as.character(ortho_f8226_final[which(ortho_f8226_final[,"Ensembl.Protein.ID"]==pid),1])
    #print(paste("ortho_pid_3",ortho_pid_3))
    if(length(ortho_pid_3)!=0)
    {
        
        newrow=cbind(newrow,nex.f8226_ref.final[ortho_pid_3,])
        nex.f8226_ref.final=nex.f8226_ref.final[!rownames(nex.f8226_ref.final) %in% ortho_pid_3,]
        #print("ortho_pid_3 exists")
    }
    else
    {
        
        newrow=cbind(newrow,matrix(0,ncol=dim(nex.f8226_ref.final)[2]))
        #print("ortho_pid_2 does not exists")
    }
    
    newrow=cbind(newrow,nex.af293.final[i,])
    #print("nex.af293 added")
    ortho_pid=as.character(ortho_a1163_final[which(ortho_a1163_final[,"Ensembl.Protein.ID"]==pid),1])
    #print(paste("ortho_pid",ortho_pid))
    if(length(ortho_pid)!=0)
    {
        
        newrow=cbind(newrow,nex.a1163.final[ortho_pid,])
        nex.a1163.final=nex.a1163.final[!rownames(nex.a1163.final) %in% ortho_pid,]
        #print("ortho_pid exists")
    }
    else
    {
        newrow=cbind(newrow,matrix(0,ncol=dim(nex.a1163.final)[2]))
        #print("ortho_pid does not exists")
    }
    colnames(newrow)=colnames(binary_nexus)
    #print("before rbind with final")
    #print(final)
    #print("newrow")
    #print(newrow)
    final=rbind(final,newrow)
    print(paste("dim of final:",dim(final)))
    #print("after rbind with final")
}

final=rbind(final,binary_nexus[(max(which(nex.a1163[,1]==1))+1):dim(binary_nexus)[1],])
write.csv(final,file="orthologous_only_orthologs.csv",quote=FALSE)

if(dim(nex.f4s9a_ref.final)[1]>0)
{
    fill=matrix(0,nrow=dim(nex.f4s9a_ref.final)[1],ncol=(dim(nex.f8226_ref.final)[2]+dim(nex.af293.final)[2]+dim(nex.a1163.final)[2]))
    nex.f4s9a_ref.rest=cbind(nex.f4s9a_ref.final,fill)
    colnames(nex.f4s9a_ref.rest)=colnames(binary_nexus)
    final=rbind(final,nex.f4s9a_ref.rest)
}
if(dim(nex.f8226_ref.final)[1]>0)
{
    nex.f8226_ref.rest=matrix(0,nrow=dim(nex.f8226_ref.final)[1],ncol=dim(nex.f4s9a_ref.final)[2])
    nex.f8226_ref.rest=cbind(nex.f8226_ref.rest,nex.f8226_ref.final)
    nex.f8226_ref.rest=cbind(nex.f8226_ref.rest,matrix(0,nrow=dim(nex.f8226_ref.final)[1],ncol=dim(nex.af293.final)[2]))
    nex.f8226_ref.rest=cbind(nex.f8226_ref.rest,matrix(0,nrow=dim(nex.f8226_ref.final)[1],ncol=dim(nex.a1163.final)[2]))
    colnames(nex.f8226_ref.rest)=colnames(binary_nexus)
    final=rbind(final,nex.f8226_ref.rest)
}

if(dim(nex.a1163.final)[1]>0)
{
    fill=matrix(0,nrow=dim(nex.a1163.final)[1],ncol=(dim(nex.f4s9a_ref.final)[2]+dim(nex.f8226_ref.final)[2]+dim(nex.af293.final)[2]))
    nex.a1163.rest=cbind(fill,matrix(0,nrow=dim(nex.a1163.final)[1],ncol=dim(nex.a1163.final)[2]))
    colnames(nex.a1163.rest)=colnames(binary_nexus)
    final=rbind(final,nex.a1163.rest)
}


#final=rbind(final,binary_nexus[(max(which(nex.a1163[,1]==1))+1):dim(binary_nexus)[1],])
write.csv(file="orthologous.csv",quote=FALSE)
