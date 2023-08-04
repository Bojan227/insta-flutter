import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pettygram_flutter/models/comment.dart';
import 'package:pettygram_flutter/ui/comments/widgets/comment_item.dart';

import 'package:flutter_test/flutter_test.dart';

abstract class OnLikeTap {
  void call();
}

class MockOnLikeTap extends Mock implements OnLikeTap {}

void main() {
  Widget widgetUnderTestMethod({Comment? comment, Function()? callback}) {
    return MaterialApp(
      home: Scaffold(
        body: CommentItem(
          comment: comment!,
          onTap: callback,
        ),
      ),
    );
  }

  final Comment comment = Comment(
      id: '1',
      comment: 'test comment',
      post: 'post-id',
      createdBy: const {
        "username": 'test',
        "imageUrl": "https://picsum.photos/id/237/200/300"
      },
      likes: const ['2', '3'],
      createdAt:
          'Fri Aug 04 2023 13:00:24 GMT+0200 (Central European Summer Time)');

  final Comment commentWithOneLike = Comment(
      id: '1',
      comment: 'test comment',
      post: 'post-id',
      createdBy: const {
        "username": 'test',
        "imageUrl": "https://picsum.photos/id/237/200/300"
      },
      likes: const ['2'],
      createdAt:
          'Fri Aug 04 2023 13:00:24 GMT+0200 (Central European Summer Time)');

  group('CommentItem', () {
    group('correctly rendered', () {
      testWidgets('is length of likes correct when more than 1 like',
          (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTestMethod(comment: comment));

        final findTextByNumberOfLikes = find.text('2 likes');

        expect(findTextByNumberOfLikes, findsOneWidget);
      });

      testWidgets('is length of likes correct when there is 1 like',
          (widgetTester) async {
        await widgetTester
            .pumpWidget(widgetUnderTestMethod(comment: commentWithOneLike));

        final findTextByNumberOfLikes = find.text('1 like');

        expect(findTextByNumberOfLikes, findsOneWidget);
      });
    });

    group('should handle onTap', () {
      final mockOnLikeTap = MockOnLikeTap();

      testWidgets('when someone has pressed the button', (widgetTester) async {
        await widgetTester.pumpWidget(
            widgetUnderTestMethod(comment: comment, callback: mockOnLikeTap));

        final likeButtonFinder = find.byType(IconButton);
        await widgetTester.tap(likeButtonFinder);

        verify(mockOnLikeTap).called(1);
      });
    });
  });
}
