import 'package:chinhavaarta/screens/DictionaryPPTPage.dart';
import 'package:chinhavaarta/screens/LangChangePage.dart';
import 'package:chinhavaarta/screens/dictionaty.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChinhvartaApp());
}

class ChinhvartaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChinhvartaHomePage(),
    );
  }
}

class ChinhvartaHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust layout based on screen width
    bool isDesktop = screenWidth > 900;
    int gridCrossAxisCount = isDesktop ? 4 : 2;
    double gridChildAspectRatio = isDesktop ? 2 : 3 / 2;
    double padding = isDesktop ? 40 : 20;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Chinhvarta',
              style: TextStyle(
                color: Colors.black,
                fontSize: isDesktop ? 28 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(Icons.notifications, color: Colors.black),
                SizedBox(width: 10),
                Icon(Icons.search, color: Colors.black),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Section
            Container(
              padding: EdgeInsets.all(padding),
              color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Tejas!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isDesktop ? 32 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome to Chinhvarta: Your Gateway to Seamless Communication Through Sign Language. Explore, Connect, and Empower!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isDesktop ? 20 : 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Learn More',
                      style: TextStyle(fontSize: isDesktop ? 18 : 16),
                    ),
                  ),
                ],
              ),
            ),

            // Explore Section
            Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore Chinhvarta',
                    style: TextStyle(
                      fontSize: isDesktop ? 24 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'An inclusive community built for you',
                    style: TextStyle(fontSize: isDesktop ? 18 : 16),
                  ),
                  SizedBox(height: 20),
                  GridView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridCrossAxisCount,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: gridChildAspectRatio,
                    ),
                    children: [
                      _buildFeatureCard(
                        context: context,
                        icon: Icons.camera_alt,
                        title: 'Capture Video',
                        page: CameraPage(),
                      ),
                      _buildFeatureCard(
                        context: context,
                        icon: Icons.book,
                        title: 'Dictionary',
                        page: DictionaryPage(),
                      ),
                      _buildFeatureCard(
                        context: context,
                        icon: Icons.people,
                        title: 'Community',
                        page: DictionaryPPTPage(),
                      ),
                      _buildFeatureCard(
                        context: context,
                        icon: Icons.group_work,
                        title: 'Community ISL',
                        page: LangChangePage(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Footer Section
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '10000+',
                        style: TextStyle(
                          fontSize: isDesktop ? 24 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Registered Members'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '5000+',
                        style: TextStyle(
                          fontSize: isDesktop ? 24 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Daily Users'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Widget page,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder Pages
class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Capture Video')),
      body: Center(child: Text('Camera Page')),
    );
  }
}

// class DictionaryPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Dictionary')),
//       body: Center(child: Text('Dictionary Page')),
//     );
//   }
// }

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community')),
      body: Center(child: Text('Community Page')),
    );
  }
}

class CommunityISLPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community ISL')),
      body: Center(child: Text('Community ISL Page')),
    );
  }
}
