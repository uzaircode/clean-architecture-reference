import 'package:clean_architecture_rivaan/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlog({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    box.read(
      () => {
        for (int i = 0; i < box.length; i++)
          {
            blogs.add(
              BlogModel.fromJson(
                box.get(i.toString()),
              ),
            ),
          }
      },
    );
    return blogs;
  }

  @override
  void uploadLocalBlog({required List<BlogModel> blogs}) {
    //remove all the data from the box if the app is restarts
    box.clear();

    box.write(
      () => {
        for (int i = 0; i < blogs.length; i++)
          {
            box.put(
              i.toString(),
              blogs[i].toJson(),
            ),
          },
      },
    );
  }
}
