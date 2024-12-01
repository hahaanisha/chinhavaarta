import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Chinhvarta'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo or Header Image
            Center(
              child: Container(
                width: 200,  // Keep the original container size
                height: 200, // Keep the original container size
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade50,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 120,   // Reduced image width
                    height: 120,  // Reduced image height
                    fit: BoxFit.contain, // Ensures the entire image is visible
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // App Description
            Text(
              'Chinhvarta: Bridging Communication Gaps',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Our mission is to make sign language accessible, understandable, and inclusive for everyone. Chinhvarta is more than an app - it\'s a platform that empowers communication and understanding.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 24),

            // Key Features Section
            Text(
              'Key Features',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            _buildFeatureItem(
              icon: Icons.video_library,
              title: 'Comprehensive Video Dictionary',
              description: 'Learn sign language through clear, detailed video demonstrations.',
            ),
            _buildFeatureItem(
              icon: Icons.camera_alt,
              title: 'Video Capture & Learning',
              description: 'Record and analyze your sign language gestures for improvement.',
            ),
            _buildFeatureItem(
              icon: Icons.group_work,
              title: 'Interactive Quizzes',
              description: 'Test and enhance your sign language skills through engaging quizzes.',
            ),

            SizedBox(height: 24),

            // Contact and Social Section
            Text(
              'Connect With Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            _buildSocialButton(
              icon: Icons.email,
              label: 'Email Us',
              onTap: () => _launchUrl('mailto:support@chinhvarta.com'),
            ),
            _buildSocialButton(
              icon: Icons.web,
              label: 'View More',
              onTap: () => _launchUrl('https://linktr.ee/Chinhvarta'),
            ),

            SizedBox(height: 24),

            // Version and Legal
            Center(
              child: Text(
                'Version 1.0.0\n© 2024 Chinhvarta. All Rights Reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 30),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
