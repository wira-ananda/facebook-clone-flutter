import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fb/services/post_service.dart';

class StatusInputCard extends StatefulWidget {
  final VoidCallback onPostSuccess;

  const StatusInputCard({super.key, required this.onPostSuccess});

  @override
  State<StatusInputCard> createState() => _StatusInputCardState();
}

class _StatusInputCardState extends State<StatusInputCard> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  Uint8List? _webImageBytes;
  bool _isPosting = false;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = picked);
      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        setState(() => _webImageBytes = bytes);
      }
    }
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _isPosting = true);
    try {
      await PostService.storePostWithImage(
        userId: 4,
        content: text,
        imageFile: _selectedImage,
      );
      _controller.clear();
      setState(() {
        _selectedImage = null;
        _webImageBytes = null;
      });
      widget.onPostSuccess();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mengirim: $e')));
    } finally {
      setState(() => _isPosting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'),
                  radius: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Apa yang Anda pikirkan?',
                      filled: true,
                      fillColor: const Color(0xFFF0F2F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_selectedImage != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Stack(
                  children: [
                    FutureBuilder<Uint8List>(
                      future: _selectedImage!.readAsBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Image.memory(snapshot.data!, height: 150);
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap:
                            () => setState(() {
                              _selectedImage = null;
                              _webImageBytes = null;
                            }),
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.photo_library, color: Colors.green),
                  label: const Text('Foto/Video'),
                ),
                ElevatedButton(
                  onPressed: _isPosting ? null : _submit,
                  child:
                      _isPosting
                          ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Text('Posting'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
