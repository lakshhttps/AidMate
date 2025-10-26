import 'package:flutter/material.dart';
import 'guide_detail_screen.dart';

class FirstAidScreen extends StatelessWidget {
  FirstAidScreen({super.key});

  final List<Map<String, dynamic>> firstAidItems = const [
    {
      "title": "Burns",
      "color": Colors.red,
      "icon": Icons.local_fire_department,
    },
    {
      "title": "Nosebleed",
      "color": Colors.pink,
      "icon": Icons.bloodtype_outlined,
    },
    {
      "title": "Choking",
      "color": Colors.orange,
      "icon": Icons.sentiment_very_dissatisfied,
    },
    {
      "title": "Heart Attack",
      "color": Colors.deepPurple,
      "icon": Icons.favorite,
    },
    {
      "title": "Fainting",
      "color": Colors.lightBlue,
      "icon": Icons.self_improvement,
    },
    {
      "title": "Snake Bite",
      "color": Colors.green,
      "icon": Icons.grass,
    },
    {
      "title": "Severe Bleeding",
      "color": Colors.teal,
      "icon": Icons.bloodtype,
    },
    {
      "title": "Heatstroke",
      "color": Colors.amber,
      "icon": Icons.wb_sunny,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Aid Guide'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: firstAidItems.map((item) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GuideDetailScreen(title: item['title']),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: item['color'].withOpacity(0.2),
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item['icon'],
                      size: 64,
                      color: item['color'],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
