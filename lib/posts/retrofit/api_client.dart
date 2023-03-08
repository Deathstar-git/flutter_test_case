import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/models.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/posts')
  Future<List<Post>> fetchPosts(@Query('_start') int startIndex,
      @Query('_limit') int postLimit);

  @GET('/users')
  Future<List<User>> fetchUser(@Query('id') int id);

  @GET("/posts/{id}/comments")
  Future <List<Comment>> fetchComments(@Path("id") int postId, @Query('_limit') int commentLimit, @Query('_start') int startIndex);
}