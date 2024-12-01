import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class FeedbackContributionPage extends StatefulWidget {
  @override
  _FeedbackContributionPageState createState() => _FeedbackContributionPageState();
}

class _FeedbackContributionPageState extends State<FeedbackContributionPage> {
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _gestureNameController = TextEditingController();

  File? _mediaFile;
  String? _mediaType;

  final _formKey = GlobalKey<FormState>();

  Future<void> _pickMedia() async {
    final ImagePicker picker = ImagePicker();

    // Show a dialog to choose between image, video, or cancel
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Media Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Image'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _mediaFile = File(pickedFile.path);
                      _mediaType = 'image';
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text('Video'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? pickedFile = await picker.pickVideo(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _mediaFile = File(pickedFile.path);
                      _mediaType = 'video';
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitContribution() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement actual submission logic
      // This could include:
      // 1. Upload media file to a server
      // 2. Send feedback and gesture details
      // 3. Show a success dialog

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Contribution Submitted'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                SizedBox(height: 16),
                Text('Thank you for your contribution!'),
                Text('Our team will review your gesture soon.'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Reset form
                  _feedbackController.clear();
                  _gestureNameController.clear();
                  setState(() {
                    _mediaFile = null;
                    _mediaType = null;
                  });
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
        title: Text('Contribute to Chinhvarta'),
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

              // Media Upload Section
              Text(
                'Upload Gesture Media',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _pickMedia,
                icon: Icon(Icons.upload_file),
                label: Text('Select Image/Video'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Display selected media
              if (_mediaFile != null) ...[
                SizedBox(height: 16),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _mediaType == 'image' ? Icons.image : Icons.video_library,
                          size: 50,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8),
                        Text(
                          _mediaType == 'image'
                              ? 'Image Selected'
                              : 'Video Selected',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

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
                onPressed: _submitContribution,
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
    super.dispose();
  }
}