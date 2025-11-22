# GAL4 Synthetic Sequence Generator

This script loads several GAL4 position frequency matrices (PFMs) and generates synthetic
DNA binding sequences according to their base probabilities.

## How to Use

1. Clone the repository:
   git clone https://github.com/stevenli1234/gal4-sequence-generator.git

2. Open RStudio or run R in the terminal.

3. Set your working directory to the project folder:
   setwd("path/to/gal4-sequence-generator")

   (No need to modify the script — it automatically loads the PFMs relative to the current directory.)

4. Run the script:
   source("generate_sequences.R")

5. The script will:
   - Load all GAL4 motif PFMs from the `pfms/` folder
   - Generate synthetic sequences (default = 50,000 per motif)
   - Save each output to: `output/synthetic_<motif>_50000seqs.txt`
   - Print example sequences to the console

## File Structure

```
gal4-sequence-generator/
│
├── generate_sequences.R      # Main script
├── pfms/                     # Folder containing PFM .txt files
│      ├── Gal4_M01681_3.00.txt
│      ├── Gal4_M07980_3.00.txt
│      └── ...
│
└── output/                   # Generated sequences will be saved here
```
