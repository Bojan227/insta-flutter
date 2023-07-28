import 'dart:io';
import 'dart:typed_data';

class PostBody {
  const PostBody({required this.text, required this.images});

  final String text;
  final List<int> images;

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'text': text, "images": images};
}
