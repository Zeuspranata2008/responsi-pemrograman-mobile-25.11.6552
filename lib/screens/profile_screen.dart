import 'package:flutter/material.dart';

import '../models/student.dart';
import '../providers/app_provider.dart';
import '../utils/validators.dart';
import '../widgets/profile_card.dart';

/// Layar profil mahasiswa + tombol Edit Profil.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _edit(BuildContext context) async {
    final app = AppProvider.of(context);
    final result = await showDialog<Student>(
      context: context,
      builder: (_) => _EditProfileDialog(initial: app.student),
    );
    if (result != null) {
      await app.updateStudent(result);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Profil diperbarui')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final student = AppProvider.of(context).student;
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Mahasiswa')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ProfileCard(student: student),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => _edit(context),
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profil'),
          ),
        ],
      ),
    );
  }
}

class _EditProfileDialog extends StatefulWidget {
  const _EditProfileDialog({required this.initial});
  final Student initial;

  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.initial.name);
  late final _nim = TextEditingController(text: widget.initial.nim);
  late final _prodi = TextEditingController(text: widget.initial.programStudi);
  late final _email = TextEditingController(text: widget.initial.email);

  @override
  void dispose() {
    _name.dispose();
    _nim.dispose();
    _prodi.dispose();
    _email.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      Student(
        name: Validators.sanitize(_name.text),
        nim: Validators.sanitize(_nim.text),
        programStudi: Validators.sanitize(_prodi.text),
        email: Validators.sanitize(_email.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Edit Profil'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Nama'),
                  validator: Validators.validateName),
              TextFormField(
                  controller: _nim,
                  decoration: const InputDecoration(labelText: 'NIM'),
                  validator: Validators.validateNim),
              TextFormField(
                  controller: _prodi,
                  decoration: const InputDecoration(labelText: 'Program Studi'),
                  validator: Validators.validateProdi),
              TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: Validators.validateEmail),
            ]),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal')),
          FilledButton(onPressed: _save, child: const Text('Simpan')),
        ],
      );
}
