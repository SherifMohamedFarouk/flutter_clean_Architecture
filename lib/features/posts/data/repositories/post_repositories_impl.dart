import 'package:dartz/dartz.dart';
import 'package:flutter_arc/core/errors/exception.dart';

import 'package:flutter_arc/core/errors/failures.dart';
import 'package:flutter_arc/core/network/network_info.dart';
import 'package:flutter_arc/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:flutter_arc/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:flutter_arc/features/posts/data/models/post_model.dart';

import 'package:flutter_arc/features/posts/domain/entites/post.dart';

import '../../domain/repositories/posts_repostiories.dart';


typedef ChangePost =  Future<Unit> Function();

class PostRepositoriesImpl implements PostsRepository{

  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  PostRepositoriesImpl({required this.remoteDataSource,required this.localDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async{
    if(await networkInfo.isConnected){
      try{
        final remotePosts= await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return right(remotePosts);
      } on ServerException{
        return left(ServerFailure());

      }
    }else{
      try{
        final cahcePosts = await localDataSource.getCachedPosts();
        return right(cahcePosts);
    }on EmptyCacheException{
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post posts) async{
    final PostModel postModel = PostModel(id: posts.id, title: posts.title, body: posts.body);
    return await changePostsMessages(() {
      return  remoteDataSource.addPost(postModel);
    });

  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await changePostsMessages(() {
      return  remoteDataSource.deletePost(id);
    });

  }


  @override
  Future<Either<Failure, Unit>> updatePost(Post posts) async{
    final PostModel postModel = PostModel(id: posts.id, title: posts.title, body: posts.body);
    return await changePostsMessages(() {
      return  remoteDataSource.updatePost(postModel);
    });

  }

  Future<Either<Failure,Unit>> changePostsMessages (ChangePost  changePost) async {

    if(await networkInfo.isConnected){
      try{
        await changePost();
        return right(unit);
      }on ServerException{
        return left(ServerFailure());
      }
    }else{
      return left(OfflineFailure());
    }
  }
  
}