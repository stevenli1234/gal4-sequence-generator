###############################################################
# generate_sequences.R
# -------------------------------------------------------------
# PFM-based generator: embed a motif generated from a position
# frequency matrix (PFM) into a random DNA background of any
# specified total length, and save sequences into ./output/.
#
# Folder structure (relative to this script):
#   ./pfms/   -> contains motif PFM .txt files
#   ./output/ -> generated sequences will be saved here
#
# HOW TO USE:
#   1) Set working directory to repo root:
#        setwd("path/to/gal4-sequence-generator")
#
#   2) Source the script:
#        source("generate_sequences.R")
#
#   3) Generate sequences. Examples:
#
#      # 100 sequences, each 323 bp, using motif M01681:
#      generate_sequences(len = 323, n = 100, motif_name = "M01681")
#
#      # 50 sequences, each 200 bp, using motif M07980:
#      generate_sequences(len = 200, n = 50, motif_name = "M07980")
#
# Output file (examples):
#   ./output/embedded_M01681_323bp_100seqs.txt
#
###############################################################

# -----------------------------
# 1. Helper: generate motif instance from PFM
# -----------------------------
generate_motif_from_pfm <- function(pfm) {
  bases <- c("A", "C", "G", "T")
  seq <- sapply(1:nrow(pfm), function(i) {
    sample(bases, size = 1, prob = pfm[i, ])
  })
  paste(seq, collapse = "")
}

# -----------------------------
# 2. Helper: generate random background of given length
# -----------------------------
generate_background <- function(len) {
  bases <- c("A", "C", "G", "T")
  paste(sample(bases, size = len, replace = TRUE), collapse = "")
}

# -----------------------------
# 3. Define motif files (GAL4 PFMs)
# -----------------------------
motif_files <- list(
  M01681 = "pfms/Gal4_M01681_3.00.txt",
  M07980 = "pfms/Gal4_M07980_3.00.txt",
  M07981 = "pfms/Gal4_M07981_3.00.txt",
  M07982 = "pfms/Gal4_M07982_3.00.txt",
  M09821 = "pfms/Gal4_M09821_3.00.txt",
  M12610 = "pfms/Gal4_M12610_3.00.txt",
  M12611 = "pfms/Gal4_M12611_3.00.txt"
)

load_pfm <- function(path) {
  df <- read.table(path, header = TRUE)
  as.matrix(df[, c("A", "C", "G", "T")])
}

# load all PFMs into a list
pfm_list <- lapply(motif_files, load_pfm)

# -----------------------------
# 4. Main function: generate_sequences()
# -----------------------------
generate_sequences <- function(len, n = 1, motif_name = "M01681") {
  if (!motif_name %in% names(pfm_list)) {
    stop("motif_name must be one of: ", paste(names(pfm_list), collapse = ", "))
  }
  
  pfm <- pfm_list[[motif_name]]
  motif_len <- nrow(pfm)
  
  if (len <= motif_len) {
    stop("len must be greater than motif length (", motif_len, " bp).")
  }
  
  # number of background bases
  bg_len <- len - motif_len
  
  # ensure output directory exists
  if (!dir.exists("output")) dir.create("output")
  
  set.seed(123)  # reproducible by default; you can change or remove this
  
  sequences <- character(n)
  
  for (i in seq_len(n)) {
    # generate background
    bg <- generate_background(bg_len)
    
    # generate motif instance
    motif_seq <- generate_motif_from_pfm(pfm)
    
    # choose random insertion position: 1..(bg_len + 1)
    insert_pos <- sample(1:(bg_len + 1), size = 1)
    
    # build final sequence
    seq_i <- paste0(
      substr(bg, 1, insert_pos - 1),
      motif_seq,
      substr(bg, insert_pos, nchar(bg))
    )
    
    sequences[i] <- seq_i
  }
  
  # construct output file name
  fname <- paste0(
    "output/embedded_",
    motif_name, "_",
    len, "bp_",
    n, "seqs.txt"
  )
  
  writeLines(sequences, fname)
  
  cat(
    "Generated", n, "sequence(s) of", len, "bp each, with motif",
    motif_name, "embedded.\nSaved to:", fname, "\n"
  )
  
  # also return sequences to the R session
  return(sequences)
}
