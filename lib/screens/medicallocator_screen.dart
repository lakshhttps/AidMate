import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MedicalLocatorScreen extends StatefulWidget {
  const MedicalLocatorScreen({super.key});

  @override
  State<MedicalLocatorScreen> createState() => _MedicalLocatorScreenState();
}

class _MedicalLocatorScreenState extends State<MedicalLocatorScreen> {
  List medicalFacilities = [];
  bool isLoading = true;
  String? errorMsg;
  Position? userPosition;

  @override
  void initState() {
    super.initState();
    _checkPermissionAndFetch();
  }

  Future<void> _checkPermissionAndFetch() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          isLoading = false;
          errorMsg = 'Location permission denied';
        });
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        isLoading = false;
        errorMsg =
            'Location permissions are permanently denied, please enable them in settings';
      });
      return;
    }

    // Permission granted, fetch hospitals
    _fetchMedicalFacilities();
  }

  Future<void> _fetchMedicalFacilities() async {
    try {
      userPosition = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // bounding box (~5 km)
      double delta = 0.05;
      double minLat = userPosition!.latitude - delta;
      double maxLat = userPosition!.latitude + delta;
      double minLon = userPosition!.longitude - delta;
      double maxLon = userPosition!.longitude + delta;

      final url =
          'https://nominatim.openstreetmap.org/search?format=json&amenity=hospital&bounded=1&viewbox=$minLon,$maxLat,$maxLon,$minLat&limit=15';

      final response = await http.get(Uri.parse(url), headers: {
        'User-Agent': 'AidMateApp/1.0 (laksh.arora1810@gmail.com)'
      });

      final data = json.decode(response.body);

      setState(() {
        medicalFacilities = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMsg = 'Failed to fetch hospitals: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medical Facilities')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMsg != null
              ? Center(child: Text(errorMsg!))
              : medicalFacilities.isEmpty
                  ? const Center(child: Text('No hospitals found nearby.'))
                  : ListView.separated(
                      itemCount: medicalFacilities.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final facility = medicalFacilities[index];
                        final lat = double.tryParse(facility['lat'] ?? '') ?? 0.0;
                        final lon = double.tryParse(facility['lon'] ?? '') ?? 0.0;

                        return ListTile(
                          leading:
                              const Icon(Icons.local_hospital, color: Colors.red),
                          title: Text(
                            facility['display_name']?.split(',').first.trim() ??
                                'Unknown',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle:
                              Text(facility['display_name'] ?? 'No details available'),
                          onTap: () async {
                              final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                              } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Could not open Google Maps')),
                                  );
                                }
                            },
                        );
                      },
                    ),
    );
  }
}
