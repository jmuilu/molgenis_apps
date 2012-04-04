ReadGwaResult <- function(gwas.obj,output.file) {
    GWA.result          <- read.table(file=output.file)
    if (ncol(gwas.obj$genes)!=0) {
        GWA.result          <- cbind(GWA.result,gwas.obj$map$gene1,gwas.obj$map$gene2)
        names(GWA.result)   <- c("marker","stat","pvalue","gene1","gene2")
    } else {
        names(GWA.result)   <- c("marker","stat","pvalue")
    }
    GWA.result[GWA.result[,3]==-1,3]  <- 1
GWA.result
}
