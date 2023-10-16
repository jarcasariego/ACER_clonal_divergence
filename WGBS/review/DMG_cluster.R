
sub_meth_table <- readRDS("gene_meth_table.RData")

# create data frame to stored results
results <- data.frame()

# Sub-divide meth dataset
gs <- unique(sub_meth_table$gene)
gs_1 <- gs[c(1:10845)]
gs_2 <- gs[c(10846:21690)]
gs_3 <- gs[c(21691:32535)]

# set multicore paramters 
cores=detectCores()
cl <- parallel::makeCluster(32, setup_strategy = "sequential")
registerDoParallel(cl)
#first subset the unique dataframes and second run the GLMs
results <- foreach(i=1:length(gs_1), .combine=rbind) %dopar% {
  #subset the dataframe gene by gene
  sub_meth_table1 <- subset(sub_meth_table, gene ==gs_1[i])
  
  # fit glm position model
  fit <- glm(matrix(c(meth, unmeth), ncol=2) ~ site, 
             data=sub_meth_table1, family=binomial)
  a <- anova(fit, test="Chisq")
  
  # capture summary stats to data frame
  df <- data.frame(gene = sub_meth_table1[1,7],
                   pval.site = a$`Pr(>Chi)`[2],
                   stringsAsFactors = F)
}

#stop cluster
stopCluster(cl)

cores=detectCores()
cl <- parallel::makeCluster(32, setup_strategy = "sequential")
registerDoParallel(cl)
#first subset the unique dataframes and second run the GLMs
results2 <- foreach(i=1:length(gs_2), .combine=rbind) %dopar% {
  #subset the dataframe gene by gene
  sub_meth_table1 <- subset(sub_meth_table, gene ==gs_2[i])
  
  # fit glm position model
  fit <- glm(matrix(c(meth, unmeth), ncol=2) ~ site, 
             data=sub_meth_table1, family=binomial)
  a <- anova(fit, test="Chisq")
  
  # capture summary stats to data frame
  df <- data.frame(gene = sub_meth_table1[1,7],
                   pval.site = a$`Pr(>Chi)`[2],
                   stringsAsFactors = F)
}

#stop cluster
stopCluster(cl)

cores=detectCores()
cl <- parallel::makeCluster(32, setup_strategy = "sequential")
registerDoParallel(cl)
#first subset the unique dataframes and second run the GLMs
results3 <- foreach(i=1:length(gs_3), .combine=rbind) %dopar% {
  #subset the dataframe gene by gene
  sub_meth_table1 <- subset(sub_meth_table, gene ==gs_3[i])
  
  # fit glm position model
  fit <- glm(matrix(c(meth, unmeth), ncol=2) ~ site, 
             data=sub_meth_table1, family=binomial)
  a <- anova(fit, test="Chisq")
  
  # capture summary stats to data frame
  df <- data.frame(gene = sub_meth_table1[1,7],
                   pval.site = a$`Pr(>Chi)`[2],
                   stringsAsFactors = F)
}

#stop cluster
stopCluster(cl)
# An error will be generated here for contrasts. 
#This potential for contrasts (interactions) is included in the case one wants to examine the role of position of CpG within a gene
#Error in `contrasts<-`(`*tmp*`, value = contr.funs[1 + isOF[nn]]) : contrasts can be applied only to factors with 2 or more levels
#Continuing the analysis from results line will generate the results in the absence of the contrast (interaction).
results <- rbind(results, results2)
results <- rbind(results, results3)
results[is.na(results)] <- 0
results$adj.pval <- p.adjust(results$pval.site, method='BH')

saveRDS(results, file = "gene_meth_glm_results.RData")