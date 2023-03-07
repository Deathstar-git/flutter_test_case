import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/post.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/posts')
  Future<List<Post>> fetchPosts(@Query('_start') int startIndex,
      @Query('_limit') int postLimit);
}