import 'package:flutter/material.dart';
import 'login.dart';
import '../helpers/user_info.dart';
import 'changepw.dart';
import '../services/post_service.dart';
import '../models/post.dart';
import 'complaint.dart';

class AccountScreen extends StatelessWidget {
  late String userId; // Variabel global untuk menyimpan user ID
  Stream<List<Post>> getList() async* {
    List<Post> data = await PostService().listData();
    yield data;
  }

  String _truncateCaption(String caption) {
    const int maxCharacters = 20; // Batasan maksimum karakter

    // Menghapus karakter enter dan karakter baris baru
    String sanitizedCaption = caption.replaceAll('\n', ' ');

    if (sanitizedCaption.length <= maxCharacters) {
      return sanitizedCaption;
    }

    return sanitizedCaption.substring(0, maxCharacters) + '...';
  }

  UserInfo userInfo = UserInfo();

  Future<Map<String, String>> _getUserInfo() async {
    String? username = await userInfo.getUsername();
    String? email = await userInfo.getToken();
    String? profile_image = await userInfo.getProfileImage();
    String? user_id = await userInfo.getUserID();
    userId = user_id ?? '';
    return {
      'username': username ?? '',
      'email': email ?? '',
      'profile_image': profile_image ?? '',
      'user_id': user_id ?? '',
    };
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
            Text('Akun'),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: _getUserInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error occurred'));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'http://192.168.43.241:8000/storage/profile/' +
                              (snapshot.data['profile_image'] ?? '')),
                    ),
                    // const Icon(
                    //   Icons
                    //       .account_circle, // Ganti dengan ikon profil yang sesuai
                    //   size: 80,
                    //   color: Colors.grey, // Ganti dengan warna ikon yang sesuai
                    // ),

                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data['username'] ??
                              'User', // Ganti dengan nama pengguna
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          snapshot.data['email'] ??
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
                    height: 140, // Tentukan tinggi card
                    child: StreamBuilder(
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
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.data[index].userId !=
                                int.parse(userId)) {
                              return Container();
                            }
                            return Card(
                              child: Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 100,
                                    child: snapshot.data[index].image !=
                                            'blank.png'
                                        ? Image.network(
                                            'http://192.168.43.241:8000/storage/' +
                                                snapshot.data[index].image,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, exception,
                                                stackTrace) {
                                              // Custom error handling for image loading error
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                          Icons.signal_wifi_off,
                                                          size: 32),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : Icon(Icons.hide_image,
                                            size: 64,
                                            color: Colors
                                                .grey), // Menampilkan ikon "image_off" jika image adalah "blank.png"
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _truncateCaption(
                                          snapshot.data[index].content),
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )),
                SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.mail),
                  title: Text('Semua Aduan'),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllComplaintsScreen()),
                      (route) => false,
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Ubah Password'),
                  onTap: () {
                    // Tambahkan logika untuk menangani aksi ubah password
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()),
                      (route) => false,
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () async {
                    // Tambahkan logika untuk menangani aksi logout di sini
                    UserInfo userInfo = UserInfo();
                    await userInfo.logout();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
