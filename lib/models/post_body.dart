import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class PostBody {
  const PostBody({required this.text, required this.images});

  final String text;
  final List<String> images;

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'text': text, "images": images};
}
