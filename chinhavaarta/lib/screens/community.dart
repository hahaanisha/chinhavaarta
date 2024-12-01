import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(Community());
}

class Community extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CommunityPage(),
    );
  }
}

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final List<Map<String, String>> organizations = [
    {
      'name': 'Stephen School for the Deaf and Aphasic',
      'image': 'assets/images/Stephen.png',
      'location': 'https://maps.app.goo.gl/ZSWsAfWHyZeb9B397',
    },
    {
      'name': 'Pragati Karnabadir & Matimand Vidyalaya',
      'image': 'assets/images/pragati.png',
      'location': 'https://maps.app.goo.gl/6oNjJRaKP6VHhxaL9',
    },
    {
      'name': 'Shree Nakoda Karna Badhir Vidyalaya',
      'image': 'assets/images/nakoda.png',
      'location': 'https://maps.app.goo.gl/gaKmBApLQBYdDDbx7',
    },

    {
      'name': 'Kamalini Karnabadhir High School',
      'image': 'assets/images/kamalini.jpg',
      'location': 'https://maps.app.goo.gl/NZ8J9yihkJt9Y5qZ8',
    },
    {
      'name': 'Hands Speak',
      'image': 'https://via.placeholder.com/150',
      'location': 'https://www.google.com/maps?q=location5',
    },
    {
      'name': 'Deaf Outreach',
      'image': 'https://via.placeholder.com/150',
      'location': 'https://www.google.com/maps?q=location6',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: organizations.length, vsync: this);
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Organizations'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: organizations.map((org) {
            return Tab(
              text: org['name'],
              icon: Icon(Icons.school, size: 30), // Replacing image with a school icon
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: organizations.map((org) {
          return Center(
            child: InkWell(
              onTap: () => _launchURL(org['location']!),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    org['image']!,
                    width: 400, // Increased the image size
                    height: 400, // Increased the image size
                  ),
                  SizedBox(height: 10),
                  Text(
                    org['name']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _launchURL(org['location']!),
                    child: Text('Open Location on Google Maps'),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
