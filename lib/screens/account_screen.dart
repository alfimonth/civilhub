import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const CircleAvatar(
                //   radius: 40,
                //   backgroundImage: NetworkImage('https://example.com/profile_image.jpg'), // Ganti dengan URL gambar profil
                // ),
                const Icon(
                  Icons.account_circle, // Ganti dengan ikon profil yang sesuai
                  size: 80,
                  color: Colors.grey, // Ganti dengan warna ikon yang sesuai
                ),

                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Pengguna', // Ganti dengan nama pengguna
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'email@example.com', // Ganti dengan alamat email
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Tambahkan logika untuk mengubah profil pengguna
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Riwayat Aduan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              height: 120, // Tentukan tinggi card
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Ganti dengan jumlah postingan yang sebenarnya
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: [
                        Container(
                          width: 100, // Tentukan lebar gambar
                          height: 80, // Tentukan tinggi gambar
                          child: Image.network(
                            'https://picsum.photos/200/300',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Caption Postingan',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text('Semua Aduan'),
              onTap: () {
                // Tambahkan logika untuk menangani aksi ubah password
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Ubah Password'),
              onTap: () {
                // Tambahkan logika untuk menangani aksi ubah password
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Tambahkan logika untuk menangani aksi logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
