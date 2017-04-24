# -- Momocs -- #
# MomocsをGitHubから導入
devtools::install_github("vbonhomme/Momocs", build_vignettes= TRUE)
# Momocsのロード
library(Momocs)

library(MASS)

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

# データの読み込み
load("./data/vEarthware.RData")

# データの一覧を表示
panel(vEarthware, fac="type", dim = c(15,20))

# 楕円フーリエ解析
vEarthware.efc <- efourier(vEarthware, 30, norm = FALSE)

# 主成分分析
vEarthware.pca <- PCA(vEarthware.efc)
plot(vEarthware.pca, "type")
PCcontrib(vEarthware.pca)
plot3(vEarthware.pca, "type")
