import 'package:flutter/material.dart';

import 'LetterDetailPage.dart';

class DictionaryPage extends StatelessWidget {
  // Generate a list of letters A-Z
  final List<String> letters = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));

  @override
  Widget build(BuildContext context) {
    // Determine the screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of items in a row based on the screen width
    int crossAxisCount = 5; // Default for mobile
    if (screenWidth > 600) {
      crossAxisCount = 7; // For tablets
    }
    if (screenWidth > 900) {
      crossAxisCount = 9; // For desktops
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
          'Chinhvarta Dictionary',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1, // Make items square
          ),
          itemCount: letters.length,
          itemBuilder: (context, index) {
            return _buildLetterTab(context, letters[index]);
          },
        ),
      ),
    );
  }

  // Method to Build Each Letter Tab
  Widget _buildLetterTab(BuildContext context, String letter) {
    return GestureDetector(
      onTap: () {
        // Navigate to the next page with the selected letter
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LetterDetailPage(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade200.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
      ),
    );
  }
}

// A placeholder page for letter details
// class LetterDetailPage extends StatelessWidget {
//   final String letter;
//
//   const LetterDetailPage({Key? key, required this.letter}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Words starting with $letter'),
//         backgroundColor: Colors.blue.shade100,
//       ),
//       body: Center(
//         child: Text(
//           'Content for letter $letter',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }