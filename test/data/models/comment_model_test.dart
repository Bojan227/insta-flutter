import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pettygram_flutter/data/models/comment_model.dart';
import 'package:pettygram_flutter/domain/entities/comment.dart';

import '../../core/fixtures/fixture_reader.dart';

void main() {
  const tCommentModel = CommentModel(
      id: '63fc9f59497159fe4ec5e295',
      comment: 'fbvgdg',
      post: '63fb3528c5e3d05faaeaee27',
      createdBy: {
        "_id": "63fc9f28497159fe4ec5e254",
        "username": "erlan",
        "imageUrl":
            "https://res.cloudinary.com/boki2435/image/upload/v1677500199/x8rv0sxsqaobelkadjus.jpg"
      },
      likes: ["63f76286810a293888d18152"],
      createdAt:
          "Mon Feb 27 2023 12:17:29 GMT+0000 (Coordinated Universal Time)");

  test('should be a subclass of comment entity', () {
    expect(tCommentModel, isA<Comment>());
  });

  group('fromJson', () {
    test('should return valid model when json is passed', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('comment.json'));
      final result = CommentModel.fromJson(jsonMap);

      expect(result, tCommentModel);
    });
  });

  group('toJson', () {
    test('should return valid Map when the method is called', () async {
      final result = tCommentModel.toJson();

      expect(result, {'comment': 'fbvgdg', 'post': '63fb3528c5e3d05faaeaee27'});
    });
  });
}
