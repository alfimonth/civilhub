// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// Future<void> requestGalleryPermission() async {
//   PermissionStatus status = await Permission.storage.request();
//   if (status.isGranted) {
//     // Izin akses diberikan, lanjutkan logika mengunggah gambar
//     return true;
//   } else if (status.isDenied) {
//     // Pengguna menolak izin akses galeri
//     // Tampilkan pesan ke pengguna atau lakukan tindakan lain
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Akses Dibutuhkan'),
//           content: Text(
//               'Aplikasi membutuhkan akses ke galeri untuk mengunggah gambar. Silakan berikan izin akses galeri.'),
//           actions: [
//             TextButton(
//               child: Text('Batal'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Pengaturan'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 openAppSettings();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   } else if (status.isPermanentlyDenied) {
//     // Pengguna secara permanen menolak izin akses galeri
//     // Tampilkan pesan ke pengguna atau lakukan tindakan lain, misalnya membuka pengaturan aplikasi
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Akses Dibutuhkan'),
//           content: Text(
//               'Aplikasi membutuhkan akses ke galeri untuk mengunggah gambar. Silakan berikan izin akses galeri.'),
//           actions: [
//             TextButton(
//               child: Text('Tutup'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
