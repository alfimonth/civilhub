import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Postingan'),
      ),
      body: ListView.builder(
        itemCount: 10, // Ganti dengan jumlah postingan yang sebenarnya
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Stack(
                    children: [
                      Image.network(
                        'https://picsum.photos/200/300', // Ganti dengan URL foto postingan
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(
                                0.5), // Ubah warna dan kecerahan sesuai keinginan
                          ),
                          child: IconButton(
                            icon: Icon(Icons
                                .share), // Ganti dengan ikon berbagi yang sesuai
                            color: Colors
                                .white, // Ubah warna ikon sesuai keinginan
                            onPressed: () {
                              // Tambahkan logika untuk berbagi postingan
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Caption Postingan', // Ganti dengan caption postingan
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons
                            .account_circle, // Ganti dengan ikon profil yang sesuai
                        size: 40,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Nama Pengguna', // Ganti dengan nama pengguna
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons
                            .arrow_upward, // Ubah menjadi ikon arrow up yang sesuai
                        size: 24,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '10', // Ganti dengan vote count yang sesuai
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons
                            .arrow_downward, // Tambahkan ikon arrow down yang sesuai
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
