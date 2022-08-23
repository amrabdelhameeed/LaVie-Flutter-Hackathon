import 'package:dio/dio.dart';
import 'package:la_vie/core/app_web_services.dart';
import 'package:la_vie/model/blog.dart';
import 'package:la_vie/model/product.dart';

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
}
