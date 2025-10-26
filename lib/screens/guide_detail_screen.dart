import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart'; // ✅ add this import

class GuideDetailScreen extends StatefulWidget {
  final String title;
  const GuideDetailScreen({super.key, required this.title});

  @override
  State<GuideDetailScreen> createState() => _GuideDetailScreenState();
}

class _GuideDetailScreenState extends State<GuideDetailScreen> {
  Map<String, dynamic>? item;

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    final String response = await rootBundle.loadString('lib/data/first_aid_data.json');
    final List<dynamic> data = json.decode(response);
    final found = data.firstWhere((element) => element['title'] == widget.title);
    setState(() {
      item = found;
    });
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the link')),
      );
    }
  }

  Widget _buildSection(String heading, dynamic content, Color color, {bool isList = false}) {
    final isSource = heading == "Source"; 
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(heading,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 8),
            if (isList)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (content as List<dynamic>)
                    .map((i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("• ", style: TextStyle(fontSize: 16, height: 1.4)),
                              Expanded(
                                  child: Text(i,
                                      style: const TextStyle(fontSize: 16, height: 1.4))),
                            ],
                          ),
                        ))
                    .toList(),
              )
            else if (isSource)
              GestureDetector(
                onTap: () => _launchURL(content.toString()),
                child: Text(
                  content.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            else
              Text(
                content.toString(),
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(item!['title'])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("Symptoms", item!['symptoms'], const Color.fromARGB(255, 245, 205, 6)),
            _buildSection("Do's", item!['dos'], Colors.green, isList: true),
            _buildSection("Don'ts", item!['donts'], Colors.red, isList: true),
            _buildSection("Source", item!['source'], Colors.blue),
          ],
        ),
      ),
    );
  }
}
