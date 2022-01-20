# read .cel files, perform RMA, fit linear model, perform eBayes, annotate with gene information.

library(affy)
library(limma)
library(hgu133plus2.db)
library(AnnotationDbi)
library(dplyr)

# set working directory
setwd("//dnausers/amyn/Personal/Lewis/BIOL 59000 Data Science Project for Life Scientists/Homework/R/Pancreas")

# read .CEL files
Data <- ReadAffy()


# perform RMA. Background correction, log2 transformation, quantile normalization
DataRMA <- rma(Data)

# create design matrix to compare between tumor and normal
group=c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)

design <- model.matrix(~-1 + factor(group))
design
colnames(design) <- c("normal","tumor")
contrast <- makeContrasts(tumor - normal, levels = design)

# fits linear model using expression data and design matrix
fit <- lmFit(DataRMA, design)
fit2 <- contrasts.fit(fit, contrast)

# calculates logFc, t-statistics
fit2 <- eBayes(fit2)

# results table
res <- topTable(fit2, number=Inf, adjust.method="none")

# save differential expression data
write.table(res,"dif_exp.txt",sep="\t", col.names = NA, row.names = TRUE)

# add in PROBEID to column A header for merge
diff <- read.delim("dif_exp.txt", header=TRUE)
names(diff)[1] <- "PROBEID"
head(diff)

vector_diff = diff[['PROBEID']]
head(vector_diff)

geneID <- AnnotationDbi::select(hgu133plus2.db,
                                       keys = (vector_diff),
                                       columns = c("SYMBOL", "GENENAME"),
                                       keytype = "PROBEID")

write.csv(geneID, file = "gene_ID.csv", row.names = FALSE)

# join expression data and gene annotation
joined <- left_join(diff, geneID, 
                           by = c("PROBEID"))

write.csv(joined, file = "pancreas_final.csv", row.names = FALSE)

