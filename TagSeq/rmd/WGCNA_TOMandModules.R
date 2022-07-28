library(WGCNA)
library(flashClust)
options(stringsAsFactors=FALSE)
allowWGCNAThreads()

load("data4wgcna.RData")

s.th=9 # specify according to power results from previous section
# the following two lines take a long time, therefore are run in a cluster
# (if you don;t want to wait but proceed with exercise, skip to next section - we have results of this one recorded already)
adjacency = adjacency(datt, power = s.th,type="signed");
TOM = TOMsimilarity(adjacency,TOMType="signed");
dissTOM = 1-TOM
# Call the hierarchical clustering function
geneTree = flashClust(as.dist(dissTOM), method = "average");

# We like large modules, so we set the minimum module size relatively high:
minModuleSize = 30; 
dynamicMods = cutreeDynamic(dendro = geneTree, distM = dissTOM,
                            deepSplit = 2, pamRespectsDendro = FALSE,
                            minClusterSize = minModuleSize);
dynamicColors = labels2colors(dynamicMods)
table(dynamicColors)

# Calculate eigengenes
MEList = moduleEigengenes(datt, colors = dynamicColors)
MEs = MEList$eigengenes
# Calculate dissimilarity of module eigengenes
MEDiss = 1-cor(MEs);
METree = flashClust(as.dist(MEDiss), method = "average");

save(dynamicMods,dynamicColors,MEs,METree,geneTree,traits,datt,file="1stPassModules.RData")