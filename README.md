# GAL4 PFM-Based Sequence Generator  
Generate synthetic DNA sequences of any length with embedded transcription factor motifs.

This repository contains a portable, reproducible R workflow for generating synthetic promoter-like DNA sequences that embed 
GAL4 transcription factor motifs sampled from their position frequency matrices (PFMs).  
This project is part of work done in the Brent Lab.

---

## 📁 Repository Structure
```
gal4-sequence-generator/
│
├── generate_sequences.R # Main generator (PFM motif embedded in background)
│
├── pfms/ # GAL4 motif PFM files
│ ├── Gal4_M01681_3.00.txt
│ ├── Gal4_M07980_3.00.txt
│ ├── Gal4_M07981_3.00.txt
│ ├── Gal4_M07982_3.00.txt
│ ├── Gal4_M09821_3.00.txt
│ ├── Gal4_M12610_3.00.txt
│ └── Gal4_M12611_3.00.txt
│
└── output/ # Generated sequences appear here
├── embedded_M01681_323bp_100seqs.txt
├── embedded_M07980_500bp_50seqs.txt
└── ...
```
---

## 🎯 Purpose

This tool generates synthetic DNA sequences where:

- You specify the **total DNA sequence length** (e.g., 323 bp)
- You select a **GAL4 motif PFM**
- The script **samples a motif instance** based on its probability model
- It embeds the motif in a **random DNA background**
- The motif position is chosen **randomly** within the sequence
- You can generate **one or thousands** of sequences at once

This corresponds to the experimental logic described by Michael:
> “Generate a long promoter sequence that includes an instance of the binding motif.”

---

## 🚀 Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/stevenli1234/gal4-sequence-generator.git
cd gal4-sequence-generator
2. Open R or RStudio and set the working directory
r
Copy code
setwd("path/to/gal4-sequence-generator")
3. Run the generator
r
Copy code
source("generate_sequences.R")

# Example: generate 100 sequences, each 323 bp, using motif M01681
generate_sequences(len = 323, n = 100, motif_name = "M01681")
This produces:

bash
Copy code
output/embedded_M01681_323bp_100seqs.txt
🔧 Function Usage
generate_sequences(len, n = 1, motif_name = "M01681")
Argument	Description
len	Total sequence length (e.g., 323 bp)
n	Number of sequences to generate
motif_name	One of the motif IDs: M01681, M07980, M07981, M07982, M09821, M12610, M12611

✔ Example 1 — Generate one 500 bp sequence:

r
Copy code
generate_sequences(len = 500)
✔ Example 2 — Generate ten 323 bp sequences using motif M07980:

r
Copy code
generate_sequences(len = 323, n = 10, motif_name = "M07980")
✔ Example 3 — Generate 1,000 sequences of 200 bp each:

generate_sequences(len = 200, n = 1000, motif_name = "M12611")
📊 How It Works
Load the selected motif PFM from the pfms/ folder

Generate a motif instance based on the nucleotide probabilities in the PFM

Create a random background DNA sequence

Choose a random insertion position

Embed the motif into the background sequence

Save all generated sequences into ./output/

This allows you to explore:

Promoter sequence design

TF occupancy models

Weak/strong motif variants

Motif spacing effects

Multi-TF modeling (future extension)

🔬 Extending the Pipeline
Planned / optional enhancements:

Support for MSN2 PFMs

Embedding multiple motifs per sequence

Fixed or variable motif positions

GC-balanced background sequences

Avoiding homopolymer runs

Parallel processing for very large libraries

Sequence logo comparison of PFMs vs sampled motifs

Open an issue or contribute if you would like to help.

📄 License
MIT License. Free for academic and commercial use.

👤 Author
Steven Li
Brent Lab
Washington University in St. Louis

If used in research, please cite this repository.
