
files=list.files(path=".",pattern=".*\.txt")

data=NULL
for(f in files)
{
  print(f)
  d=read.table(file=f,sep=" ")
  print(dim(d))
  data=rbind(data,d)
}
