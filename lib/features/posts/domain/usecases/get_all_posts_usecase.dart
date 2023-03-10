import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/post.dart';
import '../repositories/posts_repostiories.dart';

class GetAllPostsUsecase {
  final PostsRepository repository;

  GetAllPostsUsecase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}