# 📚 SummaryAI – AI-Powered Study Assistant

> An AI-powered Flutter application that transforms text into concise study summaries and interactive quizzes using Large Language Models (LLMs).

> 🚧 **Project Status:** Under Active Development

---

## 📖 Overview

SummaryAI is an AI-powered educational application built with Flutter that helps students learn more effectively by automatically generating study materials from textual content.

Given any paragraph or article, the application generates:
- 📄 Concise AI-generated summaries
- ❓ Multiple Choice Questions (MCQs)
- ☑️ Multiple Select Questions (MSQs)
- ✍️ Descriptive Questions
- ✅ Answers with explanations
- 📊 Performance analysis after quiz completion

The application is designed to minimize AI API usage through intelligent caching while providing a smooth and interactive learning experience.

---

## ✨ Features

- 🤖 AI-generated educational summaries
- 📚 Difficulty-wise question generation
  - Easy
  - Medium
  - Hard
- 📝 Multiple question formats
  - MCQ
  - MSQ
  - Descriptive Questions
- 💡 Answer explanations
- 📈 Quiz scoring and performance analytics
- 📜 Summary history
- 🔍 SHA-256 based duplicate detection
- 💾 Hive local database caching
- ⚡ Single API call for complete content generation
- 🎨 Modern Flutter UI

---

## 🛠 Tech Stack

### Frontend
- Flutter
- Dart

### AI
- Groq API
- GPT-OSS-20B

### Local Storage
- Hive CE

### State Management
- Provider

### Networking
- Dio

### Serialization
- json_serializable

### Utilities
- SHA-256 Hashing
- flutter_dotenv

---

## 🏗 Project Architecture

The application follows a modular architecture with clear separation of responsibilities.

```
lib/
│
├── constants/
├── models/
├── repositories/
├── services/
├── providers/
├── screens/
├── widgets/
├── utils/
└── main.dart
```

Workflow:

```
User Input
      │
      ▼
Generate SHA-256 Hash
      │
      ▼
Check Hive Database
      │
 ┌────┴────┐
 │         │
Found     Not Found
 │         │
 ▼         ▼
Load     Groq API
Local       │
             ▼
      Generate Summary
      + Quiz + Answers
             │
             ▼
      Store in Hive
             │
             ▼
       Display Result
```

---

## 🚀 How It Works

1. User enters or pastes text.
2. SHA-256 hash is generated for the input.
3. Hive database checks if the content has already been processed.
4. If found, cached results are displayed instantly.
5. Otherwise, a single request is sent to the Groq API.
6. The AI returns:
   - Summary
   - MCQs
   - MSQs
   - Descriptive Questions
   - Answers
   - Explanations
7. The generated content is stored locally for future use.

---

## 📸 Screenshots

> Screenshots will be added after UI completion.

```
Home Screen

Result Screen

Quiz Screen

History Screen

Performance Screen
```

---

## ⚙ Installation

Clone the repository

```bash
git clone https://github.com/<your-username>/SummaryAI.git
```

Go to the project directory

```bash
cd SummaryAI
```

Install dependencies

```bash
flutter pub get
```

Create a `.env` file

```env
GROQ_API_KEY=YOUR_API_KEY
BASE_URL=https://api.groq.com/openai/v1
```

Run the application

```bash
flutter run
```

---

## 🔒 Environment Variables

This project uses a `.env` file for storing API credentials.

Example:

```env
GROQ_API_KEY=YOUR_API_KEY
BASE_URL=https://api.groq.com/openai/v1
```

The `.env` file is excluded from version control using `.gitignore`.

---

## 📅 Current Development Progress

- [x] Project Setup
- [x] Groq API Integration
- [x] Hive Database Integration
- [x] SHA-256 Based Caching
- [x] AI Prompt Engineering
- [x] Summary Generation
- [x] Question Generation
- [x] History Module
- [x] Interactive Quiz Module
- [ ] UI Polish
- [ ] Testing
- [ ] Play Store Release

---

## 🎯 Future Enhancements

- PDF support
- OCR support
- Flashcards
- Mind Maps
- Voice Input
- Text-to-Speech
- Multi-language Support
- AI Revision Recommendations

---

## 🤝 Contributing

Contributions, suggestions, and feature requests are welcome.

Feel free to fork the repository and submit a pull request.

---

## 📄 License

This project is licensed under the MIT License.

---

## 👨‍💻 Author

**Aditya Kumar**

If you found this project useful, consider giving it a ⭐ on GitHub.
