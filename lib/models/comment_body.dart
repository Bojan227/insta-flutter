class CommentBody {
  const CommentBody({required this.comment, required this.post});

  final String comment;
  final String post;

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'comment': comment, 'post': post};
}
