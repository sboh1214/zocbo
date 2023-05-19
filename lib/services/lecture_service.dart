import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zocbo/models/exam.dart';
import 'package:zocbo/models/user.dart';

import '../models/lecture.dart';

class LectureService extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;

  late List<Lecture> _lectures;
  List<Lecture> get lectures => _lectures;

  late int lectureId;
  late int courseId;

  List<Exam> exams = [];
  Exam? selectedExam;

  void getLectures(User user) async {
    _lectures = user.myTimetableLectures
        .where((lecture) => lecture.year == 2022 && lecture.semester == 1)
        .toList();
    lectureId = _lectures[0].id;
    courseId = _lectures[0].course;
    notifyListeners();
    getExams();
  }

  void setLecture(int index) {
    lectureId = _lectures[index].id;
    courseId = _lectures[index].course;
    notifyListeners();
    getExams();
  }

  void getExams() async {
    final examDocs = await _firestore
        .collection('courses')
        .doc(courseId.toString())
        .collection('lectures')
        .doc(lectureId.toString())
        .collection('exams')
        .get();
    exams = examDocs.docs.map((d) => Exam.fromDoc(d.id, d.data())).toList();
    notifyListeners();
  }

  void setExamIndex(int index) {
    selectedExam = exams[index];
    notifyListeners();
  }
}
