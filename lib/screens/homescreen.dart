import 'package:flutter/material.dart';
import 'firstaid_screen.dart';
import 'emergencycontacts_screen.dart';
import 'medicallocator_screen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {"title": "First Aid Guide", "icon": Icons.health_and_safety, "color": Colors.red, "screen": FirstAidScreen()},
      {"title": "Helpline Hub", "icon": Icons.contacts, "color":Colors.blue, "screen": const EmergencycontactsScreen()},
      {"title": "Medic Locator", "icon": Icons.location_on, "color": Colors.green, "screen": const MedicalLocatorScreen()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AidMate',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 60.0),
        padding: const EdgeInsets.all(30.0),
        child: ListView.separated(
          itemCount: features.length,
          separatorBuilder: (context, index) => const SizedBox(height: 80.0),
          itemBuilder: (context, index) {
            final feature = features[index];
            return Card(
              color: feature['color'].withOpacity(0.2),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
               child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                leading: Icon(feature['icon'], size: 40, color: feature['color']),
                title: Text(
                  feature['title'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: feature['color'].shade700,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18,),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => feature['screen'],
                    ),
                  );
                },
               ), 
            );
          },
        )
      ),
    );
  }
}