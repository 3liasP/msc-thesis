# Master's Thesis: Integrating Resource-Augmented AI Chatbots into Custom-Deployed PLM Systems

**A Case Study on Sovelia Core**

This repository contains my Master's thesis project at Tampere University, Faculty of Information Technology and Communication Sciences. The thesis explores integrating a resource-augmented AI assistant (RAG chatbot) into Sovelia Core, a customizable PLM platform, to improve access to documentation and support by enabling the chatbot to answer questions using both vendor and customer materials.

This project is based on the official [Tampere University LaTeX thesis template](https://gitlab.com/tuni-official/thesis-templates/masters-thesis) and includes enhanced compilation automation for VS Code.

## 🚀 Compilation Setup

This project includes **automated compilation setup** for VS Code with LaTeX Workshop extension. Multiple compilation methods are available:

### **Automated Compilation (Recommended)**

- **VS Code + LaTeX Workshop**: Press `Ctrl+Alt+B` and select "Tampere Thesis (Full Build)"
- **Auto-build on save**: Enabled by default
- **Build tasks**: Use `Ctrl+Shift+B` to run build tasks

### **Manual Compilation**

The thesis uses both `biblatex` and `glossaries` packages, requiring this specific compilation sequence:

```sh
# Using the included shell script (recommended)
./compile.sh

# Or manually step by step
lualatex main.tex &&
makeindex -s main.ist -t main.glg -o main.gls main.glo &&
biber main &&
lualatex main.tex &&
lualatex main.tex
```

**Note:** The compiler `lualatex` must be used, as the template fonts are loaded with `lualatex`-specific functionality.

📋 **See [`LATEX_SETUP.md`](./LATEX_SETUP.md) for detailed compilation setup documentation.**

## 📖 About This Thesis

**Topic**: Integrating Resource-Augmented AI Chatbots into Custom-Deployed PLM Systems  
**Subtitle**: A Case Study on Sovelia Core  
**Author**: Elias Peltonen  
**Program**: Master's Programme in Information Technology, Software Engineering  
**Faculty**: Faculty of Information Technology and Communication Sciences, Tampere University

### Abstract

This thesis explores integrating a resource-augmented AI assistant (RAG chatbot) into Sovelia Core, a customizable PLM platform. The goal is to improve access to documentation and support by enabling the chatbot to answer questions using both vendor and customer materials, helping users find information and onboard more efficiently.

## 🛠️ Development Environment

This project is optimized for local development with VS Code:

### Prerequisites

- [TeX Live] LaTeX distribution (latest version)
- [VS Code] with [LaTeX Workshop] extension
- Git (for version control)

[TeX Live]: https://www.tug.org/texlive/
[VS Code]: https://code.visualstudio.com
[LaTeX Workshop]: https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop

### Quick Start

1. Clone this repository
2. Open the project in VS Code
3. Install the LaTeX Workshop extension (if not already installed)
4. Open `main.tex` and press `Ctrl+Alt+B` to build

## 📁 Project Structure

The thesis content is organized in the following folders:

- `frontmatter/` - Abstract, preface, table of contents
- `mainmatter/` - Main thesis chapters
- `appendices/` - Additional supporting material
- `publications/` - Related publications
- `images/` - Figures and images
- `code/` - Source code examples

Each folder contains an `index.tex` file that includes the individual content files.

## 🔧 Troubleshooting

### Required LaTeX Packages

If you encounter compilation errors, ensure you have the latest versions of:

- `pdfx`, `inputenc`, `babel`, `csquotes`, `hyperref`
- `fontenc`, `helvet`
- `geometry`, `fancyhdr`, `setspace`, `parskip`, `xcolor`, `titlesec`, `titletoc`
- `enumitem`, `graphicx`, `caption`, `listings`, `pdfpages`, `datetime2`
- `biblatex`, `glossaries`
- `accsupp`, `axessibility`, `pdfcomment`

### Clean Build

If compilation fails, try cleaning auxiliary files first:

```sh
# Use the VS Code task
Ctrl+Shift+P → "Tasks: Run Task" → "Clean LaTeX Files"

# Or manually
rm main.aux main.xmpdata main.blg main.bbl main.bcf main.*.log
```

## 📚 Template Information

This thesis is based on the official [Tampere University LaTeX thesis template](https://gitlab.com/tuni-official/thesis-templates/masters-thesis). The template structure allows for:

- **Modular content organization**: Content is organized in separate folders and files
- **Automatic formatting**: The `tauthesis.cls` class handles all formatting requirements
- **Easy maintenance**: Template updates can be applied without affecting content

### Content Organization Example:

```latex
% In mainmatter/index.tex - include your chapter files
\input{mainmatter/introduction.tex}
\input{mainmatter/literature-review.tex}
\input{mainmatter/methodology.tex}
\input{mainmatter/implementation.tex}
\input{mainmatter/results.tex}
\input{mainmatter/conclusion.tex}
```

**Note**: File paths are relative to `main.tex`. The modular structure means you typically won't need to modify `main.tex` or `tauthesis.cls`.

## 📄 Files and Configuration

### Key Files

- `main.tex` - Main document file (compile this)
- `metadata.tex` - Thesis metadata and configuration
- `compile.sh` - Automated compilation script
- `.vscode/settings.json` - VS Code LaTeX Workshop configuration
  - Includes also personal settings, e.g., for fonts and themes.
  - You can override these in your local VS Code settings.
- `.vscode/tasks.json` - Build and clean tasks
- `LATEX_SETUP.md` - Detailed compilation setup guide

### Original Template

This thesis is based on the official [Tampere University LaTeX template](https://gitlab.com/tuni-official/thesis-templates/masters-thesis).

For template-related issues or improvements, please visit the [original template repository](https://gitlab.com/tuni-official/thesis-templates/masters-thesis/-/issues).

## 🏗️ Build Status and Tools

- ✅ **VS Code LaTeX Workshop**: Configured and ready
- ✅ **Automated compilation**: Shell script and tasks available
- ✅ **Auto-build on save**: Enabled
- ✅ **PDF/A compliance**: Configured in document metadata
- ✅ **Bibliography**: BibLaTeX with IEEE style
- ✅ **Glossaries**: Automatic generation configured

---

_This README has been customized for this specific thesis project. For the original template documentation, see the template repository._
