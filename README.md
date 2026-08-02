# 📚 SummaryAI

An AI-powered Flutter application that transforms textual content into concise study summaries and interactive quizzes using Large Language Models (LLMs). SummaryAI helps students revise concepts efficiently by generating summaries, objective questions, descriptive questions, and detailed explanations from any given text.

---

## ✨ Features

- 📄 Generate concise AI-powered summaries from any text.
- 🤖 Create **Easy, Medium, and Hard** level quizzes automatically.
- ❓ Supports multiple question types:
  - Multiple Choice Questions (MCQs)
  - Multiple Select Questions (MSQs)
  - Descriptive Questions
- 💡 AI-generated answers with explanations for objective questions.
- 📊 Interactive quiz with automatic scoring and performance analysis.
- 📚 Save generated summaries and quizzes for future reference.
- ⚡ SHA-256 based duplicate detection to avoid regenerating previously processed content.
- 💾 Hive database caching for fast retrieval of stored summaries.
- 🚀 Single API request generates summary, questions, answers, and explanations.

---

## 🛠 Tech Stack

| Category | Technologies |
|----------|--------------|
| Framework | Flutter |
| Language | Dart |
| AI Model | Groq GPT-OSS-20B |
| Local Database | Hive CE |
| Networking | Dio |
| Serialization | json_serializable |
| Utilities | SHA-256, flutter_dotenv |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Latest Stable Version)
- Dart SDK
- Android Studio or VS Code
- A Groq API Key

---

### Installation

Clone the repository:

```bash
git clone https://github.com/Aditya_AKP/summaryAI.git
```

Navigate to the project directory:

```bash
cd summaryAI
```

Install dependencies:

```bash
flutter pub get
```

Create a `.env` file in the project root:

```env
GROQ_API_KEY=YOUR_API_KEY
BASE_URL=https://api.groq.com/openai/v1
```

Run the application:

```bash
flutter run
```

---

## 👨‍💻 Author

**Aditya Kumar**

If you found this project useful, consider giving it a ⭐ on GitHub.
