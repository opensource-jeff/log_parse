#!/bin/bash

# Usage: ./batch_parse.sh /path/to/folder /path/to/logparse.py

FOLDER="$1"
SCRIPT="$2"

if [[ -z "$FOLDER" || -z "$SCRIPT" ]]; then
    echo "Usage: $0 /path/to/folder /path/to/logparse.py"
    exit 1
fi

# Ensure folder exists
if [[ ! -d "$FOLDER" ]]; then
    echo "Error: Folder '$FOLDER' not found."
    exit 1
fi

# Ensure Python script exists
if [[ ! -f "$SCRIPT" ]]; then
    echo "Error: Parser script '$SCRIPT' not found."
    exit 1
fi

# Create output directory
OUTPUT_DIR="$FOLDER/parsed_csv"
mkdir -p "$OUTPUT_DIR"

# Loop through .txt files
for file in "$FOLDER"/*.txt; do
    # Skip if no files found
    [[ -e "$file" ]] || { echo "No .txt files found in $FOLDER."; exit 0; }

    base=$(basename "$file" .txt)
    output="$OUTPUT_DIR/${base}.csv"

    echo "Processing: $file → $output"
    python3 "$SCRIPT" "$file" "$output"
done

echo "✅ All files processed. CSVs saved in $OUTPUT_DIR
