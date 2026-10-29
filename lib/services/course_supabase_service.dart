import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course.dart';
import 'course_data_source.dart';

class CourseSupabaseService implements CourseDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Course>> getCourses() async {
    final response = await supabase
        .from('courses')
        .select()
        .order('id', ascending: true);

    final List<dynamic> data = response as List<dynamic>;
    return data
        .map((item) => Course.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // Implementasi INSERT ke Supabase
  @override
  Future<Course> createCourse(Course course) async {
    final row = await supabase
        .from('courses')
        .insert(course.toJson())
        .select()
        .single();

    return Course.fromJson(row);
  }

  // Stub sementara untuk Tahap 14 dan 15
  @override
  Future<void> updateCourse(int id, Course course) => throw UnimplementedError();

  @override
  Future<void> deleteCourse(int id) => throw UnimplementedError();
}