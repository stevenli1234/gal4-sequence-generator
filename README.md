# GAL4 PFM-Based Sequence Generator  
Generate synthetic DNA sequences of any length with embedded transcription factor motifs.

This repository includes a reproducible R workflow for generating synthetic promoter-like sequences using GAL4 
transcription factor binding site models (PFMs).  
The generator builds a random DNA background of user-defined length and embeds a sampled motif instance inside, matching the design logic for TF occupancy experiments.

---

## 📁 Repository Structure

```
gal4-sequence-generator/
│
├── generate_sequences.R        # Main generator script
│
├── pfms/                       # GAL4 motif PFM files
│   ├── Gal4_M01681_3.00.txt
│   ├── Gal4_M07980_3.00.txt
│   ├── Gal4_M07981_3.00.txt
│   ├── Gal4_M07982_3.00.txt
│   ├── Gal4_M09821_3.00.txt
│   ├── Gal4_M12610_3.00.txt
│   └── Gal4_M12611_3.00.txt
│
└── output/                     # Generated sequences will appear here
    ├── embedded_M01681_323bp_100seqs.txt
    ├── embedded_M07980_500bp_50seqs.txt
    └── ...
```

---

## 🎯 Purpose

This tool generates DNA sequences with the following structure:

- **Total length** is chosen by the user (e.g., 323 bp)
- **One GAL4 motif** is sampled from its probability frequency matrix (PFM)
- The motif is **inserted at a random valid position**
- The remaining positions are filled with **random background DNA**
- Output sequences are saved to the `/output/` folder

This matches Method 2 described in the project discussion:
> Generate a promoter-like sequence with the transcription factor motif embedded in random DNA.

---

## 🚀 Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/stevenli1234/gal4-sequence-generator.git
cd gal4-sequence-generator
```

### 2. Open R or RStudio and set the working directory

```r
setwd("path/to/gal4-sequence-generator")
```

### 3. Load the script

```r
source("generate_sequences.R")
```

### 4. Generate sequences

```r
generate_sequences(len = 323, n = 100, motif_name = "M01681")
```

This will create:

```
output/embedded_M01681_323bp_100seqs.txt
```

---

## 🔧 Function Usage

### **`generate_sequences(len, n = 1, motif_name = "M01681")`**

| Argument     | Description |
|--------------|-------------|
| `len`        | Total sequence length (must exceed motif length) |
| `n`          | Number of sequences to generate |
| `motif_name` | One of: M01681, M07980, M07981, M07982, M09821, M12610, M12611 |

### Examples

Generate one 500 bp sequence:

```r
generate_sequences(len = 500)
```

Generate ten 323 bp sequences with motif M07980:

```r
generate_sequences(len = 323, n = 10, motif_name = "M07980")
```

Generate 1,000 200 bp sequences:

```r
generate_sequences(len = 200, n = 1000, motif_name = "M12611")
```

---

## 📊 How It Works

1. Load the selected PFM from `pfms/`
2. Sample a motif instance according to its probability model
3. Compute:
   ```
   background_length = len - motif_length
   ```
4. Generate random background DNA
5. Choose a random motif insertion index
6. Embed motif → background → final sequence
7. Save to `/output/embedded_<motif>_<len>bp_<n>seqs.txt`

---

## 🔬 Future Extensions

This generator can be extended to support:

- MSN2 or other TF PFMs  
- Multiple motifs per sequence  
- Position-controlled embedding  
- GC-balanced background  
- Avoiding homopolymers  
- Multi-core optimization for millions of sequences  
- Sequence logo validation plots  

---

## 👤 Author

Steven Li  
Brent Lab  
Washington University in St. Louis

If used in research, please cite this repository.
