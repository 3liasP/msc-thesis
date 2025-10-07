#!/bin/bash

# LaTeX compilation script for Tampere University thesis template
# This script compiles the main.tex file using the required sequence for biblatex and glossaries

set -e  # Exit on any error

echo "Starting LaTeX compilation..."

echo "Step 1/5: First lualatex run..."
lualatex main.tex

echo "Step 2/5: Generating glossary..."
makeindex -s main.ist -t main.glg -o main.gls main.glo

echo "Step 3/5: Running biber for bibliography..."
biber main

echo "Step 4/5: Second lualatex run..."
lualatex main.tex

echo "Step 5/5: Final lualatex run..."
lualatex main.tex

echo "Compilation completed successfully! Check main.pdf"