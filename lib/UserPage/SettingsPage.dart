import 'package:CampusConnect/UserPage/ChangePasswordPage.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkModeEnabled = false;
  String selectedLanguage = 'English';
  bool areNotificationsEnabled = true;
  bool isAutoSaveEnabled = false;
  bool isLocationEnabled = true;
  double fontSize = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: Text('Dark Mode'),
                subtitle: Text('Enable or disable dark mode'),
                value: isDarkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    isDarkModeEnabled = value;
                    // Perform action to change theme to dark mode
                  });
                },
              ),
              ListTile(
                title: Text('Language'),
                subtitle: DropdownButton<String>(
                  value: selectedLanguage,
                  onChanged: (newValue) {
                    setState(() {
                      selectedLanguage = newValue!;
                      // Perform action to change app language
                    });
                  },
                  items: ['English', 'Arabic', 'Spanish', 'French'].map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                ),
              ),
              SwitchListTile(
                title: Text('Notifications'),
                subtitle: Text('Enable or disable notifications'),
                value: areNotificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    areNotificationsEnabled = value;
                    // Perform action to enable or disable notifications
                  });
                },
              ),
              SwitchListTile(
                title: Text('Auto Save'),
                subtitle: Text('Enable or disable auto save feature'),
                value: isAutoSaveEnabled,
                onChanged: (value) {
                  setState(() {
                    isAutoSaveEnabled = value;
                    // Perform action to enable or disable auto save feature
                  });
                },
              ),
              SwitchListTile(
                title: Text('Location'),
                subtitle: Text('Enable or disable location services'),
                value: isLocationEnabled,
                onChanged: (value) {
                  setState(() {
                    isLocationEnabled = value;
                    // Perform action to enable or disable location services
                  });
                },
              ),
              ListTile(
                title: Text('Font Size: ${fontSize.toInt()}'),
                subtitle: Slider(
                  value: fontSize,
                  min: 12,
                  max: 24,
                  divisions: 4,
                  onChanged: (value) {
                    setState(() {
                      fontSize = value;
                      // Perform action to change font size
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Change Password'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                  );
                },
              ),
              // Add more settings as needed
            ],
          ),
        ),
      ),
    );
  }
}


