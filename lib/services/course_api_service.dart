import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseApiService {
  CourseApiService(this.baseUrl);

  final String baseUrl;

  Future<List<Course>> getCourses() async {
    final String endpoint = baseUrl.contains('jsonplaceholder')
        ? '$baseUrl/posts'
        : '$baseUrl/courses';

    final response = await http.get(Uri.parse(endpoint));

    debugPrint('HTTP Method: GET');
    debugPrint('Endpoint: $endpoint');
    debugPrint('Status Code: ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil course: HTTP ${response.statusCode}');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    debugPrint('Jumlah course: ${data.length}');

    return data
        .map((item) => Course.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Course>> loadCourses() async => getCourses();

  Future<Course> createCourse(Course course) async {
    final String endpoint = baseUrl.contains('jsonplaceholder')
        ? '$baseUrl/posts'
        : '$baseUrl/courses';

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(course.toJson()),
    );

    debugPrint('HTTP Method: POST');
    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Course.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }

    throw Exception('Gagal membuat course: HTTP ${response.statusCode}');
  }

  Future<void> updateCourse(int id, Course course) async {
    final String endpoint = baseUrl.contains('jsonplaceholder')
        ? '$baseUrl/posts/$id'
        : '$baseUrl/courses/$id';

    final response = await http.put(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(course.toJson()),
    );

    debugPrint('HTTP Method: PUT');
    debugPrint('Endpoint: $endpoint');
    debugPrint('Status Code: ${response.statusCode}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Gagal memperbarui course: HTTP ${response.statusCode}');
    }
  }

  Future<void> deleteCourse(int id) async {
    final String endpoint = baseUrl.contains('jsonplaceholder')
        ? '$baseUrl/posts/$id'
        : '$baseUrl/courses/$id';

    final response = await http.delete(Uri.parse(endpoint));

    debugPrint('HTTP Method: DELETE');
    debugPrint('Endpoint: $endpoint');
    debugPrint('Status Code: ${response.statusCode}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Gagal menghapus course: HTTP ${response.statusCode}');
    }
  }
}
