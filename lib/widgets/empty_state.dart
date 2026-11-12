import 'package:flutter/material.dart';

/// Tampilan saat daftar kosong / error.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.message = 'Belum ada catatan.\nTekan + untuk menambah.',
    this.icon = Icons.note_alt_outlined,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 72, color: Theme.of(context).disabledColor),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      );
}
