import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:healthaid/Models/sentiment.dart';

class MoodHistoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<SentimentRecord>> fetchMoodData() async {
    // Fetch data from Firestore
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('sentiments').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return SentimentRecord(
          date: data['date'],
          sentimentName: data['sentimentName'],
          sentimentScore: (data['sentimentScore'] as num).toDouble(),
          sentimentValue: data['sentimentValue'],
        );
      }).toList();
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }
}
