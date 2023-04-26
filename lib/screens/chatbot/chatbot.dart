import 'dart:convert';
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logos/screens/psyc_profile/constant.dart';
import 'package:ripple_wave/ripple_wave.dart';
import 'package:http/http.dart' as http;
import '../../models/chatMessage_model.dart';

const systemPrompt =
    """sen bir psikolojik analiz yapan bir botsun öncelikle kullanıcıya ne yapmak istediğini seçenek olarak sunacaksın 
seçenek 1 = hızlı psikolojik analiz testi
seçenek 2 = Sohbet

eğer kullanıcı seçenek 1 seçerse 3 Soruluk bir psikolojik test yapacaksın soruları sırayla teker teker sorup kullanıcının yanıt vermesini bekleyeceksin ve kullanıcı soruya yanıt verdikten sonra diğer soruya geçeceksin 3 soru bittiksen sonra kullanıcının psikolojisi hakkında kendi yorumunu yapacaksın

eğer kullanıcı seçenek 2 seçerse "Logos takımının geliştirmiş olduğu yapay zeka botuna Hoş Geldiniz...  Dilediğiniz soruyu bana sorabilirsiniz" Yazacaksın  ve sonrasında normal bir sohbet botu gibi devam edeceksin """;

class LogBotScreen extends StatefulWidget {
  static const routeName = "/logbot";
  const LogBotScreen({super.key});

  @override
  State<LogBotScreen> createState() => _LogBotScreenState();
}

class _LogBotScreenState extends State<LogBotScreen> {
  late bool isLoading;
  TextEditingController _textController = TextEditingController();
  final _scrollcontroller = ScrollController();
  final List<ChatMessage> _messages = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = false;
      _messages.add(ChatMessage(
          text: "Merhaba, ben LogBot. Size nasıl yardımcı olabilirim?",
          chatMessageType: ChatMessageType.bot));
    });
    isLoading = false;
  }

  Future<String> generateFirstResponse(String prompt) async {
    Map<String, dynamic> requestBody = {
      'model': 'gpt-4',
      "messages": [
        {"role": "system", "content": systemPrompt},
        {"role": "user", "content": prompt}
      ]
    };
    final apiKey = OPENAI_KEY;
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode(requestBody),
    );
    var newResponse = json.decode(utf8.decode(response.bodyBytes));
    log(newResponse.toString());
    return newResponse['choices'][0]["message"]["content"] ??
        newResponse['error']["message"];
  }

  Future<String> generateResponse(String prompt) async {
    Map<String, dynamic> requestBody = {
      'model': 'gpt-4',
      "messages": [
        {"role": "user", "content": prompt}
      ]
    };
    final apiKey = OPENAI_KEY;
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode(requestBody),
    );
    var newResponse = json.decode(utf8.decode(response.bodyBytes));
    log(newResponse.toString());
    return newResponse['choices'][0]["message"]["content"] ??
        newResponse['error']["message"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const LogBotAppbar(),
          Expanded(
            child: ListView.builder(
              controller: _scrollcontroller,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                var message = _messages[index];
                return ChatMessageWidget(
                  text: message.text,
                  chatMessageType: message.chatMessageType,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 300.w,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Color(0xffE8E6EA))),
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(color: Colors.black),
                  controller: _textController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20, right: 20),
                    hintText: "Mesajınız",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
              Visibility(
                visible: !isLoading,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _messages.add(ChatMessage(
                        text: _textController.text,
                        chatMessageType: ChatMessageType.user,
                      ));
                      isLoading = true;
                    });
                    var input = _textController.text;
                    _textController.clear();
                    Future.delayed(Duration(milliseconds: 50))
                        .then((value) => _scrollDown());

                    generateResponse(input).then((value) {
                      setState(() {
                        isLoading = false;
                        _messages.add(ChatMessage(
                            text: value, chatMessageType: ChatMessageType.bot));
                      });
                    });
                    _textController.clear();
                    Future.delayed(Duration(milliseconds: 50))
                        .then((value) => _scrollDown());
                  },
                  child: Container(
                    width: 55.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffE8E6EA),
                      ),
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Color(0xff8C10B8),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  void _scrollDown() {
    _scrollcontroller.animateTo(_scrollcontroller.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}

class LogBotAppbar extends StatelessWidget {
  const LogBotAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 30, right: 30).r,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 42.w,
              height: 42.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffF7F7F7),
              ),
              child: const Icon(
                Icons.chevron_left,
                color: Color(0xffA950C9),
                size: 30,
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 110.w,
            height: 110.h,
            child: RippleWave(
              repeat: true,
              color: const Color(0xff8C10B8),
              childTween: Tween(begin: 1, end: 1),
              child: SizedBox(
                  width: 40.w,
                  height: 40.h,
                  child: SvgPicture.asset(
                    "assets/home/logbot.svg",
                  )),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 42.w,
            height: 42.h,
          ),
        ],
      ),
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final chatMessageType;
  const ChatMessageWidget(
      {super.key, required this.text, this.chatMessageType});

  @override
  Widget build(BuildContext context) {
    return chatMessageType == ChatMessageType.bot
        ? Padding(
            padding: const EdgeInsets.only(left: 20).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 80).r,
                  child: Container(
                    width: 300.w,
                    decoration: const BoxDecoration(
                        color: Color(0xff8C10B8),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                              left: 24, top: 18, bottom: 18, right: 24)
                          .r,
                      child: AnimatedTextKit(
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TyperAnimatedText(
                            text.trim(),
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 35.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                      color: Color(0xff8C10B8), shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    "assets/home/logbot.svg",
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 40).r,
                child: Container(
                  width: 300.w,
                  decoration: BoxDecoration(
                      color: const Color(0xffA950C9).withOpacity(0.25),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 24, top: 18, bottom: 18).r,
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          );
  }
}
