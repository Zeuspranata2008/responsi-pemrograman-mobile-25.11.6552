import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../models/note.dart';
import '../models/student.dart';
import '../repositories/note_repository.dart';

/// InheritedWidget penyedia state aplikasi ke seluruh subtree.
class AppProvider extends InheritedWidget {
  const AppProvider({
    super.key,
    required this.student,
    required this.notes,
    required this.isLoading,
    required this.errorMessage,
    required this.updateStudent,
    required this.addNote,
    required this.deleteNote,
    required super.child,
  });

  final Student student;
  final List<Note> notes;
  final bool isLoading;
  final String? errorMessage;
  final Future<void> Function(Student) updateStudent;
  final Future<void> Function(Note) addNote;
  final Future<void> Function(String) deleteNote;

  /// Mengambil [AppProvider] terdekat dari [context].
  static AppProvider of(BuildContext context) {
    final p = context.dependOnInheritedWidgetOfExactType<AppProvider>();
    assert(p != null, 'AppProvider tidak ditemukan di widget tree');
    return p!;
  }

  @override
  bool updateShouldNotify(AppProvider old) =>
      !identical(student, old.student) ||
      !identical(notes, old.notes) ||
      isLoading != old.isLoading ||
      errorMessage != old.errorMessage;
}

/// StatefulWidget yang mengelola state dan menyediakan [AppProvider].
class AppProviderWrapper extends StatefulWidget {
  const AppProviderWrapper({super.key, required this.child, this.repository});

  final Widget child;
  final NoteRepository? repository;

  @override
  State<AppProviderWrapper> createState() => _AppProviderWrapperState();
}

class _AppProviderWrapperState extends State<AppProviderWrapper> {
  late final NoteRepository _repo = widget.repository ?? NoteRepository();
  Student _student = Student.initial;
  List<Note> _notes = const [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final s = await _repo.getStudent();
      final n = await _repo.getNotes();
      if (!mounted) return;
      setState(() {
        _student = s;
        _notes = n;
        _loading = false;
        _error = null;
      });
    } catch (_) {
      // Jangan cetak detail/isi data ke log.
      debugPrint('Gagal memuat data lokal');
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Gagal memuat data. Coba lagi.';
      });
    }
  }

  Future<void> _updateStudent(Student s) async {
    await _repo.saveStudent(s);
    setState(() => _student = s);
  }

  Future<void> _addNote(Note n) async {
    await _repo.addNote(n);
    setState(() => _notes = [n, ..._notes]);
  }

  Future<void> _deleteNote(String id) async {
    await _repo.deleteNote(id);
    setState(() => _notes = _notes.where((e) => e.id != id).toList());
  }

  @override
  Widget build(BuildContext context) => AppProvider(
        student: _student,
        notes: _notes,
        isLoading: _loading,
        errorMessage: _error,
        updateStudent: _updateStudent,
        addNote: _addNote,
        deleteNote: _deleteNote,
        child: widget.child,
      );
}
