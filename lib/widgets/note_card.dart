import 'package:flutter/material.dart';

import '../models/note.dart';

/// Kartu satu catatan dengan tombol hapus.
class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, required this.onDelete});

  final Note note;
  final VoidCallback onDelete;

  String _date(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(note.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          '${_date(note.createdAt)}\n${note.content}',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          tooltip: 'Hapus catatan',
          onPressed: onDelete,
        ),
      ),
    );
  }
}
