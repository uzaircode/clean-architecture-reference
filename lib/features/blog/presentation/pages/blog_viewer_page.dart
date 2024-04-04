import 'package:clean_architecture_rivaan/core/theme/app_pallete.dart';
import 'package:clean_architecture_rivaan/core/utils/calculate_reading_time.dart';
import 'package:clean_architecture_rivaan/core/utils/format_date.dart';
import 'package:clean_architecture_rivaan/features/blog/domain/entities/blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
        builder: (context) => BlogViewerPage(blog: blog),
      );
  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'By ${blog.userName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${formatDateBydMMMYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppPallete.greyColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(blog.imageUrl),
                ),
                const SizedBox(height: 20),
                Text(
                  blog.content,
                  style: const TextStyle(
                    height: 2,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
