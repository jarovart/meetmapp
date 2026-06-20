# 📍 Casttime – Location-Based Event & Meet-Up App

Casttime ist eine moderne Location-App, mit der Nutzer Orte entdecken, eigene Events erstellen und sich mit anderen Menschen treffen können. Die App besteht aus einem **Flutter-Frontend** (iOS / Android / Web / Windows) und einem **Spring Boot Backend** für Authentifizierung, Datenverwaltung und APIs.

---

## 🚀 Features

### ✔ Flutter App (Mobile, Web, Desktop)
- Live-Map mit *flutter_map*
- Benutzer-Standort mit animiertem Marker
- Neue Locations per Long-Tap auf der Map erstellen
- Suchleiste als Overlay
- Datum-Slider (Heute / Morgen / 1 Woche / 1 Monat)
- Profilseite
- Login / Logout (JWT)
- Dark Mode Unterstützung
- Responsive UI für Web und Smartphone

### ✔ Spring Boot Backend
- JWT-Authentifizierung (Access + Refresh Tokens)
- REST API für:
  - Nutzer
  - Locations
  - Bilder
- PostgreSQL oder H2 Datenbank
- CORS-Unterstützung für Flutter/Web
- Sicherheit durch Spring Security

---

## 🧱 Architektur

```
Flutter (Client)
   ↓ HTTP / JWT
Spring Boot (API + Auth)
   ↓
PostgreSQL (DB)
```

---

## 📦 Tech Stack

### Client (Flutter)
- Flutter 3.x
- flutter_map
- go_router
- flutter_secure_storage
- http
- Provider / Riverpod (optional)
- Material 3 UI

### Backend (Spring Boot)
- Spring Boot 3.x
- Spring Security (JWT)
- Spring Web
- Spring Data JPA
- PostgreSQL
- Lombok

---

## 🔧 Installation & Setup

### 1️⃣ Backend starten

```bash
cd backend
mvn spring-boot:run
```

Backend läuft unter:
```
http://localhost:8080
```

### 2️⃣ Flutter App starten

```bash
cd casttime
flutter pub get
flutter run
```

Für Web:
```bash
flutter run -d chrome
```

---

## 🔐 JWT Authentifizierung

Die App verwendet ein modernes JWT-System:
- **Access Token** (kurze Lebensdauer)
- **Refresh Token** (lange Lebensdauer)
- Speicherung in `flutter_secure_storage`
- Automatische Weiterleitung zum Login, wenn Tokens ungültig werden

Alle API-Requests enthalten:
```
Authorization: Bearer <TOKEN>
```

---

## 🗺️ Location-Funktionen
- Karte (OpenStreetMap / MapTiler)
- Standort des Nutzers
- Neue Locations per Long-Press
- Vertikale Locationsliste
- Details pro Location
- Datum-Slider für Filter

---

## 📁 Projektstruktur

### Flutter
```
lib/
  pages/
  widgets/
  models/
  services/
  app_router.dart
```

### Spring Boot
```
src/main/java/.../
  controller/
  service/
  repository/
  security/
  model/
```

---

## 🤝 Contribution
Pull Requests sind willkommen. Achte auf sauberen Code und sinnvolle Commit Messages.

---

## 🛡️ Lizenz
MIT License – frei nutzbar für private und kommerzielle Projekte.

---

## ⭐ Support
Wenn du Feedback oder neue Feature-Wünsche hast: Issues & PRs sind willkommen!