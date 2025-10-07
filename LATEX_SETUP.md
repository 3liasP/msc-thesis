# LaTeX Compilation Setup Guide

This document explains the LaTeX compilation setup for the Tampere University thesis template. The setups is done by Elias Peltonen the author of this particular thesis using the template.

## Available Compilation Methods

### 1. VS Code LaTeX Workshop (Recommended for automatic building)

The LaTeX Workshop extension is configured with custom recipes for the thesis template:

- **"Tampere Thesis (Full Build)"**: Runs the complete compilation sequence (lualatex → makeindex → biber → lualatex → lualatex)
- **"Quick Build (lualatex only)"**: Runs only lualatex for quick previews

#### How to use:
1. Open any `.tex` file in the project
2. Use `Ctrl+Alt+B` (or Cmd+Alt+B on Mac) to build
3. Select "Tampere Thesis (Full Build)" from the recipe list
4. The extension will automatically build on save (configurable)

### 2. Shell Script (`compile.sh`)

A standalone shell script that runs the exact compilation sequence from the README.

#### How to use:
```bash
./compile.sh
```

### 3. VS Code Tasks

Integrated build tasks accessible via VS Code's task system:

- **"Compile Thesis (Shell Script)"**: Runs the compile.sh script
- **"Clean LaTeX Files"**: Removes all auxiliary files

#### How to use:
1. Press `Ctrl+Shift+P` (or Cmd+Shift+P on Mac)
2. Type "Tasks: Run Task"
3. Select the desired task

Or use the keyboard shortcut `Ctrl+Shift+B` to run the default build task.

## Configuration Details

### LaTeX Workshop Settings

The following settings have been configured in `.vscode/settings.json`:

- **Auto-build on save**: Enabled
- **PDF viewer**: Opens in VS Code tab
- **Auto-clean**: Removes auxiliary files after build
- **Error/warning display**: Enabled

### Compilation Tools

The setup includes the following LaTeX tools:
- `lualatex`: Main compiler (required for the template fonts)
- `makeindex`: Generates glossary files
- `biber`: Processes bibliography

## Troubleshooting

### If compilation fails:
1. Try the "Clean LaTeX Files" task first
2. Check that all required packages are installed
3. Ensure you're using LuaLaTeX (not PDFLaTeX)
4. Make sure you're compiling `main.tex` as the root document

### Important: Root File Configuration
The LaTeX Workshop extension has been configured to always compile `main.tex` regardless of which `.tex` file you have open. This is necessary because the thesis template requires a specific file structure where `main.tex` is the root document that includes all other files.

- **Magic comments** (`%!TEX root = main.tex`) have been added to key files
- **Custom build tools** are configured to target `main.tex` specifically
- **Default recipe** is set to "Tampere Thesis (Full Build)"

### If auto-build is too frequent:
You can disable auto-build by changing this setting in `.vscode/settings.json`:
```json
"latex-workshop.latex.autoBuild.run": "never"
```

Then build manually using `Ctrl+Alt+B`.
