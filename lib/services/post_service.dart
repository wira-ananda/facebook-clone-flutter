import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../models/post.dart';

class PostService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  // Ambil semua postingan
  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/api/posts'));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> data = body['data']['data'];
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data postingan');
    }
  }

  // Simpan postingan dengan XFile (kompatibel web/mobile)
  static Future<void> storePostWithImage({
    required int userId,
    required String content,
    XFile? imageFile,
  }) async {
    final uri = Uri.parse('$baseUrl/api/posts');
    final request = http.MultipartRequest('POST', uri);

    request.fields['user_id'] = userId.toString();
    request.fields['content'] = content;

    if (imageFile != null) {
      final bytes = await imageFile.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: imageFile.name,
      );
      request.files.add(multipartFile);
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 201) {
      throw Exception('Gagal menyimpan postingan: ${response.body}');
    }
  }
}
