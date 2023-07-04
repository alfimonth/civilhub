import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import '../models/post.dart';
import '../services/post_service.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../helpers/user_info.dart';
import '../services/post_service.dart';
import '../models/post.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  late String userId;

  String? _imageUrl;
  bool _sendToAnonymous = false;
  TextEditingController _captionController = TextEditingController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  PostService _postService = PostService();

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
          title: Text('Upload Berhasil'),
          content: Text('Aduan Berhasil di unggah'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
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

  void _showUploadAnimation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Mengunggah aduan...'),
              ],
            ),
          ),
        );
      },
    );
  }

  void _simpanPost() async {
    await _getUserInfo();
    String content = _captionController.text;
    String fileName =
        _imageUrl != null ? _imageUrl!.split('/').last : 'blank.png';

    // Validasi not empty pada detail aduan
    if (content.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Peringatan'),
            content: Text('Detail aduan tidak boleh kosong'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Mengunggah gambar jika ada
    if (_imageUrl != null) {
      File imageFile = File(_imageUrl!);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.43.241:8000/api/upload'),
        //'http://172.19.128.24:8000/api/upload'), // Ganti dengan URL endpoint upload gambar di API Laravel
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Gambar berhasil diunggah');
        //   Post post = new Post(
        //     userId: int.parse(userId),
        //     content: content,
        //     image: fileName,
        //     isAnonymous: _sendToAnonymous,
        //   );

        //   // Tambahkan animasi sebelum muncul notifikasi
        //   _showUploadAnimation();

        //   await PostService().simpan(post);
        //   _showAlertDialog(); // atau _showSnackBar();
        // } else {
        //   print('Gagal mengunggah gambar. Status code: ${response.statusCode}');
      }
    }

    Post post = new Post(
      userId: int.parse(userId),
      content: content,
      image: fileName,
      isAnonymous: _sendToAnonymous,
    );

    // Tambahkan animasi sebelum muncul notifikasi
    _showUploadAnimation();

    await PostService().simpan(post);
    _showAlertDialog(); // atau _showSnackBar();
  }

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Akses Dibutuhkan',
      'Aplikasi membutuhkan akses ke galeri untuk mengunggah gambar. Silakan berikan izin akses galeri.',
      platformChannelSpecifics,
    );
  }

  void _uploadImage() async {
    final picker = ImagePicker();

    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      final pickedImage = await picker.getImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          _imageUrl = pickedImage.path;
        });
      }
    } else if (status.isDenied) {
      showNotification();
    } else if (status.isPermanentlyDenied) {
      showNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Aduan'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gambar Aduan(opsional)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: _imageUrl != null ? null : Colors.white,
                      image: _imageUrl != null
                          ? DecorationImage(
                              image: FileImage(File(_imageUrl!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                      border: _imageUrl != null
                          ? null
                          : Border.all(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _uploadImage,
                    child: Icon(
                      Icons.upload_rounded,
                      size: 50,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Detail Aduan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _captionController,
                maxLines:
                    5, // Atur maxLines ke null agar TextField dapat mengubah tingginya secara dinamis
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan Aduan...',
                ),
                textInputAction: TextInputAction
                    .newline, // Mengatur aksi tombol "Enter" ke "newline"
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _sendToAnonymous,
                    onChanged: (value) {
                      setState(() {
                        _sendToAnonymous = value ?? false;
                      });
                    },
                  ),
                  Text('Kirim sebagai Anonymous'),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _simpanPost,
                child: Text('Submit'),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
