/// Kumpulan validasi & sanitasi input pengguna.
class Validators {
  Validators._();

  /// Validasi judul: 3–50 karakter.
  static String? validateTitle(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Judul wajib diisi';
    if (s.length < 3) return 'Judul minimal 3 karakter';
    if (s.length > 50) return 'Judul maksimal 50 karakter';
    return null;
  }

  /// Validasi isi catatan: 10–1000 karakter.
  static String? validateContent(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Isi catatan wajib diisi';
    if (s.length < 10) return 'Isi minimal 10 karakter';
    if (s.length > 1000) return 'Isi maksimal 1000 karakter';
    return null;
  }

  /// Validasi nama: 3–50 karakter.
  static String? validateName(String? v) {
    final s = (v ?? '').trim();
    if (s.length < 3) return 'Nama minimal 3 karakter';
    if (s.length > 50) return 'Nama maksimal 50 karakter';
    return null;
  }

  /// Validasi NIM: angka dan titik, 8–15 karakter.
  static String? validateNim(String? v) {
    final s = (v ?? '').trim();
    if (!RegExp(r'^[0-9.]{8,15}$').hasMatch(s)) {
      return 'NIM hanya angka/titik (8–15 karakter)';
    }
    return null;
  }

  /// Validasi program studi: wajib diisi.
  static String? validateProdi(String? v) =>
      (v ?? '').trim().isEmpty ? 'Program studi wajib diisi' : null;

  /// Validasi format email.
  static String? validateEmail(String? v) {
    final s = (v ?? '').trim();
    if (!RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$').hasMatch(s)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  /// Membersihkan karakter berbahaya (`<`, `>`, `"`, `'`) dan spasi di tepi.
  static String sanitize(String input) =>
      input.replaceAll(RegExp(r'''[<>"']'''), '').trim();
}
