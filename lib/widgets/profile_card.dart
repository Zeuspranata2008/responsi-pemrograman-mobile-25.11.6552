import 'package:flutter/material.dart';

import '../models/student.dart';

/// Kartu profil mahasiswa (hanya UI, tanpa logika).
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 44,
              child: Text(student.initials, style: t.headlineMedium),
            ),
            const SizedBox(height: 16),
            Text(student.name, style: t.titleLarge),
            const SizedBox(height: 16),
            _row(Icons.badge, 'NIM', student.nim),
            _row(Icons.school, 'Program Studi', student.programStudi),
            _row(Icons.email, 'Email', student.email),
          ],
        ),
      ),
    );
  }

  Widget _row(IconData icon, String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 12),
            Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
            Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
          ],
        ),
      );
}
