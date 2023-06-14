import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String? _imageUrl;
  bool _sendToAnonymous = false;
  TextEditingController _captionController = TextEditingController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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
        title: Text('Tambah Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload Gambar',
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
                'Caption',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _captionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan caption...',
                ),
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
                onPressed: () {
                  String caption = _captionController.text;
                  bool sendToAnonymous = _sendToAnonymous;

                  // Lakukan sesuatu dengan data yang dikirim, misalnya menyimpan ke database
                },
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
