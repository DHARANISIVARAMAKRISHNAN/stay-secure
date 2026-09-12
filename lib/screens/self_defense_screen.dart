import 'package:flutter/material.dart';

class SelfDefenseScreen extends StatelessWidget {
  const SelfDefenseScreen({super.key});

  final List<String> _tips = const [
    'Stay alert and aware of your surroundings at all times.',
    'Keep your phone charged and easily accessible.',
    'Share your live location with trusted contacts when traveling alone.',
    'Learn basic self-defense moves like palm strikes and knee strikes.',
    'Trust your instincts — if a situation feels unsafe, leave immediately.',
    'Carry a personal safety alarm or whistle.',
    'Avoid poorly lit or isolated areas, especially at night.',
    'Memorize emergency numbers: Police 100, Women Helpline 181.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Self-Defense Guide'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _tips.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text('${index + 1}',
                    style: const TextStyle(color: Colors.white)),
              ),
              title: Text(_tips[index]),
            ),
          );
        },
      ),
    );
  }
}
