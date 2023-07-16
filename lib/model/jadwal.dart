
class Jadwal {
  final int id_jadwal;
  final String judul_pertemuan;
  final String jam_masuk;
  final String matakuliah;
  final String nama_dosen;

  Jadwal({required this.id_jadwal, required this.judul_pertemuan, required this.jam_masuk, required this.matakuliah, required this.nama_dosen});

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      id_jadwal: json['id'], 
      judul_pertemuan: json['judul_pertemuan'], 
      jam_masuk: json['jam_masuk'], 
      matakuliah: json['matakuliah'], 
      nama_dosen: json['nama_dosen']
    );
  }
}