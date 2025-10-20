# Copilot Instructions for MSc Thesis Writing

## Project Overview

This repository contains the LaTeX source files for a Master's thesis on **integrating a resource-augmented AI assistant (RAG chatbot) into Sovelia Core**, a customizable on-premise Product Lifecycle Management (PLM) platform.

## Research Context

### Topic and Background

- **Domain**: AI-enhanced Product Lifecycle Management (PLM) systems
- **Platform**: Sovelia Core - an on-premise PLM platform used for CAD/ERP integrations and customer-specific workflows
- **Problem Statement**: Knowledge silos and documentation proliferation (Sovelia Help, release notes, customer SOPs) that hinder discoverability and onboarding
- **Solution**: Design and integrate an AI assistant that responds to queries based on vendor and customer-maintained documentation
- **Expected Impact**: Improved support, change management, and reduced time-to-competence for customer deployments

### Research Questions

1. **RQ1 (Design)**: What RAG system architecture best fits Sovelia Core's on-prem, PostgreSQL-based environment and data governance constraints?
2. **RQ2 (Process)**: How should customer documentation pipelines (parse → chunk → embed → retire) be engineered for reliability and maintainability?
3. **RQ3 (Quality & Risk)**: Which risks (hallucinations, stale context, access control) are most critical, and what mitigations work in practice?

### Methodology

- **Approach**: Design Science / Case Study methodology
- **Process**: Iterative build-measure-learn cycles in a live Sovelia Core environment
- **Focus Areas**:
  - System design: architecture, retrieval strategies, chunking, embeddings, access control
  - UX design: chat patterns, feedback loops

## Writing Assistance Guidelines

### Content Support Needed

When assisting with thesis writing, focus on:

1. **Academic Writing**

   - Help structure arguments logically
   - Suggest appropriate academic phrasing and terminology
   - Ensure clarity and precision in technical explanations
   - Maintain formal academic tone

2. **Technical Content**

   - RAG (Retrieval-Augmented Generation) architecture patterns
   - Vector databases and embedding strategies
   - On-premise deployment considerations
   - Data governance and access control in PLM systems
   - Documentation pipeline engineering
   - AI safety concerns (hallucinations, context staleness)

3. **Domain-Specific Knowledge**

   - PLM (Product Lifecycle Management) systems
   - CAD/ERP integration workflows
   - Enterprise software deployment patterns
   - Customer documentation management
   - Knowledge management in technical environments

4. **Research Methodology**
   - Design Science Research framework
   - Case Study methodology
   - Build-measure-learn iteration cycles
   - Qualitative and quantitative evaluation strategies

### Chapter-Specific Guidance

#### Introduction

- Contextualize the problem within PLM and knowledge management
- Emphasize practical business impact (onboarding, support efficiency)
- Connect to broader AI integration trends in enterprise software

#### Literature Review

- Cover: RAG systems, vector databases, enterprise AI adoption, PLM systems, knowledge management
- Include both technical (AI/ML) and domain (PLM/ERP) literature
- Address on-premise vs. cloud deployment considerations

#### Research Methodology

- Detail Design Science Research approach
- Explain case study selection and boundaries
- Describe iteration cycles and evaluation criteria

#### System Design and Implementation

- Architecture decisions and trade-offs
- Documentation pipeline design
- Embedding model selection
- Access control implementation
- Integration with Sovelia Core

#### Evaluation and Results

- User feedback and adoption metrics
- Technical performance (retrieval accuracy, latency)
- Risk mitigation effectiveness
- Qualitative insights from stakeholders

#### Conclusion

- Practical contributions to Sovelia Core
- Theoretical contributions to RAG deployment in enterprise contexts
- Limitations and future work

### Style and Tone

- **Academic but accessible**: Technical precision without unnecessary jargon
- **Practitioner-oriented**: Balance theory with practical implementation insights
- **Evidence-based**: Support claims with data, literature, or empirical observations
- **Reflective**: Acknowledge limitations, trade-offs, and alternative approaches

### LaTeX-Specific Notes

- Use `\textbf{}` for emphasis in body text
- Use `\emph{}` for technical terms on first introduction
- Use `itemize` for lists, `enumerate` for sequential steps
- Use `\parencite{}` for references (BibTeX file: `mainmatter/references.bib`)
- Use `\ref{}` for cross-references to figures, tables, and sections

### Common Acronyms and Terms

- **RAG**: Retrieval-Augmented Generation
- **PLM**: Product Lifecycle Management
- **ERP**: Enterprise Resource Planning
- **CAD**: Computer-Aided Design
- **SOP**: Standard Operating Procedure
- **UX**: User Experience
- **LLM**: Large Language Model
- **AI**: Artificial Intelligence
- **ML**: Machine Learning

### What NOT to Do

- Don't just suggest LaTeX syntax fixes without understanding content intent
- Don't ignore the on-premise deployment constraint (this is critical!)
- Don't propose generic AI/ML solutions without considering the PLM domain context
- Don't forget the practitioner audience - this needs to be implementable
- Don't overlook data governance and access control concerns

## Goal

Help write a thesis that makes both a **practical contribution** (working RAG integration in Sovelia Core) and a **theoretical contribution** (design patterns and lessons learned for RAG in on-premise enterprise PLM contexts).
