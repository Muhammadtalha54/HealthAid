import 'dart:convert';
import 'package:get/get.dart';
import 'package:healthaid/Recources/Appurls/Appurls.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  RxString responseText = ''.obs;
  var isLoading = false.obs;
  RxString tips = ''.obs;

  final String apiUrl = Appurls.chatboturl;
  final String apiKey = Apikeys.chatbotkey; // Your API key

  // Method to call the chatbot API
  Future<void> getChatbotResponse(String mood) async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: json.encode({
          "model": "solar-pro",
          "messages": [
            {
              "role": "user",
              "content":
                  "The user is feeling $mood, please give some tips or exercises based on their mood give whatever you want. Remeber the user cannot text you back. keep the respoce short. give points each in new line by using \n",
            }
          ],
          "stream": false,
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        tips.value = jsonResponse['choices'][0]['message']['content'];

        print(responseText.value);
      } else {
        throw Exception('Failed to get chatbot response');
      }
    } catch (error) {
      print('Error occurred: $error');
    } finally {
      isLoading.value = false;
    }
  }
}
