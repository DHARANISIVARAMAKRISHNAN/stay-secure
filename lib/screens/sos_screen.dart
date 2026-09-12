import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  int _countdown = 5;
  Timer? _timer;
  bool _triggered = false;
  String _status = 'Tap CANCEL to stop, or wait to send SOS alert';

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
      });
      if (_countdown <= 0) {
        timer.cancel();
        _triggerSos();
      }
    });
  }

  void _cancelSos() {
    _timer?.cancel();
    Navigator.pop(context);
  }

  Future<void> _triggerSos() async {
    setState(() {
      _triggered = true;
      _status = 'Getting your location...';
    });

    // Step 1: Check and request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position? position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      setState(() => _status = 'Could not get location. Sending alert anyway.');
    }

    // Step 2: Send SOS event to backend
    setState(() => _status = 'Notifying backend...');
    await ApiService.sendSosAlert(
      position?.latitude ?? 0.0,
      position?.longitude ?? 0.0,
    );

    // Step 3: Open SMS app with location link (user taps send)
    setState(() => _status = 'Opening SMS to trusted contacts...');
    if (position != null) {
      final mapsLink =
          'https://maps.google.com/?q=${position.latitude},${position.longitude}';
      final smsUri = Uri.parse(
          'sms:?body=I need help! My location: $mapsLink - Sent via Stay Secure App');
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      }
    }

    setState(() => _status = 'SOS Alert sent. Stay safe.');
  }

  Future<void> _callEmergencyNumber(String number) async {
    final callUri = Uri.parse('tel:$number');
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_triggered) ...[
                Text(
                  '$_countdown',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  _status,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 18),
                  ),
                  onPressed: _cancelSos,
                  child: const Text('CANCEL', style: TextStyle(fontSize: 18)),
                ),
              ] else ...[
                const Icon(Icons.check_circle, color: Colors.white, size: 80),
                const SizedBox(height: 20),
                Text(
                  _status,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () => _callEmergencyNumber('100'),
                  child: const Text('Call Police (100)'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('I am safe now'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
