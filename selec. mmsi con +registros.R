####### SELECCIONAR DE LOS MMSI REPETIDOS (mmsi_unicos_cabrera_info), LOS QUE TIENEN >Nº REGISTROS
allcomb <- read.csv("D:\\SML\\PNMT_CABRERA\\mmsi_unicos_cabrera_info.csv")

### Select combinations with unique MMSI (uni.mmsi)
uni.mmsi <- allcomb %>%
  group_by(mmsi) %>%
  filter(n()==1)

### Select combinations with duplicated MMSI (dup.mmsi)
dup.mmsi <- allcomb %>%
  group_by(mmsi) %>%
  filter(n()>1)
View(dup.mmsi)

### Select among duplicates based on frequency of observation (sel.dup.mmsi)
sel.dup.mmsi <- dup.mmsi %>%
  group_by(mmsi) %>%
  filter(msgCount==max(msgCount)) %>%
  slice(1)  # if there are more than one register with max(n), select the first one
View(sel.dup.mmsi)

### Combine uni.mmsi & sel.dup.mmsi
static <- rbind(uni.mmsi, sel.dup.mmsi )

### Select discarded duplicates
discards <- dup.mmsi %>%
  group_by(mmsi) %>%
  filter(msgCount!=max(msgCount))

## Export files -------------------
wd <- setwd(("D:\\SML\\PNMT_CABRERA"))
# export files
write.csv(static, 'D:\\SML\\PNMT_CABRERA\\mmsi_selec_cabrera.csv', row.names=FALSE)  # selected static data
write.csv(discards, 'D:\\SML\\PNMT_CABRERA\\discards_cabrera.csv', row.names=FALSE)  # discarded data
