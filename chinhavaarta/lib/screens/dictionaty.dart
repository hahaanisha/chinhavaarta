import 'package:flutter/material.dart';

class DictionaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Determine the screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of items in a row based on the screen width
    int crossAxisCount = 4; // Default for mobile
    if (screenWidth > 600) {
      crossAxisCount = 6; // For tablets
    }
    if (screenWidth > 900) {
      crossAxisCount = 8; // For desktops
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: Text(
          'Chinhvarta',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          // Grid View of Items
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount, // Dynamic count based on screen size
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: 24, // Number of items
              itemBuilder: (context, index) {
                return _buildGridItem();
              },
            ),
          ),
          // "See More" Button
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle "See More" action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(double.infinity, 50), // Full-width button
              ),
              child: Text('See More'),
            ),
          ),
        ],
      ),
    );
  }

  // Method to Build Each Grid Item
  Widget _buildGridItem() {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: Image.asset(
            'images/Greeting.png', // Replace with actual image path
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Greetings',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
