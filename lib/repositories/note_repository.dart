import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/note.dart';
import '../models/student.dart';
import '../services/secure_storage_service.dart';

/// Repository: satu-satunya pintu akses data catatan & profil.
///
/// Metadata -> SharedPreferences (JSON list); isi -> secure storage.
class NoteRepository {
  NoteRepository({SecureStorageService? secure})
      : _secure = secure ?? SecureStorageService();

  final SecureStorageService _secure;
  static const _notesKey = 'notes_metadata';
  static const _studentKey = 'student_profile';

  Future<List<Map<String, dynamic>>> _readMeta() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_notesKey);
    if (raw == null || raw.isEmpty) return [];
    return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
  }

  Future<void> _writeMeta(List<Map<String, dynamic>> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_notesKey, jsonEncode(list));
  }

  /// Mengambil semua catatan (terbaru di atas) beserta isinya.
  Future<List<Note>> getNotes() async {
    final metas = await _readMeta();
    final notes = <Note>[];
    for (final m in metas) {
      final content = await _secure.getContent(m['id'] as String) ?? '';
      notes.add(Note.fromMeta(m, content));
    }
    notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return notes;
  }

  /// Menyimpan catatan baru (metadata + isi terenkripsi).
  Future<void> addNote(Note note) async {
    await _secure.saveContent(note.id, note.content);
    final metas = await _readMeta()
      ..add(note.toMetaJson());
    await _writeMeta(metas);
  }

  /// Menghapus catatan berdasarkan [id] (metadata + isi).
  Future<void> deleteNote(String id) async {
    await _secure.deleteContent(id);
    final metas = await _readMeta()
      ..removeWhere((m) => m['id'] == id);
    await _writeMeta(metas);
  }

  /// Memuat profil mahasiswa tersimpan, atau [Student.initial].
  Future<Student> getStudent() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_studentKey);
    if (raw == null) return Student.initial;
    return Student.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  /// Menyimpan profil mahasiswa.
  Future<void> saveStudent(Student s) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_studentKey, jsonEncode(s.toJson()));
  }
}
