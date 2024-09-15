import 'package:intl/intl.dart';

class SentimentRecord {
  String sentimentName;
  String sentimentValue;
  double sentimentScore;
  DateTime date;

  SentimentRecord({
    required this.sentimentName,
    required this.sentimentValue,
    required this.sentimentScore,
    required this.date,
  });

  // Convert a SentimentRecord instance to a Map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'sentimentName': sentimentName,
      'sentimentValue': sentimentValue,
      'sentimentScore': sentimentScore,
      'date': DateFormat('yyyy-MM-dd').format(date),
    };
  }

  // Create a SentimentRecord instance from a Map
  factory SentimentRecord.fromMap(Map<String, dynamic> map) {
    return SentimentRecord(
      sentimentName: map['sentimentName'],
      sentimentValue: map['sentimentValue'],
      sentimentScore: map['sentimentScore'],
      date: DateFormat('yyyy-MM-dd').parse(map['date']),
    );
  }
}
