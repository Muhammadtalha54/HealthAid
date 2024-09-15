import 'dart:convert';
import 'package:get/get.dart';
import 'package:healthaid/Models/sentiment.dart';
import 'package:healthaid/Recources/Appurls/Appurls.dart';
import 'package:healthaid/viewmodel/chatbotapi.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SentimentController extends GetxController {
  final _sentiment = ''.obs;
  final _loading = false.obs;
  final String apiKey = Apikeys.sentimentkey;
  final chatController = Get.put(ChatController());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> analyzeSentiment(String text) async {
    _loading.value = true;

    try {
      final url =
          'https://api-inference.huggingface.co/models/cardiffnlp/twitter-roberta-base-sentiment-latest';
      final response = await http.post(Uri.parse(url),
          headers: {
            "Authorization": "Bearer $apiKey",
            'Content-Type': 'application/json'
          },
          body: jsonEncode({'inputs': text}));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final sentiments = jsonData[0];
        final highestScore =
            sentiments.reduce((a, b) => a['score'] > b['score'] ? a : b);

        String sentimentValue;
        String sentimentName;
        double sentimentScore = highestScore['score'];

        if (highestScore['label'] == 'positive' && sentimentScore > 0.5) {
          sentimentValue = 'Happy';
          sentimentName = 'Positive';
        } else if (highestScore['label'] == 'negative' &&
            sentimentScore > 0.5) {
          sentimentValue = 'Sad/Depressed';
          sentimentName = 'Negative';
        } else {
          sentimentValue = 'Neutral';
          sentimentName = 'Neutral';
        }

        _sentiment.value = sentimentValue;
        await chatController.getChatbotResponse(sentimentValue);

        // Create a SentimentRecord with the score
        final sentimentRecord = SentimentRecord(
          sentimentName: sentimentName,
          sentimentValue: sentimentValue,
          sentimentScore: sentimentScore,
          date: DateTime.now(),
        );

        // Store the SentimentRecord in Firestore
        await _firestore.collection('sentiments').add(sentimentRecord.toMap());
      } else {
        _sentiment.value = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      _sentiment.value = 'Error: $e';
    } finally {
      _loading.value = false;
    }
  }

  String get sentiment => _sentiment.value;
  bool get isLoading => _loading.value;
}
