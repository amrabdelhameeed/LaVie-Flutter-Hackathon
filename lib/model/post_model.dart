import 'package:la_vie/core/widgets/api_strings.dart';

import '../core/app_strings.dart';

class PostsResponse {
  final String? type;
  final String? message;
  final List<Post>? data;

  PostsResponse({
    this.type,
    this.message,
    this.data,
  });

  PostsResponse.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class Post {
  final String? forumId;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? userId;
  final int? forumLikes;
  final List<ForumComments>? forumComments;
  final User? user;

  Post({
    this.forumId,
    this.title,
    this.description,
    this.imageUrl,
    this.userId,
    this.forumLikes,
    this.forumComments,
    this.user,
  });

  Post.fromJson(Map<String, dynamic> json)
      : forumId = json['forumId'] as String?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        imageUrl = '${ApiStrings.baseUrlForImage}${json['imageUrl']}',
        userId = json['userId'] as String?,
        forumLikes = (json['ForumLikes'] as List?)
            ?.map((dynamic e) => ForumLikes.fromJson(e as Map<String, dynamic>))
            .toList()
            .length,
        forumComments = (json['ForumComments'] as List?)
            ?.map((dynamic e) =>
                ForumComments.fromJson(e as Map<String, dynamic>))
            .toList(),
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'forumId': forumId,
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'userId': userId,
        'ForumLikes': forumLikes,
        'ForumComments': forumComments?.map((e) => e.toJson()).toList(),
        'user': user?.toJson()
      };
}

class ForumLikes {
  final String? forumId;
  final String? userId;

  ForumLikes({
    this.forumId,
    this.userId,
  });

  ForumLikes.fromJson(Map<String, dynamic> json)
      : forumId = json['forumId'] as String?,
        userId = json['userId'] as String?;

  Map<String, dynamic> toJson() => {'forumId': forumId, 'userId': userId};
}

class ForumComments {
  final String? forumCommentId;
  final String? forumId;
  final String? userId;
  final String? comment;
  final String? createdAt;

  ForumComments({
    this.forumCommentId,
    this.forumId,
    this.userId,
    this.comment,
    this.createdAt,
  });

  ForumComments.fromJson(Map<String, dynamic> json)
      : forumCommentId = json['forumCommentId'] as String?,
        forumId = json['forumId'] as String?,
        userId = json['userId'] as String?,
        comment = json['comment'] as String?,
        createdAt = json['createdAt'] as String?;

  Map<String, dynamic> toJson() => {
        'forumCommentId': forumCommentId,
        'forumId': forumId,
        'userId': userId,
        'comment': comment,
        'createdAt': createdAt
      };
}

class User {
  final String? firstName;
  final String? lastName;
  final String? imageUrl;

  User({
    this.firstName,
    this.lastName,
    this.imageUrl,
  });

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        imageUrl = json['imageUrl'] as String?;

  Map<String, dynamic> toJson() =>
      {'firstName': firstName, 'lastName': lastName, 'imageUrl': imageUrl};
}
