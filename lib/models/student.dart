/// Model data mahasiswa.
class Student {
  final String name;
  final String nim;
  final String programStudi;
  final String email;

  const Student({
    required this.name,
    required this.nim,
    required this.programStudi,
    required this.email,
  });

  /// Data awal (default) sebelum pengguna mengedit profil.
  static const Student initial = Student(
    name: 'Nama Mahasiswa',
    nim: '00.00.0000',
    programStudi: 'S1 Informatika',
    email: 'mahasiswa@students.amikom.ac.id',
  );

  /// Inisial nama (maks. 2 huruf) untuk CircleAvatar.
  String get initials {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts[1][0]).toUpperCase();
  }

  /// Salinan dengan sebagian field diubah.
  Student copyWith(
          {String? name, String? nim, String? programStudi, String? email}) =>
      Student(
        name: name ?? this.name,
        nim: nim ?? this.nim,
        programStudi: programStudi ?? this.programStudi,
        email: email ?? this.email,
      );

  /// Konversi ke JSON.
  Map<String, dynamic> toJson() => {
        'name': name,
        'nim': nim,
        'programStudi': programStudi,
        'email': email,
      };

  /// Membuat [Student] dari JSON.
  factory Student.fromJson(Map<String, dynamic> j) => Student(
        name: j['name'] as String? ?? '',
        nim: j['nim'] as String? ?? '',
        programStudi: j['programStudi'] as String? ?? '',
        email: j['email'] as String? ?? '',
      );
}
