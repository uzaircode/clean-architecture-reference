import 'dart:io';

import 'package:clean_architecture_rivaan/core/error/failures.dart';
import 'package:clean_architecture_rivaan/core/usecase/usecase.dart';
import 'package:clean_architecture_rivaan/features/blog/domain/entities/blog.dart';
import 'package:clean_architecture_rivaan/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      topics: params.topics,
      userId: params.userId,
    );
  }
}

class UploadBlogParams {
  final String userId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.userId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
