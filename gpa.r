library(geomorph)

# -- 作業ディレクトリの設定 -- #
# 現在の作業ディレクトリの確認
getwd()

# 作業ディレクトリが`設置した場所/CultEvolAppendix`になっていない場合
#
#「"作業ディレクトリ名"」に作業ディレクトリのパスを設定する
# Macでユーザー名「username」でホームディレクトリに設置した場合
# workingdir <- "/Users/username/CultEvolAppendix"
workingdir <- "/Users/username/CultEvolAppendix"
setwd(workingdir)

# -- データの読み込み -- #
face <- readland.tps("./data/face.tps", specID = "ID")
plotAllSpecimens(face, mean = FALSE, plot.param = list(pt.cex=0.5, mean.cex=0.8))

# -- Generalized Procrustes Analysis -- #
face.gpa <- gpagen(face, PrinAxes=FALSE, Proj = FALSE)
summary(face.gpa)

plotAllSpecimens(face.gpa$coords, plot.param = list(pt.cex=0.5, mean.cex=0.8))

# 主成分分析
PCA <- plotTangentSpace(face.gpa$coords, warpgrids = FALSE)
pvar <- (PCA$sdev^2)/(sum(PCA$sdev^2))
names(pvar) <- seq(1:length(pvar))
barplot(pvar, xlab= "Principal Components", ylab = "% Variance")

plotTangentSpace(face.gpa$coords, axis1 = 2, axis2 = 3, warpgrids = FALSE)

PCA <- plotTangentSpace(face.gpa$coords)
PC <- PCA$pc.scores[,1]
preds <- shape.predictor(face.gpa$coords, x= PC, Intercept = FALSE,
                         pred1 = 0.05, pred2 = -0.05)
plotRefToTarget(ref, preds$pred1)
plotRefToTarget(ref, preds$pred2)


# 薄板スプライン法
ref<-mshape(face.gpa$coords)
plotRefToTarget(ref,face.gpa$coords[,,3])
plotRefToTarget(ref,face.gpa$coords[,,1], method = "vector", mag = 3)

par(mfrow=c(3,3)) 
for(i in 1:9){
  plotRefToTarget(ref,face.gpa$coords[,,i],mai=c(0,0))
}


tpsgrid(face.gpa$mshape,face.gpa$rotated[,,2])
