import 'package:flutter/material.dart';
import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  List<Course> _courses = [];
  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;
  final Set<String> _favorites = {};

  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get error => _error;
  Set<String> get favorites => _favorites;

  Future<void> loadCourses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _courses = await repository.getCourses();
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createCourse(Course course) async {
    _isSaving = true;
    _error = null;
    notifyListeners();

    try {
      final newCourse = await repository.createCourse(course);
      // Masukkan data baru ke posisi teratas list lokal
      _courses.insert(0, newCourse);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  void toggleFavorite(String code) {
    if (_favorites.contains(code)) {
      _favorites.remove(code);
    } else {
      _favorites.add(code);
    }
    notifyListeners();
  }

  bool isFavorite(String code) => _favorites.contains(code);
}
