import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../services/post_service.dart';
import '../models/post.dart';
import '../main.dart';
import '../helpers/user_info.dart';
import '../services/post_service.dart';
import '../models/post.dart';

class AllComplaintsScreen extends StatefulWidget {
  @override
  _AllComplaintsScreenState createState() => _AllComplaintsScreenState();
}

class _AllComplaintsScreenState extends State<AllComplaintsScreen> {
  late String userId;
  final PostService _postService = PostService();

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Stream<List<Post>> getList() async* {
    List<Post> data = await _postService.listData();
    yield data;
  }

  UserInfo userInfo = UserInfo();
  Future<Map<String, String>> _getUserInfo() async {
    String? user_id = await userInfo.getUserID();
    setState(() {
      userId = user_id ?? '';
    });
    return {
      'user_id': user_id ?? '',
    };
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Berhasil'),
          content: Text('Aduan Berhasil di hapus'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllComplaintsScreen()),
                  (route) => false,
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deletePost(Post post) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Anda yakin ingin menghapus aduan ini?'),
            actions: [
              TextButton(
                child: Text('Batal'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Hapus'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _showAlertDialog();
                  await _postService.hapus(post);
                  // Panggil _showAlertDialog setelah menghapus post

                  // Refresh halaman setelah menghapus post
                  refreshPage();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error deleting post: $e');
    }
  }

  void refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semua Aduan'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false,
            );
          },
        ),
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
              if (snapshot.data[index].userId != int.parse(userId)) {
                return Container();
              }
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200,
                            child: Image.network(
                              'http://192.168.43.241:8000/storage/' +
                                  snapshot.data[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.white,
                                onPressed: () {
                                  deletePost(snapshot.data[index]);
                                },
                              ),
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
