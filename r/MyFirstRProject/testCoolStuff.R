# First scripts

pth = getwd()
fin = 'beef.txt'
str = sprintf('%s/%s', pth, fin)
beefdata <- read.table(str, header = TRUE, stringsAsFactors = FALSE, comment.char = '%')
beefdata
