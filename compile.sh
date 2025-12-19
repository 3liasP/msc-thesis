#!/bin/bash

# LaTeX compilation script for Tampere University thesis template
# This script compiles the main.tex file using the required sequence for biblatex and glossaries

set -e  # Exit on any error

# Parse options
VERBOSE=false
while getopts "v" opt; do
    case $opt in
        v) VERBOSE=true ;;
        *) echo "Usage: $0 [-v]"; exit 1 ;;
    esac
done

# Set interaction mode based on verbose flag
if [ "$VERBOSE" = true ]; then
    INTERACTION=""
else
    INTERACTION="-interaction=batchmode"
fi

echo "Starting LaTeX compilation..."

echo "=============================================="
echo "Step 1/5: First lualatex run..."
echo "=============================================="
lualatex $INTERACTION main.tex

echo "=============================================="
echo "Step 2/5: Generating glossary..."
echo "=============================================="
makeindex -s main.ist -t main.glg -o main.gls main.glo

echo "=============================================="
echo "Step 3/5: Running biber for bibliography..."
echo "=============================================="
biber main

echo "=============================================="
echo "Step 4/5: Second lualatex run..."
echo "=============================================="
lualatex $INTERACTION main.tex

echo "=============================================="
echo "Step 5/5: Final lualatex run..."
echo "=============================================="
lualatex $INTERACTION main.tex

echo "Compilation completed successfully! Check main.pdf"
