import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pettygram_flutter/domain/entities/comment.dart';
import 'package:pettygram_flutter/domain/repository/pettygram_repo.dart';
import 'package:pettygram_flutter/domain/usecases/get_comments_by_postid.dart';

class MockPettygramRepo extends Mock implements PettygramRepository {}

void main() {
  late MockPettygramRepo mockPettygramRepo;
  late GetCommentsByPostId usecase;

  setUp(() {
    mockPettygramRepo = MockPettygramRepo();
    usecase = GetCommentsByPostId(repository: mockPettygramRepo);
  });

  const postId = '1';
  const comment = Comment(
      id: '1',
      comment: 'test',
      post: 'post',
      createdBy: {},
      likes: ['1', '2'],
      createdAt: '');

  test('should return list of comments', () async {
    when(() => mockPettygramRepo.getCommentsByPostId(postId))
        .thenAnswer((_) async => Future.value([comment]));

    final result = await usecase.execute(postId);

    expect(result, [comment]);
  });
}
