import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/post.dart';
import '../repositories/posts_repostiories.dart';

class UpdatePostUsecase {
  final PostsRepository repository;

  UpdatePostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}