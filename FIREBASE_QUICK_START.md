# 🔥 Firebase Integration - Quick Reference

**Project Leader:** M SULTHON ALFARIZKY

---

## ⚡ Quick Setup Commands

```bash
# 1. Install Firebase Tools
npm install -g firebase-tools
firebase login

# 2. Install FlutterFire CLI
dart pub global activate flutterfire_cli

# 3. Configure Firebase
flutterfire configure

# 4. Test run
flutter pub get
flutter run
```

---

## 📋 Pre-Integration Checklist

- [ ] Firebase Console: Project created
- [ ] Firebase Console: Email/Password auth enabled
- [ ] Firebase Console: Firestore database created
- [ ] Local: FlutterFire CLI installed
- [ ] Local: `flutterfire configure` completed
- [ ] Local: `firebase_options.dart` generated

---

## 🔄 Switch Backend

**File:** `lib/core/app_config.dart`

```dart
// BEFORE (Current - Local Storage):
const appBackend = AppBackend.local;

// AFTER (Target - Firebase):
const appBackend = AppBackend.firebase;
```

**⚠️ Remember:** Hot restart app setelah perubahan ini!

---

## 🏗️ Firestore Structure

```
firestore/
└── users/
    └── {userId}/
        ├── transactions/
        │   └── {transactionId}
        │       ├── id: string
        │       ├── amount: number
        │       ├── categoryId: string
        │       ├── date: timestamp
        │       ├── description: string
        │       └── type: "income" | "expense"
        │
        └── categories/
            └── {categoryId}
                ├── id: string
                ├── name: string
                ├── icon: string
                └── color: string
```

---

## 🔒 Firestore Security Rules (Copy-Paste Ready)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    function isSignedIn() {
      return request.auth != null;
    }
    
    function isOwner(userId) {
      return isSignedIn() && request.auth.uid == userId;
    }
    
    match /users/{userId} {
      allow read, write: if isOwner(userId);
      
      match /transactions/{transactionId} {
        allow read, write: if isOwner(userId);
      }
      
      match /categories/{categoryId} {
        allow read, write: if isOwner(userId);
      }
      
      match /profile/{document=**} {
        allow read, write: if isOwner(userId);
      }
    }
  }
}
```

---

## 🧪 Testing Flow

### 1. Test Authentication
```
1. Run app
2. Register: test@example.com / password123
3. Check Firebase Console → Authentication → Users
4. Logout
5. Login kembali dengan credential yang sama
6. Success!
```

### 2. Test Transactions
```
1. Login
2. Add transaction (Pemasukan/Pengeluaran)
3. Check Firebase Console → Firestore → users/{uid}/transactions
4. Document baru muncul? ✅
5. Edit transaction → data berubah? ✅
6. Delete transaction → data hilang? ✅
```

### 3. Test Multi-Device Sync
```
1. Login di device A
2. Add transaction
3. Login di device B dengan user yang sama
4. Transaction muncul? ✅ Sync berhasil!
```

---

## 🐛 Common Issues & Quick Fix

### Issue: Firebase not initialized
```dart
// Fix: Pastikan di main.dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

### Issue: google-services.json not found
```bash
# Solution: Run configure lagi
flutterfire configure
```

### Issue: User ID null after login
```dart
// Fix: Gunakan authStateChanges
FirebaseAuth.instance.authStateChanges().listen((user) {
  if (user != null) {
    // User logged in, refresh providers
    ref.invalidate(transactionsProvider);
  }
});
```

### Issue: Permission denied
```
Check Firestore Rules:
- Rules sudah di-publish?
- User authenticated?
- userId match dengan document path?
```

---

## 📊 Implementation Timeline

### Week 1: Setup & Auth
- Day 1-2: Firebase Console setup
- Day 3-4: FlutterFire configuration
- Day 5-7: Authentication testing

### Week 2: Firestore & Finish
- Day 1-2: Transactions integration
- Day 3-4: Categories integration
- Day 5: Security rules
- Day 6-7: Testing & documentation

---

## ✅ Done Criteria

Integration DONE jika:
- ✅ Register/Login/Logout works
- ✅ Transactions saved to Firestore
- ✅ Categories saved to Firestore
- ✅ Data persists after app restart
- ✅ Multi-device sync works
- ✅ Security rules configured
- ✅ Demo successful ke tim

---

## 📞 Need Help?

1. **Read full guide:** `FIREBASE_INTEGRATION_GUIDE.md`
2. **Firebase Docs:** https://firebase.flutter.dev
3. **Ask di WhatsApp Group:** "[HELP] Firebase - [problem]"
4. **Create GitHub Issue:** For bugs/blockers

---

## 🚀 Ready to Start?

```bash
# Step 1: Setup Firebase Console (15 min)
# → Create project
# → Enable auth
# → Create Firestore

# Step 2: Configure FlutterFire (5 min)
flutterfire configure

# Step 3: Switch backend (1 min)
# Edit lib/core/app_config.dart

# Step 4: Test! (30 min)
flutter run
# → Register
# → Login
# → Add transaction
# → Check Firebase Console

# Total time: ~1 hour untuk basic working integration!
```

**Let's go! 💪🔥**
