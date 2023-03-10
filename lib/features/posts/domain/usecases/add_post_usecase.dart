import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/post.dart';
import '../repositories/posts_repostiories.dart';


class AddPostUsecase {
  final PostsRepository repository;

  AddPostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}