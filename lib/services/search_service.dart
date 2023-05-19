import 'package:flutter/material.dart';
import 'package:zocbo/models/course.dart';
import 'package:zocbo/utils/api.dart';
import 'package:zocbo/utils/url.dart';

class SearchService extends ChangeNotifier {
  List<Course>? _courses;
  List<Course>? get courses => _courses ?? [];

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  Future<void> courseSearch(
    String keyword, {
    List<String> department = const [],
    List<String> type = const [],
    List<String> level = const [],
  }) async {
    _isSearching = true;
    notifyListeners();

    try {
      final response = await API().dio.getUri(
            Uri(
              path: API_COURSE_URL,
              queryParameters: {
                "keyword": keyword,
                "department": department.isEmpty ? "ALL" : department,
                "type": type.isEmpty ? "ALL" : type,
                "level": level.isEmpty ? "ALL" : level,
                "term": "ALL",
              },
            ),
          );

      final rawCourses = response.data as List;
      _courses = rawCourses.map((course) => Course.fromJson(course)).toList();
    } catch (exception) {
      print(exception);
    }

    _isSearching = false;
    notifyListeners();
  }
}
