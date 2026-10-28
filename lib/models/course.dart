class Course {
  final int? id;
  final String code;
  final String title;
  final int credits;
  final String status;

  const Course({
    this.id,
    required this.code,
    required this.title,
    required this.credits,
    this.status = 'planned',
  });

  /// Factory dari JSON dengan penanganan type casting yang aman
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int?,
      code: (json['code'] as String?) ?? '',
      title: (json['title'] as String?) ?? '',
      credits: (json['credits'] as num?)?.toInt() ?? 0,
      status: (json['status'] as String?) ?? 'planned',
    );
  }

  /// Konversi Objek ke Map JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'code': code,
      'title': title,
      'credits': credits,
      'status': status,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }
}
