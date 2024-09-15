import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class VoiceMessageWidget extends StatefulWidget {
  final Function(String) onSend;

  const VoiceMessageWidget({Key? key, required this.onSend}) : super(key: key);

  @override
  _VoiceMessageWidgetState createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget> {
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  String? _recordingPath;
  Timer? _timer;
  int _recordingDuration = 0;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();
  }

  Future<void> _startRecording() async {
    try {
      final directory = await getTemporaryDirectory();
      _recordingPath = '${directory.path}/voice_message.aac';
      await _recorder!.startRecorder(toFile: _recordingPath);
      setState(() {
        _isRecording = true;
        _recordingDuration = 0;
      });
      _startTimer();
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _recorder!.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      _stopTimer();
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _cancelRecording() {
    _stopRecording();
    File(_recordingPath!).deleteSync();
    setState(() {
      _recordingPath = null;
      _recordingDuration = 0;
    });
  }

  void _sendVoiceMessage() {
    if (_recordingPath != null) {
      widget.onSend(_recordingPath!);
      setState(() {
        _recordingPath = null;
        _recordingDuration = 0;
      });
    }
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTapDown: (_) => _startRecording(),
            onTapUp: (_) => _stopRecording(),
            onTapCancel: _cancelRecording,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isRecording ? Colors.red : Colors.blue,
              ),
              child: Icon(
                _isRecording ? Icons.stop : Icons.mic,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _isRecording
                ? Text(
                    'Recording... ${_formatDuration(_recordingDuration)}',
                    style: TextStyle(fontSize: 16),
                  )
                : _recordingPath != null
                    ? Text(
                        'Voice message recorded (${_formatDuration(_recordingDuration)})',
                        style: TextStyle(fontSize: 16),
                      )
                    : Text(
                        'Hold to record, release to send',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
          ),
          if (_recordingPath != null && !_isRecording)
            IconButton(
              icon: Icon(Icons.send, color: Colors.blue),
              onPressed: _sendVoiceMessage,
            ),
          if (_recordingPath != null && !_isRecording)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: _cancelRecording,
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    _timer?.cancel();
    super.dispose();
  }
}