import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencycontactsScreen extends StatelessWidget {
  const EmergencycontactsScreen({super.key});

  final List<Map<String, String>> contacts = const [
    {"name": "Police", "number": "100", "icon": "🚔"},
    {"name": "Ambulance", "number": "102", "icon": "🚑"},
    {"name": "Fire", "number": "101", "icon": "🔥"},
    {"name": "Women Helpline", "number": "181", "icon": "🚺"},
    {"name": "Road Accident Helpline", "number": "1073", "icon": "🛣️"},
    {"name": "Child Helpline", "number": "1098", "icon": "👶"},
    {"name": "Senior Citizen Helpline", "number": "14567", "icon": "👴"},
    {"name": "PwD Helpline", "number": "14456", "icon": "♿"},
    {"name": "Integrated Helpline", "number": "112", "icon": "☎️"},
  ];

  void _callNumber(String number) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: number
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Cannot call $number');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: contacts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12.0),
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              leading: Text(
                contact['icon']!,
                style: const TextStyle(fontSize: 28),
              ),
              title: Text(
                contact['name']!,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                contact['number']!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(Icons.call, color: Color.fromARGB(255, 4, 27, 233),),
              onTap: () => _callNumber(contact['number']!),
            ),
          );
        },
      ),
    );
  }
}