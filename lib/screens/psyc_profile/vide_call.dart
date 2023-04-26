import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/controllers/rtc_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:logos/screens/psyc_profile/constant.dart';
import 'package:logos/screens/psyc_profile/end_call.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import '../../models/all_psyc_model.dart';
import 'package:http/http.dart' as http;

import '../forgot_pass/email_OTP.dart';

//const GPTprompt =
//  """Cümledeki Bağlaçlar  ve edatlar (ve, ile, fakat, ya da, hem .. hem, de, gibi, üzere, için, kadar) hariç tüm kelimelerin köklerini bul ve bulduğun bu kökleri içerisinde string olarak ve "," işareti ile ayrılmış şekilde kök1,kök2 şeklinde yaz eğer kökü bulamadıysan "bulunamadı" olarak yaz : """;
const GPTprompt =
    """Sana verilen cümledeki edatlar ve bağlaçlar "hariç" tüm kelimelerin köklerini bul ve bulduğun kökleri kök1,kök2 şeklinde virgülle ayır """;

class VideCall extends StatefulWidget {
  static const routeName = "/video-call";
  const VideCall({super.key});

  @override
  State<VideCall> createState() => _VideCallState();
}

class _VideCallState extends State<VideCall> {
  String kelimeler = '';
  String lastsent = "";
  final SpeechToText speech = SpeechToText();
  late Timer _timer;
  double _top = 0;
  double _left = 0;
  DateTime? startTime;
  String channelName = "wdj";
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: AGORA_appId,
      channelName: "wdj",
      tempToken: AGORA_token,
      uid: 0,
    ),
  );
  int uid = 0;
  @override
  void initState() {
    super.initState();
    setupVideoSDKEngine().then((value) {
      join();
    });
    Timer(Duration(seconds: 3), () {
      var client =
          Provider.of<ClientProvider>(context, listen: false).get_client;
      log(client.token.toString());
      initSpeechState(client.token.toString());
    });

    startTime = DateTime.now();
  }

  void startListening() {
    log("başla");

    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: 365),
      partialResults: true,
      localeId: 'tr-TR',
      listenMode: ListenMode.confirmation,
      onDevice: true,
    );
  }

  Future<void> getResponse(String text, String token) async {
    String openaiUrl = 'https://api.openai.com/v1/chat/completions';
    String openaiKey = OPENAI_KEY;
    Map<String, dynamic> requestBody = {
      'model': 'gpt-4',
      "messages": [
        {"role": "user", "content": """ $GPTprompt $text """}
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
    //   log("GPT: " + data['choices'][0]["message"]["content"]);

    String roots = data['choices'][0]["message"]["content"];

    var talkk = await http
        .put(Uri.parse("$root/talk/put?64468401978e155dc2498e1f"), headers: {
      "x-access-token": token,
    }, body: {
      "Talk": text,
      "word": roots,
    });
    var dat = jsonDecode(talkk.body);
    log(dat.toString());
  }

  Future<void> initSpeechState(String cltoken) async {
    var hasSpeech =
        await speech.initialize().then((value) => startListening()).then(
              (value) => _timer = Timer.periodic(
                Duration(seconds: 5),
                (timer) {
                  String previousText = lastsent;
                  String currentText = speech.lastRecognizedWords;

                  if (currentText == previousText) {
                    return;
                  } else {
                    int maxLength = currentText.length < previousText.length
                        ? currentText.length
                        : previousText.length;

                    int index = 0;
                    while (index < maxLength &&
                        currentText[index] == previousText[index]) {
                      index++;
                    }

                    String differentText = currentText.substring(index);
                    //  log(differentText);
                    differentText.length < 3
                        ? log("gönderme")
                        : getResponse(differentText, cltoken);
                    previousText = currentText;
                    lastsent = currentText;
                  }
                },
              ),
            );
  }

  // Release the resources when you leave
  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    agoraEngine.release();
    _timer.cancel();
    speech.stop();
    super.dispose();
  }

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance

  bool mutemic = false;

// Build UI
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as Map<String, Psychologists?>;
    final Psychologists? psyc = args["provider"];
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: _remoteVideo(),
            ),
            Positioned(
              left: _left,
              top: _top,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _left += details.delta.dx;
                    _top += details.delta.dy;
                  });
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: 140.w,
                  height: 205.h,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: _localPreview(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xff1E1E1E).withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                width: double.infinity,
                height: 185.h,
                child: AgoraVideoButtons(
                  buttonAlignment: Alignment.bottomCenter,
                  disableVideoButtonChild: GestureDetector(
                    onTap: () {
                      toggleCamera(
                        sessionController: client.sessionController,
                      );
                      setState(() {});
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 58.w,
                          height: 58.h,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.16),
                              shape: BoxShape.circle),
                          child: SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: client.sessionController.value
                                      .isLocalVideoDisabled
                                  ? SvgPicture.asset(
                                      "assets/videocall/closecam.svg",
                                      fit: BoxFit.scaleDown,
                                    )
                                  : SvgPicture.asset(
                                      "assets/videocall/opencam.svg",
                                      fit: BoxFit.scaleDown,
                                    )),
                        ),
                        Text(
                          "Kamerayı Kapat",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  muteButtonChild: GestureDetector(
                    onTap: () {
                      toggleMute(
                        sessionController: client.sessionController,
                      );
                      setState(() {});
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 58.w,
                          height: 58.h,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.16),
                              shape: BoxShape.circle),
                          child: SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: client
                                      .sessionController.value.isLocalUserMuted
                                  ? SvgPicture.asset(
                                      "assets/videocall/mutemic.svg",
                                      fit: BoxFit.scaleDown,
                                    )
                                  : SvgPicture.asset(
                                      "assets/videocall/unmute.svg",
                                      fit: BoxFit.scaleDown,
                                    )),
                        ),
                        Text(
                          "Sesi Kapat",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  switchCameraButtonChild: GestureDetector(
                    onTap: () {
                      switchCamera(sessionController: client.sessionController);
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 58.w,
                          height: 58.h,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.16),
                              shape: BoxShape.circle),
                          child: SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: SvgPicture.asset(
                              "assets/videocall/switch_Cam.svg",
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Text(
                          "Kamerayı Çevir",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  disconnectButtonChild: GestureDetector(
                    onTap: () {
                      leave(psyc);
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 58.w,
                          height: 58.h,
                          decoration: const BoxDecoration(
                              color: Color(0xffEB5545), shape: BoxShape.circle),
                          child: SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: SvgPicture.asset(
                              "assets/videocall/Vector.svg",
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Text(
                          "Kapat",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  client: client,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> leave(Psychologists? psyc) async {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    DateTime endTime = DateTime.now();

    Navigator.of(context)
        .popAndPushNamed(AfterCallScreen.routeName, arguments: {
      "starttime": startTime,
      "endtime": endTime,
      "provider": psyc,
    });

    await agoraEngine.leaveChannel();

    //agoraEngine.release();
    //agoraEngine.leaveChannel();
    //super.dispose();
  }

  void join() async {
    await agoraEngine.startPreview();

    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: AGORA_token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

// Display local video preview
  Widget _localPreview() {
    if (_isJoined) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: 0),
        ),
      );
    } else {
      return const Text(
        'Join a channel',
        textAlign: TextAlign.center,
      );
    }
  }

// Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(
              uid: _remoteUid, renderMode: RenderModeType.renderModeHidden),
          connection: RtcConnection(channelId: channelName),
        ),
      );
    } else {
      String msg = '';
      if (_isJoined) msg = 'Waiting for a remote user to join';
      return Text(
        msg,
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: AGORA_appId));

    await agoraEngine.enableVideo();

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  void resultListener(SpeechRecognitionResult result) {
    kelimeler = result.recognizedWords;
  }
}
