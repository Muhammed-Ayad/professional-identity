# Professional Identity 🚀

### Full-Stack Digital Professional Identity Platform

**Professional Identity** is a platform that helps developers and professionals create one place for all their professional information.

Instead of sharing separate links for your CV, LinkedIn, GitHub, Portfolio, Projects, and Skills, you can create one verified public profile with a unique handle and share it using a single link or QR code.

---

## 🌟 Live Demo & Downloads

- 🌐 **Web App**: [https://professional-identity.serverpod.space](https://professional-identity.serverpod.space)
- 👤 **Example Profile**: [https://professional-identity.serverpod.space/u/mohamed-ayad](https://professional-identity.serverpod.space/u/mohamed-ayad)
- 📱 **Android App (APK)**: [Download APK from Google Drive](https://drive.google.com/file/d/1MqJqqSLiBAwSGYR1TiC_0Ppc8Lwt-ZJX/view?usp=sharing)
- 💻 **GitHub Repository**: [https://github.com/Muhammed-Ayad/professional-identity](https://github.com/Muhammed-Ayad/professional-identity)

---

## ✨ Features

### 👤 Professional Profile
- Create and manage your professional profile.
- Add bio, skills, experience, and contact information.
- Choose a unique profile handle (`/u/:handle`).
- Toggle profile visibility between public and private.

### 💼 Portfolio & Projects
- Add and showcase featured projects.
- Add project descriptions, technology tags, and screenshots.
- Add GitHub repository links and Live Demo buttons.
- Add and organize work experience timeline.

### 📄 CV & Resume
- Upload your CV as a PDF directly to cloud storage.
- View and download your CV with 1-click from your public profile.

### 🔗 Social Links
Connect all your professional platforms:
- GitHub
- LinkedIn
- X (Twitter)
- LeetCode
- StackOverflow
- Personal Website / Blog
- Email

### 🎨 Profile Customization
- Choose accent colors and gradient themes.
- Customize profile card appearance.
- Full support for dark and light themes.

### 📱 Sharing & QR Code
- Dynamic QR code generation for your profile.
- Download high-resolution QR codes.
- 1-click link copy and native OS share dialog.

### 💬 Contact & Inquiries
- Direct contact form on public profiles for recruiters and clients.
- Profile owners can manage and view inquiries directly from their private dashboard inbox.

### 📊 Analytics
Profile owners can track basic engagement statistics:
- Profile views
- Project clicks (GitHub & Live Demo)
- Social link clicks
- CV views and downloads
- Profile shares and link copies
- QR code views and downloads

> *The analytics system is designed to collect basic interaction metrics without storing any personal visitor data or tracking cookies.*

---

## 🛠 Tech Stack

### Frontend (`professional_identity_flutter`)
- **Flutter Web & Mobile** (Flutter 3.44+)
- **Dart 3.x**
- **Hooks Riverpod** (State Management)
- **Flutter Hooks**
- **Material 3** & Google Fonts

### Backend (`professional_identity_server`)
- **Serverpod 4**
- **Dart**
- **PostgreSQL** (ORM & Database)
- **Serverpod Auth** (Email IDP & JWT Tokens)

### Infrastructure & Tools
- **Serverpod Cloud** (Production hosting)
- **Serverpod Cloud Storage** (PDF CVs and assets)
- **Docker** (Local database)
- **Git**

---

## 🏗 Architecture

The Flutter application follows a **Feature-First Clean Architecture**:

```text
lib/
├── core/
│   ├── theme/
│   └── utils/
└── feature/
    ├── auth/
    ├── profile/
    ├── public_profile/
    ├── projects/
    ├── experience/
    ├── skills/
    ├── cv/
    ├── analytics/
    ├── inquiries/
    ├── profile_customization/
    ├── social_links/
    ├── share/
    └── dashboard/
```

### Feature Structure
Each feature is cleanly divided into **Business Logic** and **UI Presentation**:

```text
feature/
├── logic/
│   ├── models/
│   ├── providers/
│   └── repo/
└── view/
    ├── screens/
    └── widgets/
```

### Key Principles
- **Feature-First organization**: Self-contained modules per feature.
- **Repository Pattern**: Clean abstraction layer wrapping Serverpod client RPCs.
- **Riverpod State Management**: Reactive, safe asynchronous state transitions (`AsyncNotifier`).
- **Separation of Concerns**: UI widgets never handle network calls directly.
- **Strongly Typed**: End-to-end typed contracts between client and server.

---

## 🗄 Backend

The backend is built with **Serverpod 4** and **PostgreSQL**.

It handles:
- Authentication & Session validation
- User profile data & unique handle reservation
- Projects & Work experience timeline
- Skills management
- CV PDF upload and storage
- Social links
- Direct messages & inquiries
- Privacy-conscious analytics
- SEO & Open Graph (OG) server-side tag generation for `/u/:handle`

The Flutter client communicates seamlessly with the backend through Serverpod's generated client.

---

## 📊 Analytics System

When visitors interact with a public profile, events are tracked:
- `profile_view`
- `project_click`
- `social_link_click`
- `cv_view`
- `profile_share`
- `profile_link_copy`
- `qr_view`
- `qr_download`

Profile owners view aggregated insights directly from their dashboard.

---

## 🚀 Running Locally

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Serverpod CLI](https://docs.serverpod.dev/) (`dart pub global activate serverpod_cli`)
- [Docker Desktop](https://www.docker.com/)

### 1. Clone the Repository
```bash
git clone https://github.com/Muhammed-Ayad/professional-identity.git
cd professional-identity
```

### 2. Start PostgreSQL Database
```bash
cd professional_identity_server
docker compose up -d
```

### 3. Install Dependencies
```bash
dart pub get
```

### 4. Start the Serverpod Backend
```bash
serverpod start
```

### 5. Run Flutter Web
```bash
cd ../professional_identity_flutter
flutter pub get
flutter run -d chrome
```

---

## ☁️ Deployment

- Deployed on **Serverpod Cloud**.
- Flutter Web is compiled for production and served directly through the Serverpod backend.

---

## 🧪 Project Status

The platform has been verified and tested:
- ✅ Flutter tests passing
- ✅ Serverpod tests passing
- ✅ Flutter analyzer passing
- ✅ Server analyzer passing
- ✅ Production Flutter Web build
- ✅ Production Android Release APK build
- ✅ Deployed live on Serverpod Cloud

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

## 👨‍💻 Author

**Mohamed Ayad**

- 🌐 **Public Profile**: [https://professional-identity.serverpod.space/u/mohamed-ayad](https://professional-identity.serverpod.space/u/mohamed-ayad)
- 💻 **GitHub**: [https://github.com/Muhammed-Ayad](https://github.com/Muhammed-Ayad)
