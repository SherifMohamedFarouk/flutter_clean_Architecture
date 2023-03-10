import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/posts_repostiories.dart';


class DeletePostUsecase {
  final PostsRepository repository;

  DeletePostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}