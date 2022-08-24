import 'package:la_vie/core/widgets/api_strings.dart';

import '../core/app_strings.dart';

class Blogs {
  late List<Blog> blogs;
  Blogs.fromJson(Map<String, dynamic> json) {
    blogs = [];
    blogs.addAll(
        List.from(json['plants']).map((e) => Blog.fromJson(e)).toList());

    blogs
        .addAll(List.from(json['seeds']).map((e) => Blog.fromJson(e)).toList());

    blogs
        .addAll(List.from(json['tools']).map((e) => Blog.fromJson(e)).toList());
  }
}

class Blog {
  Blog({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
  late final String name;
  late final String description;
  late final String imageUrl;

  Blog.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    imageUrl = '${ApiStrings.baseUrlForImage}${json['imageUrl']}';
  }
}
