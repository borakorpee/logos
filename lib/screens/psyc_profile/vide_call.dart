import 'dart:async';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/screens/psyc_profile/constant.dart';
import 'package:logos/screens/psyc_profile/end_call.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

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
    setupVideoSDKEngine();
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

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

// Build UI
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as Map<String, Psychologists?>;
    final Psychologists? psyc = args["provider"];
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: Text(psyc!.name.toString() + psyc.surName.toString()),
          actions: [
            ElevatedButton(
              onPressed: _isJoined ? null : () => {join()},
              child: const Text("Join"),
            ),
            ElevatedButton(
              onPressed: _isJoined ? () => {leave(psyc)} : null,
              child: const Text("Leave"),
            ),
          ],
        ),
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
                  width: 150.w,
                  height: 150.h,
                  child: _localPreview(),
                ),
              ),
            ),
            AgoraVideoButtons(
              disableVideoButtonChild: ElevatedButton(
                onPressed: _isJoined ? () => {leave(psyc)} : null,
                child: const Text("Leave"),
              ),
              client: client,
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
    super.dispose();

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
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }
}


/*ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          children: [
            // Container for the local video
            Container(
              height: 240,
              decoration: BoxDecoration(border: Border.all()),
              child: Center(child: _localPreview()),
            ),

            const SizedBox(height: 10),
            //Container for the Remote video
            Container(
              height: 240,
              decoration: BoxDecoration(border: Border.all()),
              child: Center(child: _remoteVideo()),
            ),
            // Button Row
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isJoined ? null : () => {join()},
                    child: const Text("Join"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isJoined ? () => {leave()} : null,
                    child: const Text("Leave"),
                  ),
                ),
              ],
            ),
            // Button Row ends

            GestureDetector(
              onTap: () async {
                DateTime endTime = DateTime.now();

                Navigator.of(context)
                    .popAndPushNamed(AfterCallScreen.routeName, arguments: {
                  "starttime": startTime,
                  "endtime": endTime,
                  "provider": psyc,
                });
                super.dispose();

                await agoraEngine.leaveChannel();
                agoraEngine.release();
              },
              child: Container(
                width: 100.w,
                height: 50.h,
                color: Colors.red,
                child: const Center(
                  child: Text("bitir"),
                ),
              ),
            )
          ],
        ),*/


        