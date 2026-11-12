/// Model catatan kuliah.
///
/// Metadata (id, judul, tanggal) disimpan di SharedPreferences,
/// sedangkan [content] disimpan terenkripsi di secure storage.
class Note {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  /// JSON metadata saja — TIDAK menyertakan [content].
  Map<String, dynamic> toMetaJson() => {
        'id': id,
        'title': title,
        'createdAt': createdAt.toIso8601String(),
      };

  /// Membuat [Note] dari metadata JSON dan isi catatan.
  factory Note.fromMeta(Map<String, dynamic> j, String content) => Note(
        id: j['id'] as String,
        title: j['title'] as String? ?? '',
        content: content,
        createdAt:
            DateTime.tryParse(j['createdAt'] as String? ?? '') ?? DateTime.now(),
      );
}
