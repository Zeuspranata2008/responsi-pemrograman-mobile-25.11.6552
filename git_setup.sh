#!/usr/bin/env bash
# Jalankan di root proyek Flutter (setelah flutter create + salin lib/).
set -e
git init -b main
git add .gitignore pubspec.yaml .env.example android_patch README.md 2>/dev/null || git add .gitignore pubspec.yaml .env.example
git commit -m "chore: inisialisasi proyek Flutter dan .gitignore"

git add lib/config lib/utils/validators.dart
git commit -m "feat: tambah AppConfig (.env) dan validators"

git checkout -b fitur-profil
git add lib/models/student.dart lib/widgets/profile_card.dart
git commit -m "feat(profil): model Student dan ProfileCard"
git add lib/screens/profile_screen.dart
git commit -m "feat(profil): ProfileScreen dengan edit profil"
git checkout main && git merge --no-ff fitur-profil -m "merge: fitur-profil"

git checkout -b fitur-catatan
git add lib/models/note.dart lib/services/secure_storage_service.dart lib/repositories
git commit -m "feat(catatan): model Note, SecureStorageService, NoteRepository"
git add lib/providers lib/screens/note_form_screen.dart
git commit -m "feat(catatan): AppProvider dan NoteFormScreen dengan validasi"
git add lib/widgets/note_card.dart lib/widgets/empty_state.dart lib/screens/home_screen.dart lib/main.dart
git commit -m "feat(catatan): HomeScreen, NoteCard, EmptyState, tema"
git checkout main && git merge --no-ff fitur-catatan -m "merge: fitur-catatan"

git add lib/services/api_service.dart lib/screens/users_screen.dart
git commit -m "feat: HTTP GET /users dengan error handling"
git add -A && git commit -m "docs: finalisasi proyek" || true
git log --graph --oneline --all
