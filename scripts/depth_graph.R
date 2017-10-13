#!/usr/bin/env Rscript

source("http://bioconductor.org/biocLite.R")
biocLite("Rsamtools")

library(optparse)
library(ggplot2)
library(Rsamtools)

args = commandArgs(trailingOnly=TRUE)

option_list = list(
  make_option(
    c("-c", "--coverage"),
    default = "",
    type = "character",
    help = "Coverage file",
    metavar = "character"
  ),
  make_option(
    c("-b", "--bam"),
    default = "",
    type = "character",
    help = "Bam file",
    metavar = "character"
  ),
  make_option(
    c("-d", "--directory"),
    default = "",
    type = "character",
    help = "Input Directory",
    metavar = "character"
  ),
  make_option(
    c("-t", "--title"),
    default = "",
    type = "character",
    help = "Input Directory",
    metavar = "character"
  )
);

opt_parser = OptionParser(option_list = option_list);
opt        = parse_args(opt_parser);
coverage   = opt$coverage
bam_file   = opt$bam
in_dir     = opt$directory
title      = sub(",", "-", opt$title)

setwd(in_dir)

bamcoverage <- function (bamfile) {
  # read in the bam file
  bam <- scanBam(bamfile)[[1]] # the result comes in nested lists
  # filter reads without match position
  ind <- ! is.na(bam$pos)
  ## remove non-matches, they are not relevant to us
  bam <- lapply(bam, function(x) x[ind])
  ranges <- IRanges(start=bam$pos, width=bam$qwidth, names=make.names(bam$qname, unique=TRUE))
  ## names of the bam data frame:
  ## "qname"  "flag"   "rname"  "strand" "pos"    "qwidth"
  ## "mapq"   "cigar"  "mrnm"   "mpos"   "isize"  "seq"    "qual"
  ## construc: genomic ranges object containing all reads
  ranges <- GRanges(seqnames=Rle(bam$rname), ranges=ranges, strand=Rle(bam$strand), flag=bam$flag, readid=bam$rname )
  ## returns a coverage for each reference sequence (aka. chromosome) in the bam file
  return (mean(coverage(ranges)))      
}

avg.cov = bamcoverage(bam_file)

df <- read.delim(coverage)

names(df) <- c("seq", "Position", "Depth")

p1 <- ggplot(df, aes(x=Position, y=Depth)) + geom_area()
p1 <- p1 + ggtitle(paste(title, "Average Coverage:", round(avg.cov, digits = 2))) + theme(plot.title = element_text(hjust = 0.5, size = 12), panel.background = element_rect(fill="white", colour="gray53"))
p1 <- p1 + scale_fill_manual(values=cbPalette) + guides(fill=FALSE) + theme(plot.title = element_text(hjust = 0.5), panel.background = element_rect(fill="white", colour="gray53"), text = element_text(size=14))
p1
ggsave(paste0(title,".png"))

