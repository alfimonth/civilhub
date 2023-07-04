import 'package:flutter/material.dart';
import '../services/post_service.dart';
import '../models/post.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int voteCount = 10; // Jumlah suara awal
  bool isUpVoted = false; // Apakah tombol "arrow_upward" sudah ditekan
  bool isDownVoted = false; // Apakah tombol "arrow_upward" sudah ditekan

  Stream<List<Post>> getList() async* {
    List<Post> data = await PostService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text('CivilHub'),
          ],
        ),
        automaticallyImplyLeading: false,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                'http://192.168.43.241:8000/storage/profile/' +
                                    (snapshot.data[index].isAnonymous
                                        ? 'x.jpg'
                                        : snapshot.data[index].userId == 2
                                            ? '2.jpg'
                                            : snapshot.data[index].userId == 1
                                                ? '1.jpg'
                                                : snapshot.data[index].userId ==
                                                        3
                                                    ? '3.gif'
                                                    : snapshot.data[index]
                                                                .userId ==
                                                            4
                                                        ? 'x.jpg'
                                                        : 'x.jpg')),
                          ),
                          // Icon(
                          //   Icons.account_circle,
                          //   size: 40,
                          // ),
                          SizedBox(width: 8),
                          Text(
                            snapshot.data[index].isAnonymous
                                ? 'Anonim'
                                : snapshot.data[index].userId == 2
                                    ? 'Kharisma'
                                    : snapshot.data[index].userId == 1
                                        ? 'Ganang Aji'
                                        : snapshot.data[index].userId == 3
                                            ? 'Alfimonth'
                                            : snapshot.data[index].userId == 4
                                                ? 'Villa Yudah'
                                                : 'Pengadu ' +
                                                    snapshot.data[index].userId
                                                        .toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isUpVoted) {
                                  voteCount--; // Mengurangi vote count jika tombol "arrow_upward" sudah ditekan sebelumnya
                                } else {
                                  if (isDownVoted) {
                                    voteCount += 2;
                                    isDownVoted = false;
                                  } else {
                                    voteCount++;
                                  } // Menambah vote count jika tombol "arrow_upward" belum ditekan sebelumnya
                                }
                                isUpVoted =
                                    !isUpVoted; // Mengubah status isUpVoted
                              });
                            },
                            child: Icon(
                              Icons.arrow_upward,
                              size: 24,
                              color: isUpVoted
                                  ? Colors.green
                                  : null, // Mengubah warna ikon jika tombol "arrow_upward" sudah ditekan
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            voteCount.toString(), // Menampilkan vote count
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isDownVoted) {
                                  voteCount++; // Mengurangi vote count jika tombol "arrow_upward" sudah ditekan sebelumnya
                                } else {
                                  if (isUpVoted) {
                                    voteCount -= 2;
                                    isUpVoted = false;
                                  } else {
                                    voteCount--;
                                  } // Menambah vote count jika tombol "arrow_upward" belum ditekan sebelumnya
                                }
                                isDownVoted =
                                    !isDownVoted; // Mengubah status isUpVoted menjadi false
                              });
                            },
                            child: Icon(
                              Icons.arrow_downward,
                              size: 24,
                              color: isDownVoted
                                  ? Colors.red
                                  : null, // Mengubah warna ikon jika tombol "arrow_downward" sudah ditekan
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      if (snapshot.data[index].image != 'blank.png')
                        Stack(
                          children: [
                            Image.network(
                              'http://192.168.43.241:8000/storage/' +
                                  // 'http://172.19.128.24:8000/storage/' +
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.signal_wifi_off, size: 64),
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
