import 'dart:async';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/controllers/rtc_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logos/screens/psyc_profile/constant.dart';
import 'package:logos/screens/psyc_profile/end_call.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import '../../models/all_psyc_model.dart';

class VideCall extends StatefulWidget {
  static const routeName = "/video-call";
  const VideCall({super.key});

  @override
  State<VideCall> createState() => _VideCallState();
}

class _VideCallState extends State<VideCall> {
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
  int uid = 0; // uid of the local user
  @override
  void initState() {
    super.initState();
    // Set up an instance of Agora engine
    setupVideoSDKEngine().then((value) {
      join();
    });
    startTime = DateTime.now();
  }

  // Release the resources when you leave
  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    agoraEngine.release();
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
    agoraEngine.release();
    agoraEngine.leaveChannel();
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
}
