# Copilot Instructions for MSc Thesis Writing

## Project Overview

LaTeX thesis on **integrating a RAG chatbot into Sovelia Core**, an on-premise PLM platform for CAD/ERP workflows.

## Research Context

**Problem**: Knowledge silos in Sovelia documentation (Help files, release notes, SOPs) hinder onboarding and support.

**Solution**: RAG-based AI assistant for contextual query responses from vendor and customer documentation.

**Research Questions**:

1. What RAG architecture fits Sovelia Core's on-prem, PostgreSQL environment and data governance needs?
2. How to engineer reliable documentation pipelines (parse → chunk → embed → retire)?
3. Which risks (hallucinations, stale context, access control) need mitigation, and what works?

**Methodology**: Design Science / Case Study with iterative build-measure-learn cycles in live environment.

## Writing Assistance Focus

1. **Academic Writing**: Structure arguments logically, use precise terminology, maintain formal tone
2. **Technical Content**: RAG architectures, vector databases, embeddings, on-premise deployment, data governance, documentation pipelines, AI safety
3. **Domain Knowledge**: PLM systems, CAD/ERP integration, enterprise software patterns, knowledge management
4. **Research Methodology**: Design Science Research, case study approach, build-measure-learn cycles, evaluation strategies

### Chapter Focus

- **Introduction**: PLM context, business impact, AI trends in enterprise software
- **Literature Review**: RAG systems, vector DBs, enterprise AI, PLM/ERP, on-prem vs. cloud
- **Methodology**: Design Science Research, case study boundaries, iteration cycles
- **Design & Implementation**: Architecture, pipeline, embeddings, access control, Sovelia integration
- **Evaluation**: User feedback, performance metrics, risk mitigation, qualitative insights
- **Conclusion**: Practical and theoretical contributions, limitations, future work

### Style

- Academic but accessible (precise, minimal jargon)
- Practitioner-oriented (balance theory and implementation)
- Evidence-based (data, literature, empirics)
- Reflective (acknowledge limitations and trade-offs)

### LaTeX Conventions

- `\textbf{}` for emphasis, `\emph{}` for first-use terms
- `\parencite{}` for citations (`mainmatter/references.bib`)
- `\ref{}` for cross-references

### Key Acronyms

RAG (Retrieval-Augmented Generation), PLM (Product Lifecycle Management), ERP (Enterprise Resource Planning), CAD (Computer-Aided Design), SOP (Standard Operating Procedure), LLM (Large Language Model)

### Critical Constraints

- **On-premise deployment** is non-negotiable
- **PLM domain context** must inform all AI/ML recommendations
- **Data governance and access control** are essential
- Focus on **implementable, practitioner-ready** solutions

### Goal

Deliver both a **practical contribution** (working RAG in Sovelia Core) and **theoretical contribution** (design patterns for RAG in on-prem enterprise PLM).
