# RNA-Seq Data Acquisition Pipeline 🧬

## Description
This repository contains a Bash pipeline developed as part of my Master's thesis. It automates the retrieval, conversion, and organization of raw RNA-Seq data from the NCBI Sequence Read Archive (SRA).

## Workflow
The script performs the following automated steps:
1. **Metadata Retrieval:** Uses Entrez Direct (`esearch` / `efetch`) to download the study's metadata (`id.tsv`).
2. **Sample Identification:** Parses the metadata using `awk` to extract unique SRR accession numbers.
3. **Data Download:** Uses `prefetch` to download raw `.sra` files.
4. **Data Conversion:** Uses `fasterq-dump` to extract raw reads into `.fastq` format.
5. **Storage Optimization:** Compresses the output into `.fastq.gz` format using `gzip` to save server space.

## Prerequisites
To run this script, the following tools must be installed on your Linux server:
* [SRA Toolkit](https://github.com/ncbi/sra-tools)
* [Entrez Direct (edirect)](https://www.ncbi.nlm.nih.gov/books/NBK179288/)

## Usage
To execute the pipeline, simply run the bash script in your terminal:
```bash
bash data_acquisition.sh
