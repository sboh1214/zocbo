import 'dart:ffi';

class Exam {
  final String? id;
  final String? type;
  final int? duration;
  final int? ratio;
  final int? totalScore;
  final String? description;

  final double? avg;
  final double? std;
  final double? max;
  final double? min;
  final double? q1;
  final double? q2;
  final double? q3;

  const Exam({
    this.id,
    this.type,
    this.duration,
    this.ratio,
    this.totalScore,
    this.description,
    this.avg,
    this.std,
    this.max,
    this.min,
    this.q1,
    this.q2,
    this.q3,
  });

  factory Exam.fromDoc(String id, Map<String, dynamic> doc) {
    return Exam(
      id: id,
      type: doc['type'],
      duration: doc['duration'],
      ratio: doc['ratio'],
      totalScore: doc['total_score'],
      description: doc['description'],
      avg: doc['avg'],
      std: doc['std'],
      max: doc['max'],
      min: doc['min'],
      q1: doc['q1'],
      q2: doc['q2'],
      q3: doc['q3'],
    );
  }
}
