# 📋 Jobdesk Tim - Aplikasi Manajemen Keuangan DanaKu

**Tanggal:** 16 November 2025  
**Jumlah Anggota:** 5 orang  
**Nama Aplikasi:** DanaKu - Aplikasi Manajemen Keuangan

---

## 👥 Pembagian Tim & Tanggung Jawab

### **M SULTHON ALFARIZKY: Project Leader & Backend Developer**
**Fokus:** Koordinasi tim, integrasi Firebase, dan manajemen data

#### ✅ Tugas Utama:
- [ ] Mengkoordinasikan progres tim secara keseluruhan
- [ ] Mengintegrasikan Firebase Authentication (login/register dengan email)
- [ ] Mengintegrasikan Cloud Firestore untuk menyimpan data transaksi
- [ ] Membuat implementasi Firebase backend di `lib/data/repositories/firebase_*_repository.dart`
- [ ] Testing integrasi backend dengan UI yang sudah ada
- [ ] Membuat dokumentasi API dan cara penggunaan Firebase

#### 📦 File yang Dikerjakan:
```
lib/data/repositories/firebase_transaction_repository.dart
lib/data/repositories/firebase_category_repository.dart
lib/data/repositories/firebase_auth_repository.dart
lib/core/services/firebase_service.dart
```

#### 🎯 Target:
- Backend terintegrasi penuh dengan Firebase dalam 2 minggu
- Semua CRUD operations berfungsi dengan database cloud

---

### **Anggota 2: UI/UX Developer - Features**
**Fokus:** Pengembangan fitur transaksi dan kategori

#### ✅ Tugas Utama:
- [ ] Menyempurnakan halaman **Transaksi** (tambah, edit, hapus transaksi)
- [ ] Implementasi filter dan pencarian transaksi
- [ ] Memperbaiki form input transaksi dengan validasi
- [ ] Menambahkan fitur upload foto bukti transaksi
- [ ] Implementasi kategori custom dengan icon picker
- [ ] Membuat widget reusable untuk input form

#### 📦 File yang Dikerjakan:
```
lib/features/transactions/transaction_screen.dart
lib/features/transactions/transaction_form_screen.dart
lib/features/transactions/transaction_detail_screen.dart
lib/features/categories/category_form_screen.dart
lib/widgets/custom_text_field.dart
lib/widgets/category_icon_picker.dart
```

#### 🎯 Target:
- UI transaksi lengkap dengan semua fitur CRUD
- User experience yang smooth dan intuitif

---

### **Anggota 3: Analytics & Visualization Developer**
**Fokus:** Grafik, laporan, dan analisis keuangan

#### ✅ Tugas Utama:
- [ ] Menyempurnakan halaman **Analisis** dengan lebih banyak chart
- [ ] Menambahkan grafik bar untuk perbandingan bulanan
- [ ] Implementasi laporan PDF (export ke PDF)
- [ ] Membuat dashboard ringkasan keuangan di halaman Home
- [ ] Menambahkan filter tanggal untuk analisis (harian, mingguan, bulanan, tahunan)
- [ ] Implementasi prediksi pengeluaran berdasarkan history

#### 📦 File yang Dikerjakan:
```
lib/features/analytics/analytics_screen.dart
lib/features/analytics/widgets/bar_chart_widget.dart
lib/features/analytics/widgets/report_generator.dart
lib/features/home/widgets/financial_summary_card.dart
lib/core/utils/pdf_generator.dart
lib/core/utils/date_filter_helper.dart
```

#### 🎯 Target:
- Dashboard analytics yang informatif dan visual menarik
- Fitur export laporan berfungsi dengan baik

---

### **Anggota 4: Notification & Settings Developer**
**Fokus:** Notifikasi, pengaturan, dan fitur tambahan

#### ✅ Tugas Utama:
- [ ] Implementasi sistem **notifikasi pengingat** (tagihan, budget limit)
- [ ] Membuat halaman **Settings/Pengaturan** lengkap
- [ ] Implementasi fitur budget/anggaran bulanan dengan alert
- [ ] Menambahkan notifikasi lokal untuk reminder transaksi rutin
- [ ] Implementasi dark mode / light mode toggle
- [ ] Membuat fitur backup & restore data lokal

#### 📦 File yang Dikerjakan:
```
lib/features/notifications/notifications_screen.dart
lib/features/settings/settings_screen.dart
lib/features/budget/budget_screen.dart
lib/core/services/local_notifications.dart
lib/core/services/backup_service.dart
lib/data/providers/theme_provider.dart
```

#### 🎯 Target:
- Sistem notifikasi berfungsi dengan baik
- Settings page yang lengkap dan fungsional

---

### **Anggota 5: Profile & Authentication Developer**
**Fokus:** Halaman profil, autentikasi, dan manajemen akun

#### ✅ Tugas Utama:
- [x] Menyempurnakan halaman **Profile** dengan semua informasi user
- [x] Implementasi fitur edit profile (nama, email, foto profil)
- [x] Membuat halaman **Login** yang lengkap dengan validasi
- [x] Membuat halaman **Register** dengan konfirmasi password
- [x] Implementasi forgot password / reset password
- [x] Menambahkan fitur change password di settings
- [x] Implementasi logout dengan konfirmasi
- [x] Membuat halaman About App dan Privacy Policy

#### 📦 File yang Dikerjakan:
```
lib/features/profile/profile_screen.dart
lib/features/profile/edit_profile_screen.dart
lib/features/auth/login_screen.dart
lib/features/auth/register_screen.dart
lib/features/auth/forgot_password_screen.dart
lib/features/settings/change_password_screen.dart
lib/features/settings/about_screen.dart
lib/widgets/profile_avatar.dart
```

#### 🎯 Target:
- Sistem autentikasi lengkap dan aman
- Profile management yang user-friendly
- Form validation yang proper

---

## 📅 Timeline Pengerjaan (7 Minggu)

### **Minggu 1: Setup & Preparation**
| Anggota | Tugas Minggu Ini |
|---------|------------------|
| **M SULTHON ALFARIZKY** | Setup Firebase project, konfigurasi FlutterFire |
| **Anggota 2** | Analisis UI Transaksi yang ada, buat mockup improvement |
| **Anggota 3** | Research library chart (fl_chart), buat prototype dashboard |
| **Anggota 4** | Setup local notifications, research notification patterns |
| **Anggota 5** | Perbaiki halaman Login & Register yang sudah ada |

### **Minggu 2: Core Development - Phase 1**
| Anggota | Tugas Minggu Ini |
|---------|------------------|
| **M SULTHON ALFARIZKY** | Implementasi Firebase Auth (login, register, logout) |
| **Anggota 2** | Buat halaman Transaction Form (tambah transaksi) |
| **Anggota 3** | Implementasi Pie Chart di halaman Analytics |
| **Anggota 4** | Buat halaman Settings dengan basic options |
| **Anggota 5** | Implementasi Edit Profile & Upload Foto |

### **Minggu 3: Core Development - Phase 2**
| Anggota | Tugas Minggu Ini |
|---------|------------------|
| **M SULTHON ALFARIZKY** | Implementasi Firestore untuk Transactions |
| **Anggota 2** | Buat halaman Transaction Detail & Edit |
| **Anggota 3** | Implementasi Line Chart untuk trend bulanan |
| **Anggota 4** | Implementasi notifikasi reminder transaksi |
| **Anggota 5** | Buat halaman Forgot Password |

### **Minggu 4: Feature Completion**
| Anggota | Tugas Minggu Ini |
|---------|------------------|
| **M SULTHON ALFARIZKY** | Implementasi Firestore untuk Categories & Sync |
| **Anggota 2** | Implementasi filter & search transaksi |
| **Anggota 3** | Buat fitur export PDF untuk laporan |
| **Anggota 4** | Implementasi Budget Alert & Notification |
| **Anggota 5** | Buat halaman About & Privacy Policy |

### **Minggu 5: Integration & Enhancement**
| Anggota | Tugas Minggu Ini |
|---------|------------------|
| **M SULTHON ALFARIZKY** | Testing integrasi Firebase, fix bugs |
| **Anggota 2** | Polish UI Transaksi, tambah animasi |
| **Anggota 3** | Tambah Bar Chart & lebih banyak insights |
| **Anggota 4** | Implementasi Dark Mode toggle |
| **Anggota 5** | Polish UI Profile & Auth screens |

### **Minggu 6: Testing & Bug Fixing**
| Tugas | PIC |
|-------|-----|
| Unit Testing | Semua anggota untuk bagiannya masing-masing |
| Integration Testing | M SULTHON ALFARIZKY & 2 |
| UI/UX Testing | Anggota 3 & 5 |
| Performance Testing | Anggota 4 |
| Bug Fixing | Semua anggota (sesuai domain) |

### **Minggu 7: Finalization & Release Preparation**
- Polish semua UI/UX
- Final testing di real device
- Dokumentasi lengkap (README, user guide)
- Preparation untuk Google Play / App Store
- Video demo aplikasi

---

## 🔄 Alur Kolaborasi

### **📞 Daily Standup (Online/WhatsApp)**
**Waktu:** Setiap hari pukul 19:00 WIB (Maksimal 15 menit)

**Format Update (Setiap Anggota):**
1. ✅ **Yesterday:** Apa yang sudah diselesaikan kemarin?
2. 🎯 **Today:** Apa yang akan dikerjakan hari ini?
3. 🚫 **Blockers:** Ada kendala/masalah yang menghambat?

**Contoh Update:**
```
[Nama] - Anggota 2:
✅ Yesterday: Selesai bikin Transaction Form UI
🎯 Today: Implementasi validasi form & save data
🚫 Blockers: Butuh format model Transaction dari M SULTHON ALFARIZKY
```

**Aturan Standup:**
- Jika ada blocker yang urgent, langsung diskusi setelah standup
- Jika tidak bisa join, kirim update tertulis sebelum jam 19:00
- Tidak ada standup di hari Minggu

---

### **📊 Weekly Review Meeting**
**Waktu:** Setiap Sabtu pukul 14:00 WIB (60-90 menit)

**Agenda Meeting:**
1. **Demo Time** (30 menit)
   - Setiap anggota demo fitur yang sudah selesai
   - Screencast atau live demo dari emulator
   
2. **Progress Review** (15 menit)
   - Review checklist tugas yang sudah selesai
   - Update progress board (Trello/GitHub Projects)
   
3. **Problem Discussion** (15 menit)
   - Diskusi masalah teknis yang dihadapi
   - Brainstorming solusi bersama
   
4. **Planning Next Week** (15 menit)
   - Tentukan prioritas minggu depan
   - Assign tugas tambahan jika ada
   
5. **Knowledge Sharing** (15 menit - Optional)
   - Share tips/tricks yang ditemukan
   - Code review bersama untuk best practice

**Action Items:**
- Project Leader buat meeting notes
- Screenshot/record demo untuk dokumentasi
- Update timeline jika ada perubahan

---

### **🔀 Git Workflow (Wajib Diikuti!)**

#### **1️⃣ Sebelum Mulai Coding:**
```bash
# Update branch main
git checkout main
git pull origin main

# Buat branch baru dari main
git checkout -b feature/nama-fitur-anda
```

#### **2️⃣ Saat Coding:**
```bash
# Commit berkala (minimal 1x sehari)
git add .
git commit -m "feat: deskripsi perubahan yang jelas"

# Push ke remote branch
git push origin feature/nama-fitur-anda
```

#### **3️⃣ Setelah Fitur Selesai:**
1. Push final commit
2. Buka GitHub → Create Pull Request
3. Isi deskripsi PR dengan:
   - Apa yang diubah/ditambahkan
   - Screenshot (jika perubahan UI)
   - Checklist testing yang sudah dilakukan
4. Assign reviewer (minimal 1 anggota lain)
5. Tunggu approval

#### **4️⃣ Code Review Process:**
**Reviewer harus cek:**
- ✅ Code berjalan tanpa error
- ✅ Tidak ada warning dari `flutter analyze`
- ✅ Naming convention konsisten
- ✅ Ada comments untuk logic yang kompleks
- ✅ Tidak ada hardcoded values (gunakan constants)

**Approve PR jika:**
- Semua checklist di atas terpenuhi
- Tidak ada conflict dengan main branch

#### **5️⃣ Merge ke Main:**
- Gunakan "Squash and Merge" untuk history yang bersih
- Hapus branch remote setelah merge
- Hapus branch lokal: `git branch -d feature/nama-fitur`

---

### **📝 Naming Convention**

#### **Branch Names:**
```
feature/nama-fitur          # Fitur baru
fix/nama-bug                # Bug fix
refactor/nama-refactor      # Refactoring code
docs/nama-dokumentasi       # Update dokumentasi
test/nama-test              # Tambah/update test
```

**Contoh Branch Names:**
```
feature/transaction-form
feature/analytics-pie-chart
feature/budget-notification
fix/login-validation-error
fix/chart-data-null-crash
refactor/home-screen-layout
docs/readme-setup-guide
test/transaction-widget-test
```

#### **Commit Messages:**
Format: `type: deskripsi singkat`

**Types:**
- `feat`: Fitur baru
- `fix`: Bug fix
- `refactor`: Refactoring code
- `style`: Perubahan UI/styling
- `test`: Tambah/update test
- `docs`: Update dokumentasi
- `chore`: Maintenance (update dependencies, dll)

**Contoh Commit Messages:**
```bash
git commit -m "feat: add transaction form with validation"
git commit -m "fix: resolve null pointer in analytics chart"
git commit -m "style: improve home screen card layout"
git commit -m "refactor: extract reusable date picker widget"
git commit -m "test: add unit test for transaction model"
git commit -m "docs: update README with Firebase setup guide"
git commit -m "chore: update flutter_animate to v4.5.0"
```

#### **Pull Request Title:**
```
[Type] Deskripsi Singkat

Contoh:
[Feature] Transaction Form with Validation
[Fix] Resolve Analytics Chart Crash on Null Data
[Refactor] Extract Reusable Components from Home Screen
```

#### **File Naming Convention:**
```
Dart Files (lowercase with underscore):
- transaction_form_screen.dart
- balance_card_widget.dart
- firebase_transaction_repository.dart

Classes (PascalCase):
- TransactionFormScreen
- BalanceCard
- FirebaseTransactionRepository

Variables & Functions (camelCase):
- getUserTransactions()
- totalBalance
- isLoading
```

---

## 📞 Komunikasi Tim

### **Channel Komunikasi:**
- **WhatsApp Group:** Komunikasi sehari-hari
- **GitHub Issues:** Bug tracking dan feature request
- **Google Meet/Zoom:** Weekly review dan diskusi teknis

### **Response Time:**
- Urgent: < 1 jam
- Normal: < 6 jam
- Low priority: < 24 jam

---

## ✅ Definition of Done (DoD)

### **📋 Checklist - Task Dianggap SELESAI Jika:**

#### **1. Code Quality:**
- [ ] Code sudah di-commit dengan commit message yang jelas
- [ ] Code sudah di-push ke branch feature
- [ ] Tidak ada error saat run aplikasi
- [ ] Tidak ada warning saat `flutter analyze`
- [ ] Code formatting konsisten (gunakan `dart format .`)
- [ ] Tidak ada TODO comments yang belum diselesaikan

#### **2. Functionality:**
- [ ] Fitur berfungsi sesuai requirement
- [ ] Sudah di-test secara manual di emulator/device
- [ ] Edge cases sudah di-handle (null, empty, error state)
- [ ] Loading state sudah ada (jika fetch data dari API/DB)
- [ ] Error handling sudah proper (toast/snackbar/dialog)

#### **3. UI/UX:**
- [ ] UI sesuai dengan design system (colors, spacing, shadows)
- [ ] Responsive untuk berbagai ukuran layar
- [ ] Ada feedback untuk user action (button press, loading, dll)
- [ ] Transisi/animasi smooth (jika ada)
- [ ] Text tidak terpotong atau overflow

#### **4. Testing:**
- [ ] Manual testing sudah dilakukan
- [ ] Unit test untuk business logic (jika applicable)
- [ ] Widget test untuk UI components (minimal untuk screen utama)
- [ ] Test coverage untuk file tersebut minimal 60%

#### **5. Documentation:**
- [ ] Comments untuk logic yang kompleks
- [ ] Function documentation (jika public/exported)
- [ ] README di-update (jika ada perubahan setup/configuration)
- [ ] Screenshot/video demo tersimpan (untuk fitur UI)

#### **6. Code Review:**
- [ ] Pull Request sudah dibuat dengan deskripsi lengkap
- [ ] PR sudah di-assign ke reviewer
- [ ] Feedback dari reviewer sudah di-address
- [ ] PR sudah approved oleh minimal 1 reviewer
- [ ] Tidak ada merge conflict dengan main branch

#### **7. Integration:**
- [ ] Pull Request sudah di-merge ke main
- [ ] Branch feature sudah di-delete (remote & local)
- [ ] Tim sudah di-inform via WhatsApp Group
- [ ] Task di-update status jadi "Done" di progress board

---

### **🚫 Task BELUM Selesai Jika:**
- ❌ Ada error yang belum di-fix
- ❌ Belum di-test sama sekali
- ❌ Code belum di-review
- ❌ Pull Request belum di-merge
- ❌ Ada breaking changes yang bikin fitur lain error

---

### **⚠️ Special Cases:**

**Untuk Bug Fix:**
- Tambahkan test case yang reproduce bug tersebut
- Pastikan bug tidak muncul lagi setelah fix

**Untuk Refactoring:**
- Pastikan functionality tidak berubah
- Semua test yang ada masih pass
- Performance tidak menurun

**Untuk Breaking Changes:**
- Diskusikan dengan tim dulu sebelum implement
- Update semua file yang terpengaruh
- Update dokumentasi dengan jelas

---

## 🚀 Quick Start Guide untuk Semua Anggota

### **📥 Setup Awal (First Time Setup)**

#### **1. Install Flutter SDK**
```bash
# Download Flutter SDK dari: https://docs.flutter.dev/get-started/install
# Extract dan tambahkan ke PATH

# Verifikasi instalasi
flutter doctor
```

**Pastikan checklist ini terpenuhi:**
- ✅ Flutter SDK installed
- ✅ Android Studio installed (untuk Android)
- ✅ VS Code atau Android Studio (IDE)
- ✅ Android SDK installed
- ✅ Device emulator atau physical device ready

#### **2. Clone Repository**
```bash
# Clone dari GitHub
git clone https://github.com/Fuentes771/DanaKu-Flutter-Project.git

# Atau jika sudah punya access SSH
git clone git@github.com:Fuentes771/DanaKu-Flutter-Project.git

# Masuk ke folder project
cd flutter_manajemenkeuangan
```

#### **3. Install Dependencies**
```bash
# Install semua packages yang dibutuhkan
flutter pub get

# Jika ada error, coba clean dulu
flutter clean
flutter pub get
```

#### **4. Setup IDE (VS Code - Recommended)**
```bash
# Install Extensions yang dibutuhkan:
# 1. Flutter (by Dart Code)
# 2. Dart (by Dart Code)
# 3. GitLens (untuk Git visualization)
# 4. Error Lens (untuk melihat error inline)
```

**VS Code Settings (Recommended):**
- Format on Save: Enabled
- Auto Save: afterDelay (1000ms)

#### **5. Run Aplikasi**
```bash
# List available devices
flutter devices

# Run di device/emulator tertentu
flutter run -d <device_id>

# Atau langsung run (akan pilih device otomatis)
flutter run

# Run di Chrome (untuk web testing)
flutter run -d chrome
```

**Hotkeys saat aplikasi running:**
- `r` - Hot reload (refresh tanpa restart)
- `R` - Hot restart (restart penuh)
- `q` - Quit
- `p` - Show performance overlay

#### **6. Verify Setup**
```bash
# Check jika ada issues
flutter doctor -v

# Check code quality
flutter analyze

# Run existing tests
flutter test
```

---

### **📁 Struktur Folder Project**

```
flutter_manajemenkeuangan/
│
├── android/                    # Android native code
├── ios/                        # iOS native code
├── web/                        # Web support files
├── windows/                    # Windows desktop files
│
├── assets/                     # Asset files
│   ├── logo.png               # App logo
│   ├── logo_splash.png        # Splash screen logo
│   └── icons/                 # Custom icons (if any)
│
├── lib/                        # Main source code
│   ├── main.dart              # Entry point aplikasi
│   ├── app.dart               # App root widget
│   │
│   ├── core/                   # Core utilities & configurations
│   │   ├── design_system.dart  # Design tokens (spacing, colors, etc)
│   │   ├── theme.dart          # App theme configuration
│   │   ├── constants.dart      # Global constants
│   │   ├── router.dart         # App routing (GoRouter)
│   │   ├── services/           # Services (notifications, firebase, etc)
│   │   └── utils/              # Helper functions
│   │
│   ├── data/                   # Data layer
│   │   ├── models/             # Data models (Transaction, Category, etc)
│   │   ├── repositories/       # Data repositories (local/firebase)
│   │   └── providers/          # Riverpod providers
│   │
│   ├── features/               # Features (screens & logic)
│   │   ├── auth/              # 🔐 Authentication (Anggota 5)
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   └── forgot_password_screen.dart
│   │   │
│   │   ├── home/              # 🏠 Home Dashboard
│   │   │   ├── home_screen.dart
│   │   │   └── widgets/
│   │   │
│   │   ├── transactions/      # 💰 Transactions (Anggota 2)
│   │   │   ├── transaction_screen.dart
│   │   │   ├── transaction_form_screen.dart
│   │   │   ├── transaction_detail_screen.dart
│   │   │   └── widgets/
│   │   │
│   │   ├── categories/        # 📂 Categories (Anggota 2)
│   │   │   ├── categories_screen.dart
│   │   │   ├── category_form_screen.dart
│   │   │   └── widgets/
│   │   │
│   │   ├── analytics/         # 📊 Analytics (Anggota 3)
│   │   │   ├── analytics_screen.dart
│   │   │   └── widgets/
│   │   │
│   │   ├── notifications/     # 🔔 Notifications (Anggota 4)
│   │   │   ├── notifications_screen.dart
│   │   │   └── widgets/
│   │   │
│   │   ├── profile/           # 👤 Profile (Anggota 5)
│   │   │   ├── profile_screen.dart
│   │   │   ├── edit_profile_screen.dart
│   │   │   └── widgets/
│   │   │
│   │   ├── settings/          # ⚙️ Settings (Anggota 4)
│   │   │   ├── settings_screen.dart
│   │   │   ├── change_password_screen.dart
│   │   │   └── about_screen.dart
│   │   │
│   │   ├── budget/            # 💵 Budget (Anggota 4)
│   │   │   ├── budget_screen.dart
│   │   │   └── widgets/
│   │   │
│   │   └── splash/            # 🚀 Splash Screen
│   │       └── splash_screen.dart
│   │
│   └── widgets/                # Reusable widgets
│       ├── app_logo.dart
│       ├── brand_background.dart
│       ├── balance_card.dart
│       ├── transaction_tile.dart
│       ├── empty_state.dart
│       └── app_shell.dart     # Bottom navigation
│
├── test/                       # Test files
│   ├── unit/                  # Unit tests
│   ├── widget/                # Widget tests
│   └── integration/           # Integration tests
│
├── pubspec.yaml               # Dependencies & assets
├── analysis_options.yaml      # Linter rules
├── README.md                  # Project documentation
└── JOBDESK_TIM.md            # This file!
```

---

### **🎯 Domain Mapping per Anggota**

| Anggota | Folder/Files yang Dikerjakan |
|---------|------------------------------|
| **M SULTHON ALFARIZKY** | `lib/data/repositories/firebase_*`<br>`lib/core/services/firebase_service.dart` |
| **Anggota 2** | `lib/features/transactions/`<br>`lib/features/categories/` |
| **Anggota 3** | `lib/features/analytics/`<br>`lib/features/home/widgets/` (dashboard) |
| **Anggota 4** | `lib/features/notifications/`<br>`lib/features/settings/`<br>`lib/features/budget/` |
| **Anggota 5** | `lib/features/auth/`<br>`lib/features/profile/` |

---

### **🔧 Common Commands**

```bash
# Development
flutter run                    # Run app
flutter run --release         # Run in release mode
flutter build apk             # Build APK for Android

# Testing
flutter test                  # Run all tests
flutter test test/widget/     # Run widget tests only
flutter test --coverage       # Run with coverage report

# Code Quality
flutter analyze               # Check for errors/warnings
dart format .                 # Format all dart files
dart fix --apply              # Auto-fix linter issues

# Dependencies
flutter pub get               # Install dependencies
flutter pub upgrade           # Upgrade dependencies
flutter pub outdated          # Check outdated packages

# Clean & Rebuild
flutter clean                 # Clean build files
flutter pub get               # Reinstall dependencies
flutter run                   # Run again

# Git Commands (Quick Reference)
git status                    # Check file changes
git add .                     # Stage all changes
git commit -m "message"       # Commit changes
git push origin branch-name   # Push to remote
git pull origin main          # Pull latest from main
git checkout -b new-branch    # Create new branch
```

---

### **⚡ Productivity Tips**

1. **Hot Reload adalah Teman Terbaik:**
   - Tekan `r` untuk hot reload (cepat!)
   - Tekan `R` untuk hot restart (jika hot reload gagal)

2. **Flutter DevTools:**
   ```bash
   # Jalankan DevTools untuk debugging
   flutter run
   # Tekan 'w' saat app running untuk buka DevTools
   ```

3. **VS Code Snippets:**
   - `stless` → Generate StatelessWidget
   - `stful` → Generate StatefulWidget
   - `constp` → Generate const constructor

4. **Format Code Otomatis:**
   - Shortcut: `Shift + Alt + F` (Windows/Linux)
   - Shortcut: `Shift + Option + F` (Mac)

5. **Emulator Shortcuts:**
   - `Ctrl + M` → Show/hide menu bar
   - Emulator rotate → `Ctrl + Left/Right Arrow`

---

### **🆘 Troubleshooting Common Issues**

**Issue: "Waiting for another flutter command to release the startup lock"**
```bash
# Solution:
killall -9 dart  # Mac/Linux
taskkill /F /IM dart.exe  # Windows
```

**Issue: "Gradle build failed"**
```bash
# Solution:
cd android
./gradlew clean  # Linux/Mac
gradlew.bat clean  # Windows
cd ..
flutter clean
flutter pub get
flutter run
```

**Issue: "Version solving failed"**
```bash
# Solution:
flutter pub upgrade
# atau hapus pubspec.lock dan coba lagi
rm pubspec.lock
flutter pub get
```

**Issue: Hot reload tidak work**
```bash
# Solution: Stop app dan run lagi, atau
# Tekan 'R' untuk hot restart
```

---

### **📞 Butuh Bantuan?**

1. **Check Dokumentasi:**
   - Flutter Docs: https://docs.flutter.dev
   - This file: JOBDESK_TIM.md

2. **Tanya di WhatsApp Group:**
   - Format: "[HELP] Judul masalah + screenshot error"

3. **Create GitHub Issue:**
   - Untuk bug atau feature request formal

4. **Stack Overflow:**
   - Tag: `flutter`, `dart`, `riverpod`

---

## 📚 Resources & References

### **📖 Official Documentation**

#### **Flutter & Dart:**
- 📘 [Flutter Docs](https://docs.flutter.dev/) - Official Flutter documentation
- 📗 [Dart Language Tour](https://dart.dev/guides/language/language-tour) - Learn Dart basics
- 📙 [Flutter Cookbook](https://docs.flutter.dev/cookbook) - Common Flutter recipes
- 📕 [Widget Catalog](https://docs.flutter.dev/development/ui/widgets) - All Flutter widgets

#### **State Management:**
- 🔵 [Riverpod Documentation](https://riverpod.dev/) - Official Riverpod docs
- 🔵 [Riverpod Examples](https://github.com/rrousselGit/river_pod/tree/master/examples) - Code examples

#### **Backend & Database:**
- 🔥 [Firebase for Flutter](https://firebase.flutter.dev/) - FlutterFire documentation
- 🔥 [Firebase Console](https://console.firebase.google.com/) - Manage Firebase project
- 🔥 [Firestore Documentation](https://firebase.google.com/docs/firestore) - Cloud Firestore guide

#### **UI/UX Libraries:**
- 📊 [FL Chart](https://github.com/imaNNeo/fl_chart) - Chart library documentation
- 🎨 [Google Fonts](https://pub.dev/packages/google_fonts) - Custom fonts package
- ✨ [Flutter Animate](https://pub.dev/packages/flutter_animate) - Animation library

---

### **🎨 Design System Reference**

#### **Color Palette:**
```dart
// Primary Colors
Primary: #0BA28A (Teal) - Main brand color
Primary Dark: #078A73
Primary Light: #4DD2B9

// Semantic Colors
Income: #079B4B (Green)
Expense: #DA3D2A (Red)
Warning: #F2A438 (Orange)

// Neutral Colors
Background: #F5F7FA
Card: #FFFFFF
Text Primary: #1A1A1A
Text Secondary: #6B7280
Border: #E5E7EB

// Gradient (for backgrounds)
Gradient Start: #0BA28A
Gradient End: #4DD2B9
```

#### **Typography:**
```dart
Font Family: Default Flutter (Roboto on Android, SF Pro on iOS)

Sizes:
- Heading 1: 32px, Bold
- Heading 2: 24px, Bold
- Heading 3: 20px, SemiBold
- Body Large: 16px, Regular
- Body: 14px, Regular
- Caption: 12px, Regular
```

#### **Spacing:**
```dart
Spacing.xs: 4px
Spacing.sm: 8px
Spacing.md: 16px
Spacing.lg: 24px
Spacing.xl: 32px
Spacing.xxl: 48px
```

#### **Border Radius:**
```dart
Radii.sm: 8px
Radii.md: 12px
Radii.lg: 16px
Radii.xl: 24px
```

---

### **💡 Code Examples to Study**

#### **📂 Reusable Widgets:**
```dart
lib/widgets/brand_background.dart     // Gradient background dengan circles
lib/widgets/app_logo.dart             // Logo dengan animasi
lib/widgets/balance_card.dart         // Card dengan gradient & shimmer
lib/widgets/transaction_tile.dart     // Transaction list item dengan colored border
lib/widgets/empty_state.dart          // Empty state dengan icon/illustration
```

#### **📱 Screen Examples:**
```dart
lib/features/home/home_screen.dart        // Layout dengan Stack, animations
lib/features/splash/splash_screen.dart    // Splash dengan layered animations
lib/features/auth/login_screen.dart       // Form dengan validation
lib/features/categories/categories_screen.dart  // List dengan Dismissible
lib/features/analytics/analytics_screen.dart    // Charts dengan fl_chart
```

#### **🔧 Core Utilities:**
```dart
lib/core/design_system.dart           // Design tokens (Spacing, Radii, Shadows)
lib/core/theme.dart                   // Theme configuration & extensions
lib/core/router.dart                  // GoRouter configuration
lib/data/models/transaction.dart      // Model example dengan JSON serialization
```

---

### **📺 Video Tutorials (Recommended)**

#### **Flutter Basics:**
- [Flutter Tutorial for Beginners](https://www.youtube.com/watch?v=1ukSR1GRtMU) - FreeCodeCamp
- [Flutter Course](https://www.youtube.com/watch?v=VPvVD8t02U8) - Academind

#### **State Management:**
- [Riverpod 2.0 Complete Guide](https://www.youtube.com/watch?v=RZI5L9gi8QU) - Riverpod Creator
- [Flutter Riverpod Tutorial](https://www.youtube.com/watch?v=ypfqfJrPKrQ) - The Net Ninja

#### **Firebase Integration:**
- [Flutter & Firebase Setup](https://www.youtube.com/watch?v=sfA3NWDBPZ4) - Flutter Official
- [Firebase Auth Tutorial](https://www.youtube.com/watch?v=rWamixHIKmQ) - CodeWithAndrea

---

### **📦 Important Packages (Already in pubspec.yaml)**

```yaml
# State Management
flutter_riverpod: ^2.6.1           # State management

# Routing
go_router: ^14.6.2                 # Navigation & routing

# UI/Animation
flutter_animate: ^4.5.0            # Easy animations
flutter_svg: ^2.0.16               # SVG support
fl_chart: ^0.70.1                  # Charts & graphs

# Backend
firebase_core: ^3.10.0             # Firebase core
firebase_auth: ^5.3.4              # Firebase authentication
cloud_firestore: ^5.6.0            # Firestore database

# Local Storage
shared_preferences: ^2.3.4         # Key-value storage
path_provider: ^2.1.5              # File system paths

# Notifications
flutter_local_notifications: ^18.0.1  # Local notifications

# Utils
intl: ^0.19.0                      # Internationalization & formatting
```

---

### **🔗 Useful Links**

#### **Flutter Community:**
- [r/FlutterDev](https://www.reddit.com/r/FlutterDev/) - Reddit community
- [Flutter Discord](https://discord.gg/flutter) - Discord server
- [Flutter YouTube](https://www.youtube.com/c/flutterdev) - Official channel

#### **Design Inspiration:**
- [Dribbble - Finance App](https://dribbble.com/search/finance-app) - UI inspiration
- [Material Design 3](https://m3.material.io/) - Material Design guidelines
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/) - iOS design

#### **Code Quality:**
- [Effective Dart](https://dart.dev/guides/language/effective-dart) - Dart style guide
- [Flutter Best Practices](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options) - Best practices

#### **Package Repository:**
- [pub.dev](https://pub.dev/) - Flutter packages repository

---

### **🎓 Learning Path per Anggota**

#### **M SULTHON ALFARIZKY (Backend Developer):**
Must Learn:
- [ ] Firebase Console navigation
- [ ] Firestore data structure & queries
- [ ] Firebase Auth methods
- [ ] Repository pattern implementation

Resources:
- Firebase for Flutter Codelab
- Firestore Security Rules documentation

---

#### **Anggota 2 (Transactions & Categories):**
Must Learn:
- [ ] Form validation di Flutter
- [ ] DatePicker & TimePicker widgets
- [ ] ListView & GridView optimization
- [ ] Dismissible widget untuk swipe actions

Resources:
- Flutter Form Validation tutorial
- Building Scrollable Lists in Flutter

---

#### **Anggota 3 (Analytics & Visualization):**
Must Learn:
- [ ] FL Chart library (PieChart, LineChart, BarChart)
- [ ] Data transformation untuk charts
- [ ] PDF generation dengan pdf package
- [ ] Date range filtering

Resources:
- FL Chart Documentation & Examples
- Flutter PDF Generation tutorial

---

#### **Anggota 4 (Notifications & Settings):**
Must Learn:
- [ ] flutter_local_notifications setup
- [ ] Scheduled notifications
- [ ] Theme switching (dark/light mode)
- [ ] SharedPreferences untuk settings

Resources:
- Flutter Local Notifications guide
- Theme Management in Flutter

---

#### **Anggota 5 (Profile & Auth):**
Must Learn:
- [ ] Form validation advanced
- [ ] Image picker & upload
- [ ] Firebase Auth error handling
- [ ] Email/password authentication flow

Resources:
- Firebase Auth Flutter Documentation
- Image Picker Flutter Package

---

### **📋 Cheat Sheets**

#### **Git Cheat Sheet:**
```bash
# Status & Info
git status                    # Check status
git log --oneline            # View commit history
git branch                   # List branches

# Branching
git checkout main            # Switch to main
git pull origin main         # Update main
git checkout -b feature/xyz  # Create & switch to new branch

# Committing
git add .                    # Stage all changes
git commit -m "message"      # Commit
git push origin branch-name  # Push to remote

# Syncing
git fetch origin             # Fetch updates
git merge origin/main        # Merge main into current branch
git rebase origin/main       # Rebase current branch

# Undo
git reset HEAD~1             # Undo last commit (keep changes)
git checkout -- file.dart    # Discard changes in file
git stash                    # Stash changes temporarily
git stash pop                # Restore stashed changes
```

#### **Flutter Widget Cheat Sheet:**
```dart
// Layout Widgets
Container(), Padding(), Center(), Align()
Row(), Column(), Stack(), Positioned()
SizedBox(), Expanded(), Flexible()

// Scrollable Widgets
ListView(), GridView(), SingleChildScrollView()
CustomScrollView(), SliverList()

// Input Widgets
TextField(), TextFormField(), Checkbox()
Radio(), Switch(), Slider(), DropdownButton()

// Button Widgets
ElevatedButton(), TextButton(), IconButton()
FloatingActionButton()

// Display Widgets
Text(), Image(), Icon(), CircleAvatar()
Card(), ListTile(), Chip(), Divider()

// Navigation
Navigator.push(), Navigator.pop()
GoRouter.go(), GoRouter.push()
```

---

### **🎯 Pro Tips**

1. **Selalu cek dokumentasi package di pub.dev sebelum pakai**
2. **Gunakan const untuk widget yang tidak berubah (performance!)**
3. **Extract widget jika sudah terlalu kompleks (> 100 baris)**
4. **Gunakan Theme.of(context) untuk akses theme colors**
5. **Hot reload untuk UI changes, hot restart untuk logic changes**
6. **Gunakan DevTools untuk debugging performance issues**
7. **Test di real device, bukan hanya emulator**
8. **Commit code setiap hari, minimal 1 commit**

---

## ⚠️ Important Notes

1. **Jangan langsung push ke branch main** - Selalu buat Pull Request
2. **Backup kode secara berkala** - Commit minimal 1x sehari
3. **Komunikasikan blocker segera** - Jangan menunggu sampai terlambat
4. **Code review itu penting** - Belajar dari code orang lain
5. **Testing itu wajib** - Jangan skip testing phase

---

## 🏆 Bonus Tasks (Optional)

Jika ada waktu lebih, bisa dikerjakan:
- [ ] Implementasi biometric authentication (fingerprint/face ID)
- [ ] Multi-currency support
- [ ] Sync data antar device
- [ ] Widget untuk home screen Android
- [ ] Apple Watch / Wear OS companion app
- [ ] Localization (multi-bahasa: ID, EN)
- [ ] Social sharing untuk laporan keuangan

---

## 📝 Progress Tracking

Gunakan GitHub Projects atau Trello untuk tracking:
- **Backlog:** Task yang belum dimulai
- **In Progress:** Sedang dikerjakan
- **Review:** Menunggu code review
- **Done:** Sudah selesai dan merged

**Link Progress Board:** [Akan diisi setelah dibuat]

---

## 📧 Contact Person

**Project Leader:** [Nama M SULTHON ALFARIZKY]
- Email: [email]
- Phone: [nomor]

**Bantuan Teknis:** Semua anggota tim saling membantu!

---

**Good luck team! Mari kita buat aplikasi DanaKu menjadi aplikasi manajemen keuangan terbaik! 💪🚀**
