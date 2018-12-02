library(readr)
library(ggplot2)
library(magrittr)
library(dplyr)
library(stringr)
library(reshape2)
library(readxl)
library(tibble)

padina <- read_tsv("/home/nurgling/PhD/writing/review/Hero_qpcr-figs/Env-HG7-padina.tsv")
#needs space in first row otherwise deleted by column header
colnames(padina) <- c("site", "macroalgae", "Cell_number")
padina$site <- gsub('A', '', padina$site)
padina$site <- gsub('B', '', padina$site)
padina$site <- gsub('C', '', padina$site)
padina$site <- as.numeric(padina$site)

sargassum <- read_tsv("/home/nurgling/PhD/writing/review/Hero_qpcr-figs/Env-HG7-Saragassum.tsv")
#needs space in first row otherwise deleted by column header
colnames(sargassum) <- c("site", "macroalgae", "Cell_number")
sargassum$site <- gsub('A', '', sargassum$site)
sargassum$site <- gsub('B', '', sargassum$site)
sargassum$site <- gsub('C', '', sargassum$site)
sargassum$site <- as.numeric(sargassum$site)

chnoospora <- read_tsv("/home/nurgling/PhD/writing/review/Hero_qpcr-figs/Env-HG7-chnoospora.tsv")
#needs space in first row otherwise deleted by column header
colnames(chnoospora) <- c("site", "macroalgae", "Cell_number")
chnoospora$site <- gsub('A', '', chnoospora$site)
chnoospora$site <- gsub('B', '', chnoospora$site)
chnoospora$site <- gsub('C', '', chnoospora$site)
chnoospora$site <- as.numeric(chnoospora$site)

mixed <- read_tsv("/home/nurgling/PhD/writing/review/Hero_qpcr-figs/Env-HG7-mixed-macroalgae.tsv")
#needs space in first row otherwise deleted by column header
colnames(mixed) <- c("site", "macroalgae", "Cell_number")
mixed$site <- gsub('A', '', mixed$site)
mixed$site <- gsub('B', '', mixed$site)
mixed$site <- gsub('C', '', mixed$site)
mixed$site <- as.numeric(mixed$site)

#check vector tyoe w/ typeof(chnoospora$site)

pad_pl <- data.frame(x=padina$site, y=padina$Cell_number)
sar_pl <- data.frame(x=sargassum$site, y=sargassum$Cell_number)
chn_pl <- data.frame(x=chnoospora$site, y=chnoospora$Cell_number)
mix_pl <- data.frame(x=mixed$site, y=mixed$Cell_number)

env_pl <- rbind(pad_pl, sar_pl, chn_pl, mix_pl)
env_pl$dataset <- c(rep("Padina sp.", nrow(pad_pl)), rep("Sargassum sp.", nrow(sar_pl)), rep("Chnoospora sp.", nrow(chn_pl)), rep("Mixed macroalgae", nrow(mix_pl)))



ggplot(data=env_pl, aes(x=x, y=y, col=dataset)) + 
  geom_point(aes(shape= dataset), size = 3) + 
  scale_shape(solid=FALSE)+
  scale_x_continuous(breaks = round(seq(min(env_pl$x), max(env_pl$x), by = 1),1)) +
  scale_y_continuous(breaks = round(seq(min(env_pl$y), max(env_pl$y), by = 5),1)) +
  xlab("Sample sites") + ylab("Cell numbers per gram of macroalgae") +
  theme_bw()