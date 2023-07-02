import 'package:flutter/material.dart';
import '../services/post_service.dart';
import '../models/post.dart';

class FeedScreen extends StatelessWidget {
  Stream<List<Post>> getList() async* {
    List<Post> data = await PostService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CivilHub'),
      ),
      body: StreamBuilder(
        stream: getList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('Data Kosong');
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
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
                            'http://192.168.43.241:8000/storage/' +
                                snapshot.data[index].image,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, exception, stackTrace) {
                              // Custom error handling for image loading error
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        16), // Tambahkan padding di atas dan di bawah
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.network_check, size: 64),
                                      SizedBox(height: 16),
                                      Text(
                                          'Gambar gagal di muat, periksa jaringan anda'),
                                    ],
                                  ),
                                ),
                              );
                            },
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
                              //share icon
                              // child: IconButton(
                              //   icon: Icon(Icons
                              //       .share), // Ganti dengan ikon berbagi yang sesuai
                              //   color: Colors
                              //       .white, // Ubah warna ikon sesuai keinginan
                              //   onPressed: () {
                              //     // Tambahkan logika untuk berbagi postingan
                              //   },
                              // ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        snapshot.data[index].content,
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
                            snapshot.data[index].isAnonymous
                                ? 'Anonim'
                                : 'Pengadu ' +
                                    snapshot.data[index].userId.toString(),
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
          );
        },
      ),
    );
  }
}
