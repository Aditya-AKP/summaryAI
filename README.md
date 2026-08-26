# 📚 SummaryAI

**SummaryAI** is an AI-powered study assistant built with **Flutter** that converts text and PDF documents into concise summaries and interactive quizzes. It uses the **Groq GPT-OSS-20B** model to generate educational content and helps users assess and track their understanding through difficulty-based quizzes and performance analysis.

---

## ✨ Features

### 🤖 AI-Powered Summarisation

* Generate concise, educational summaries from textual content.
* Automatically generate a relevant title for each summary.
* Supports both manually entered text and PDF documents.
* Powered by the **Groq GPT-OSS-20B** large language model.

### 📄 PDF Processing

* Import PDF documents directly into the application.
* Extract text from PDFs using **Syncfusion Flutter PDF**.
* Supports documents up to 20 pages.
* Review and edit extracted content before generating the summary.

### 📝 AI-Generated Quizzes

Generate quizzes across three difficulty levels:

* 🟢 **Easy** — Fundamental concepts and direct understanding.
* 🟡 **Medium** — Conceptual understanding and application.
* 🔴 **Hard** — Analysis, reasoning, and deeper understanding.

Supported question types:

* **MCQ** — Multiple Choice Questions
* **MSQ** — Multiple Select Questions
* **Descriptive Questions**

Each objective question includes the correct answer and an explanation.

### ⚡ On-Demand Question Generation

Summary generation and question generation are handled independently.

```text
Text / PDF
    ↓
Summary Generation
    ↓
Title + Summary
    ↓
Select Difficulty
    ↓
Question Generation
    ↓
MCQ + MSQ + Descriptive Questions
```

Questions are generated only for the selected difficulty, reducing unnecessary model inference and allowing each difficulty level to be generated independently.

### 📊 Quiz Performance Analysis

* Automatic answer evaluation.
* Score and accuracy calculation.
* Correct and incorrect answer statistics.
* Performance classification.
* Animated performance feedback.
* Quiz completion summary.

### 💾 Intelligent Local Data Management

* **Hive CE** for persistent local storage of generated content.
* **SHA-256 hashing** for content identification and duplicate detection.
* Previously generated summaries and difficulty-specific quizzes can be retrieved without regenerating them through the AI model.

### 📚 Study History

* Store generated study material locally.
* Organise summaries by date.
* Display generated titles and creation timestamps.
* Revisit previously generated summaries and quizzes.

---

## 🧠 AI Architecture

SummaryAI uses a **two-stage AI generation pipeline**.

### Stage 1 — Summary Generation

The first API request processes the original content and generates:

```text
Title
Summary
```

### Stage 2 — Question Generation

When the user selects a difficulty, a separate API request generates:

```text
MCQs
MSQs
Descriptive Questions
Answers
Explanations
```

The question-generation request receives the **original content, generated summary, selected difficulty, and calculated question count** as context.

This architecture enables **on-demand question generation** rather than generating every difficulty level upfront.

---

## 📈 Dynamic Question Generation

Question quantity is determined from the input content length:

| Content Length  | Questions / Type |
| --------------- | ---------------: |
| < 150 words     |                2 |
| 150–399 words   |                3 |
| 400–699 words   |                4 |
| 700–999 words   |                5 |
| 1000–1499 words |                6 |
| 1500+ words     |                7 |

This allows the generated assessment to scale with the amount of learning material.

---

## 🛠 Tech Stack

| Category                   | Technology             |
| -------------------------- | ---------------------- |
| **Framework**              | Flutter                |
| **Language**               | Dart                   |
| **AI Model**               | Groq GPT-OSS-20B       |
| **AI Integration**         | Groq API               |
| **State Management**       | Provider               |
| **Local Database**         | Hive CE                |
| **Networking**             | Dio                    |
| **PDF Processing**         | Syncfusion Flutter PDF |
| **File Selection**         | File Picker            |
| **Data Serialization**     | json_serializable      |
| **Content Identification** | SHA-256                |
| **Configuration**          | flutter_dotenv         |

---

## 🔄 Application Workflow

```text
                    ┌──────────────┐
                    │     User     │
                    └──────┬───────┘
                           │
                 ┌─────────┴─────────┐
                 │                   │
            Enter Text          Import PDF
                 │                   │
                 │              Extract Text
                 │                   │
                 └─────────┬─────────┘
                           │
                           ▼
                    Generate Hash
                           │
                           ▼
                     Hive Lookup
                           │
                    ┌──────┴──────┐
                    │             │
                  Found        Not Found
                    │             │
                    │             ▼
                    │       Summary API
                    │             │
                    │             ▼
                    │       Title + Summary
                    │             │
                    └──────┬──────┘
                           │
                           ▼
                    Result Screen
                           │
              ┌────────────┼────────────┐
              ▼            ▼            ▼
            Easy        Medium         Hard
              │            │            │
              ▼            ▼            ▼
          Question     Question     Question
             API          API          API
              │            │            │
              └────────────┼────────────┘
                           ▼
                    Question Screen
                           │
                           ▼
                   Performance Analysis
```

---

## 🚀 Getting Started

### Prerequisites

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* Groq API key

### Installation

Clone the repository:

```bash
git clone https://github.com/<your-username>/SummaryAI.git
```

Navigate to the project:

```bash
cd SummaryAI
```

Install dependencies:

```bash
flutter pub get
```

Create the environment configuration:

```env
GROQ_API_KEY=YOUR_API_KEY
BASE_URL=https://api.groq.com/openai/v1
```

Run the application:

```bash
flutter run
```

---

## 📸 Screenshots

| Dashboard            | Summary              |
| -------------------- | -------------------- |
| Add screenshots here | Add screenshots here |

| Quiz                 | Performance          |
| -------------------- | -------------------- |
| Add screenshots here | Add screenshots here |

---

## 👨‍💻 Author

**Aditya Kumar**

**Flutter • Dart • Generative AI • Groq API • Hive • Data Processing**
