### ------------------------------
### 1. Load Required Functions
### ------------------------------

generate_sequence_from_pfm <- function(pfm) {
  bases <- c("A", "C", "G", "T")
  seq <- sapply(1:nrow(pfm), function(i) {
    sample(bases, size = 1, prob = pfm[i, ])
  })
  paste(seq, collapse = "")
}

generate_sequences <- function(pfm, n = 100) {
  replicate(n, generate_sequence_from_pfm(pfm))
}

### ------------------------------
### 2. Load All 7 Motif Files
### ------------------------------

motif_files <- list(
  M01681 = "~/BrentLab/Library/Forward/Gal4_M01681_3.00.txt",
  M07980 = "~/BrentLab/Library/Forward/Gal4_M07980_3.00.txt",
  M07981 = "~/BrentLab/Library/Forward/Gal4_M07981_3.00.txt",
  M07982 = "~/BrentLab/Library/Forward/Gal4_M07982_3.00.txt",
  M09821 = "~/BrentLab/Library/Forward/Gal4_M09821_3.00.txt",
  M12610 = "~/BrentLab/Library/Forward/Gal4_M12610_3.00.txt",
  M12611 = "~/BrentLab/Library/Forward/Gal4_M12611_3.00.txt"
)

load_pfm <- function(path) {
  df <- read.table(path, header = TRUE)
  as.matrix(df[, c("A", "C", "G", "T")])
}

pfm_list <- lapply(motif_files, load_pfm)

### ------------------------------
### 3. Generate Sequences
### ------------------------------

set.seed(123)

generated_sequences <- lapply(pfm_list, generate_sequences, n = 50)

### ------------------------------
### 4. Print Example Outputs
### ------------------------------

for (tf in names(generated_sequences)) {
  cat("=== Motif", tf, "===\n")
  print(generated_sequences[[tf]][1:5])
  cat("\n")
}

### ------------------------------
### 5. (Optional) Save Each Set
### ------------------------------
# for (tf in names(generated_sequences)) {
#   writeLines(generated_sequences[[tf]],
#              paste0("generated_", tf, "_seqs.txt"))
# }
