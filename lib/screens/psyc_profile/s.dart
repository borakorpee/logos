import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:agora_uikit/controllers/rtc_buttons.dart';
import 'package:flutter/material.dart';
import 'package:logos/screens/psyc_profile/constant.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;

class SpeechSampleApp extends StatefulWidget {
  @override
  _SpeechSampleAppState createState() => _SpeechSampleAppState();
}

/// An example that demonstrates the basic functionality of the
/// SpeechToText plugin for using the speech recognition capability
/// of the underlying platform.
class _SpeechSampleAppState extends State<SpeechSampleApp> {
  String kelimeler = '';
  String lastsent = "";
  String _currentLocaleId = 'tr-TR';
  final SpeechToText speech = SpeechToText();
  late Timer _timer;
  @override
  void initState() {
    initSpeechState();
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      String sentence1 = lastsent;
      String sentence2 = kelimeler;

      String difference = sentence2.substring(sentence1.length);
      log(difference);
      getResponse(difference);

      lastsent = kelimeler;
    });
  }

  void dispose() {
    _timer.cancel();
    speech.stop();
    super.dispose();
  }

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize().then((value) => startListening());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: []),
      ),
    );
  }

  // This is called each time the users wants to start a new speech
  // recognition session
  void startListening() {
    log("başla");

    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: 65),
      partialResults: true,
      localeId: 'tr-TR',
      listenMode: ListenMode.confirmation,
    );
  }

  void resultListener(SpeechRecognitionResult result) {
    kelimeler = result.recognizedWords;
  }

  Future<void> getResponse(String text) async {
    String openaiUrl = 'https://api.openai.com/v1/chat/completions';
    String openaiKey = OPENAI_KEY;

    Map<String, dynamic> requestBody = {
      'model': 'gpt-3.5-turbo',
      "messages": [
        {
          "role": "user",
          "content":
              """Cümledeki kelimeler ve fillerin sadece köklerini   içerisinde string olarak ve "," işareti ile ayrılmış şekilde kök1,kök2 şeklinde yaz eğer kökü bulamadıysan "bulunamadı" mısın:  $text """
        }
      ]
    };
    var response = await http.post(
      Uri.parse(openaiUrl),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $openaiKey'
      },
      body: jsonEncode(requestBody),
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    log(data['choices'][0]["message"]["content"]);
  }
}
