class Exam {
  final String? id;
  final String? type;
  final int? duration;
  final int? ratio;
  final int? totalScore;
  final String? description;

  const Exam({
    this.id,
    this.type,
    this.duration,
    this.ratio,
    this.totalScore,
    this.description,
  });

  factory Exam.fromDoc(String id, Map<String, dynamic> doc) {
    return Exam(
      id: id,
      type: doc['type'],
      duration: doc['duration'],
      ratio: doc['ratio'],
      totalScore: doc['total_score'],
      description: doc['description'],
    );
  }
}
