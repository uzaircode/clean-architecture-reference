import 'package:clean_architecture_rivaan/core/error/failures.dart';
import 'package:clean_architecture_rivaan/core/usecase/usecase.dart';
import 'package:clean_architecture_rivaan/features/blog/domain/entities/blog.dart';
import 'package:clean_architecture_rivaan/features/blog/domain/repositories/blog_repository.dart';
import 'package:clean_architecture_rivaan/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockBlogRepository extends Mock implements BlogRepository {}

@GenerateMocks([MockBlogRepository])
void main() {
  late GetAllBlogs usecase;
  late MockBlogRepository mockBlogRepository;

  setUp(() {
    mockBlogRepository = MockBlogRepository();
    usecase = GetAllBlogs(mockBlogRepository);
  });

  final List<Blog> testBlogs = [
    Blog(
      id: '1',
      userId: 'user1',
      title: 'Sample Blog 1',
      content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imageUrl: 'https://example.com/image1.jpg',
      topics: ['Technology', 'Flutter'],
      updatedAt: DateTime.now(),
      userName: 'John Doe',
    ),
  ];

  test('should get all blogs from the repository', () async {
    // Arrange
    when(mockBlogRepository.getAllBlogs()).thenAnswer((_) async => Right<Failure, List<Blog>>(testBlogs));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, Right(testBlogs));
    verify(mockBlogRepository.getAllBlogs()).called(1);
    verifyNoMoreInteractions(mockBlogRepository);
  });
}
