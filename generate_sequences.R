###############################################
# GAL4 Synthetic Sequence Generator
# ---------------------------------------------
# This script loads several GAL4 position frequency 
# matrices (PFMs) from the ./pfms/ folder, generates 
# synthetic DNA binding sequences for each motif, and 
# saves them into the ./output/ folder.
#
# HOW TO USE:
# 1. Clone the repository:
#       git clone https://github.com/stevenli1234/gal4-sequence-generator.git
#
# 2. Open R or RStudio.
#
# 3. Set working directory to the project folder:
#       setwd("path/to/gal4-sequence-generator")
#
# 4. Run the script:
#       source("generate_sequences.R")
#
# OUTPUT:
# - Synthetic sequences will appear in the ./output/ directory.
# - 50,000 sequences generated per motif (modifiable).
#
###############################################

# -----------------------------
# Functions
# -----------------------------

generate_sequence_from_pfm <- function(pfm) {
  bases <- c("A", "C", "G", "T")
  seq <- sapply(1:nrow(pfm), function(i) {
    sample(bases, size = 1, prob = pfm[i, ])
  })
  paste(seq, collapse = "")
}

generate_sequences <- function(pfm, n = 50000) {
  replicate(n, generate_sequence_from_pfm(pfm))
}

# -----------------------------
# Load PFMs (relative paths)
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

pfm_list <- lapply(motif_files, load_pfm)

# -----------------------------
# Generate sequences
# -----------------------------

set.seed(123)

generated_sequences <- lapply(pfm_list, generate_sequences, n = 50000)

# -----------------------------
# Save output to ./output/
# -----------------------------

if (!dir.exists("output")) dir.create("output")

for (tf in names(generated_sequences)) {
  output_file <- paste0("output/synthetic_", tf, "_50000seqs.txt")
  writeLines(generated_sequences[[tf]], output_file)
}

# -----------------------------
# Print examples
# -----------------------------

for (tf in names(generated_sequences)) {
  cat("=== Example from", tf, "===\n")
  print(generated_sequences[[tf]][1:3])
  cat("\n")
}

###############################################
# END OF SCRIPT
###############################################