import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String? _imageUrl;
  bool _sendToAnonymous = false;
  TextEditingController _captionController = TextEditingController();

  void _uploadImage() {
    // Tambahkan logika untuk mengunggah gambar
    // Setelah gambar diunggah, perbarui _imageUrl dengan URL gambar yang diunggah
    setState(() {
      _imageUrl = 'https://example.com/uploaded_image.jpg';
    });
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
                                image: NetworkImage(_imageUrl!),
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
                    // Tambahkan logika untuk mengirim postingan
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
        ));
  }
}
