import 'app_web_services.dart';
import '../model/blog.dart';
import '../model/post_model.dart';
import '../model/product.dart';

class AppRepository {
  final AppWebServices webServices;
  AppRepository(this.webServices);
  Future<List<Product>> getAllProducts() async {
    final response = await webServices.getAllProducts();
    return List.from(response.data['data'])
        .map((e) => Product.fromJson(e))
        .toList();
  }

  Future<Blogs> getAllBlogs() async {
    final response = await webServices.getAllBlogs();
    return Blogs.fromJson(response.data['data']);
  }

  Future<PostsResponse> getAllPosts() async {
    final response = await webServices.getAllPosts();
    return PostsResponse.fromJson(response.data);
  }

  Future<PostsResponse> getMyPosts() async {
    final response = await webServices.getMyPosts();
    return PostsResponse.fromJson(response.data);
  }
}
