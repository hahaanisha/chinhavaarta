import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class FeedbackContributionPage extends StatefulWidget {
  @override
  _FeedbackContributionPageState createState() =>
      _FeedbackContributionPageState();
}

class _FeedbackContributionPageState extends State<FeedbackContributionPage> {
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _gestureNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> sendFeedback(String email, String gestureName, String feedback) async {
    final url = Uri.parse('http://localhost:8084/api/v1/executions/company.team/send_feedback_email'); // Replace with your Kestra server URL

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add fields
    request.fields['email'] = email;
    request.fields['gestureName'] = gestureName;
    request.fields['feedback'] = feedback;

    try {
      // Send the request
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Feedback Submitted'),
              content: Text('Thank you for your contribution! Our team will review your gesture soon.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Reset the form
                    _feedbackController.clear();
                    _gestureNameController.clear();
                    _emailController.clear();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Handle error
        print('Failed to submit feedback: ${response.statusCode}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Something went wrong while submitting your feedback. Please try again later.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Thanks for your feedback'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contribute to Chinhavarta'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Email Input
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  hintText: 'Enter your email address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || !RegExp(r"[^@]+@[a-zA-Z]+\.[a-zA-Z]+").hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Gesture Name Input
              TextFormField(
                controller: _gestureNameController,
                decoration: InputDecoration(
                  labelText: 'Gesture Name',
                  hintText: 'Enter the name of the sign language gesture',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a gesture name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Feedback Input
              TextFormField(
                controller: _feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Additional Feedback',
                  hintText: 'Provide any additional information about the gesture',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String email = _emailController.text;
                    String gestureName = _gestureNameController.text;
                    String feedback = _feedbackController.text;
                    sendFeedback(email, gestureName, feedback);
                  }
                },
                child: Text('Submit Contribution'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    _gestureNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
