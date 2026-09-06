#!/bin/bash

# ---------------------------------------------------------
# RNA-Seq Data Acquisition Pipeline
# ---------------------------------------------------------

STUDY_ID="SRP072687"

# 1. Create project directory and enter it
mkdir -p "$STUDY_ID"
cd "$STUDY_ID" || exit

# 2. Retrieve metadata & create sample list
# Fetch study information from NCBI SRA in TSV format
esearch -db sra -query "$STUDY_ID" | efetch -format runinfo > id.tsv

# Extract SRR accession codes (1st column), skipping the header line
awk -F',' 'NR>1 {print $1}' id.tsv > SRR_List.txt

# 3. Processing loop for each sample
while read -r SRR; do
    echo "=== Starting processing for sample: $SRR ==="
    
    mkdir -p "$SRR"
    
    # Download the raw .sra file
    prefetch "$SRR"
    
    # Convert the .sra file into FASTQ files
    fasterq-dump "$SRR" --outdir "$SRR"
    
    # Compress the resulting .fastq files to .gz
    gzip "$SRR"/*.fastq
    
    echo "=== Completed sample: $SRR ==="
    
done < SRR_List.txt

echo "=== Data acquisition completed successfully! ==="
