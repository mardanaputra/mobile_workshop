import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_fundamentals/models/course.dart';
import 'package:flutter_ui_fundamentals/providers/course_provider.dart';
import 'package:flutter_ui_fundamentals/repositories/course_repository.dart';
import 'package:flutter_ui_fundamentals/services/course_service.dart';

// Mock Service untuk isolasi data uji
class MockCourseService extends CourseService {
  @override
  Future<List<Course>> loadCourses() async {
    return [
      Course(
        code: 'TEST01',
        title: 'Pengujian Unit Flutter',
        credits: 3,
        status: 'active',
      ),
    ];
  }
}

void main() {
  group('Pengujian Unit CourseProvider', () {
    late CourseProvider provider;

    setUp(() {
      final mockService = MockCourseService();
      final repository = CourseRepository(mockService);
      provider = CourseProvider(repository);
    });

    test('State awal favorites harus dalam kondisi kosong', () {
      expect(provider.favorites.isEmpty, true);
    });

    test('Fungsi toggleFavorite berhasil menambah dan menghapus favorit', () {
      provider.toggleFavorite('TEST01');
      expect(provider.isFavorite('TEST01'), true);

      provider.toggleFavorite('TEST01');
      expect(provider.isFavorite('TEST01'), false);
    });

    test(
      'Fungsi loadCourses berhasil mengisi daftar kursus dari Repository',
      () async {
        await provider.loadCourses();
        expect(provider.courses.length, 1);
        expect(provider.courses.first.code, 'TEST01');
        expect(provider.isLoading, false);
      },
    );
  });
}
