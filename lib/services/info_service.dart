import 'package:flutter/material.dart';
import 'package:zocbo/utils/api.dart';

import '../models/semester.dart';
import '../models/user.dart';
import '../utils/url.dart';

const USED_SCHEDULE_FIELDS = [
  "beginning",
  "end",
  "courseRegistrationPeriodStart",
  "courseRegistrationPeriodEnd",
  "courseAddDropPeriodEnd",
  "courseDropDeadline",
  "courseEvaluationDeadline",
  "gradePosting",
];

const SCHEDULE_NAME = {
  "beginning": "개강",
  "end": "종강",
  "courseRegistrationPeriodStart": "수강신청기간 시작",
  "courseRegistrationPeriodEnd": "수강신청기간 종료",
  "courseAddDropPeriodEnd": "수강변경기간 종료",
  "courseDropDeadline": "수강취소 마감",
  "courseEvaluationDeadline": "강의평가 마감",
  "gradePosting": "성적게시"
};

class InfoService extends ChangeNotifier {
  late Set<int> _years;
  Set<int> get years => _years;

  late List<Semester> _semesters;
  List<Semester> get semesters => _semesters;

  late User _user;
  User get user => _user;

  late Map<String, dynamic>? _currentSchedule;
  Map<String, dynamic>? get currentSchedule => _currentSchedule;

  bool _hasData = false;
  bool get hasData => _hasData;

  Future<void> getInfo() async {
    // try {
    _semesters = await getSemesters();
    _years = _semesters.map((semester) => semester.year).toSet();
    _user = await getUser();
    _currentSchedule = getCurrentSchedule();
    _hasData = true;
    notifyListeners();
    // } catch (exception) {
    //   print(exception);
    // }
  }

  Future<List<Semester>> getSemesters() async {
    final response = await API().dio.get(API_SEMESTER_URL);
    final rawSemesters = response.data as List;
    return rawSemesters.map((semester) => Semester.fromJson(semester)).toList();
  }

  Future<User> getUser() async {
    final response = await API().dio.get(sessionInfoUrl);
    return User.fromJson(response.data);
  }

  Map<String, dynamic>? getCurrentSchedule() {
    final now = DateTime.now();
    final schedules = _semesters
        .map((semester) => USED_SCHEDULE_FIELDS.map((field) {
              final time = semester.toJson()[field];
              if (time == null) return null;
              return <String, dynamic>{
                "name": SCHEDULE_NAME[field],
                "time": time,
              };
            }))
        .expand((e) => e)
        .where((e) => e != null)
        .toList();
    schedules.sort((a, b) => a!["time"].compareTo(b!["time"]));
    return schedules.firstWhere((e) => e!["time"].isAfter(now),
        orElse: () => null);
  }
}
