import 'dart:convert';

class Post {
  int? id;
  int userId;
  String content;
  String image;
  bool isAnonymous;
  DateTime? createdAt;
  DateTime? updatedAt;

  Post({
    this.id,
    required this.userId,
    required this.content,
    required this.image,
    required this.isAnonymous,
    this.createdAt,
    this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['id_user'],
      content: json['content'],
      image: json['image'],
      isAnonymous: json['is_anonymous'] == 1 ? true : false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

// ...

  Map<String, dynamic> toJson() {
    print(this.image);
    Map<String, dynamic> data = {
      'id_user': userId,
      'content': content,
      'is_anonymous': isAnonymous,
      'image': image,
    };

    return data;
  }
}
