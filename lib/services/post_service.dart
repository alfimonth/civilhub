import 'package:dio/dio.dart';
import '../helpers/api_client.dart';
import '../models/post.dart';

class PostService {
  Future<List<Post>> listData() async {
    final Response response = await ApiClient().get('post');
    final List data = response.data as List;
    List<Post> result = data.map((json) => Post.fromJson(json)).toList();
    return result;
  }

  Future<Post> simpan(Post post) async {
    var data = post.toJson();
    final Response response = await ApiClient().post('post', data);
    Post result = Post.fromJson(response.data);
    return result;
  }

  Future<Post> ubah(Post post, String id) async {
    var data = post.toJson();
    final Response response = await ApiClient().put('post/${id}', data);
    Post result = Post.fromJson(response.data);
    return result;
  }

  Future<Post> getById(String id) async {
    final Response response = await ApiClient().get('post/${id}');
    Post result = Post.fromJson(response.data);
    return result;
  }

  Future<Post> hapus(Post post) async {
    final Response response = await ApiClient().delete('post/${post.id}');
    Post result = Post.fromJson(response.data);
    return result;
  }
}
