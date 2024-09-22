#!/bin/bash

# Function to display help
show_help() {
    echo "Usage: ./backup.sh [FILE/DIRECTORY] [ALGORITHM] [OUTPUT FILE]"
    echo "  FILE/DIRECTORY - the file or directory to backup"
    echo "  ALGORITHM - compression algorithm to use (none, gzip, bzip2)"
    echo "  OUTPUT FILE - the output archive file name"
}

# Check for help argument
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

# Check if the required number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Error: Missing required arguments." >&2
    echo "Use -h or --help for usage information." >&2
    exit 1
fi

ITEM=$1
ALGORITHM=$2
OUTPUT_FILE=$3

# Check if the file or directory exists
if [ ! -e "$ITEM" ]; then
    echo "Error: File or directory does not exist." >&2
    exit 1
fi

# Create a tar file and compress based on the algorithm
case "$ALGORITHM" in
    "none")
        tar -cf "$OUTPUT_FILE.tar" "$ITEM" >/dev/null 2>>error.log
        ;;
    "gzip")
        tar -czf "$OUTPUT_FILE.tar.gz" "$ITEM" >/dev/null 2>>error.log
        ;;
    "bzip2")
        tar -cjf "$OUTPUT_FILE.tar.bz2" "$ITEM" >/dev/null 2>>error.log
        ;;
    *)
        echo "Error: Unsupported compression algorithm." >&2
        exit 1
        ;;
esac

# Encrypt the resulting archive
openssl enc -aes-256-cbc -salt -in "$OUTPUT_FILE".* -out "$OUTPUT_FILE".enc >/dev/null 2>>error.log

echo "Backup completed successfully. Encrypted archive: $OUTPUT_FILE.enc"
