import 'package:flutter/material.dart';

class LangChangePage extends StatefulWidget {
  @override
  _LangChangePageState createState() => _LangChangePageState();
}

class _LangChangePageState extends State<LangChangePage> {
  final List<String> languages = [
    'English',
    'हिंदी',
    'தமிழ்',
    'తెలుగు',
    'বাংলা',
    'मराठी',
    'മലയാളം',
    'অসমীয়া',
    'ಕನ್ನಡ'
  ];

  String selectedLanguage = 'English'; // Default selected language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Chinhvarta',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Adjust grid based on available width
          int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Text(
                  'Language Preference',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Choose your preferred language',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 3,
                  ),
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedLanguage = languages[index];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedLanguage == languages[index]
                            ? Colors.blue
                            : Colors.white,
                        side: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        foregroundColor: selectedLanguage == languages[index]
                            ? Colors.white
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        languages[index],
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Save changes action
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Language changed to $selectedLanguage'),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

