import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../WelocomeLogIn/LogInPage.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSwitch = false;
  bool? isChecked = false;
  late String _imagePath = '';
  late String _userName = '';
  late String _userID = '';
  late String _major = '';
  late List<String> _schedule = [];

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    _loadUserData();
  }

  Future<void> _loadProfileImage() async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String imagePath = appDirectory.path + '/profile_image.jpg';

    if (File(imagePath).existsSync()) {
      setState(() {
        _imagePath = imagePath;
      });
    }
  }

  Future<void> _loadUserData() async {
    await Globals.loadFromPreferences();
    setState(() {
      _userName = Globals.userID;
      _userID = Globals.roll;
      _major = Globals.courseName;
      _schedule = Globals.Schedule;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final String newPath = appDirectory.path + '/profile_image.jpg';
      final File newImage = await File(pickedFile.path).copy(newPath);

      setState(() {
        _imagePath = newImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Add logout functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          backgroundImage: _imagePath.isNotEmpty
                              ? FileImage(File(_imagePath))
                              : null,
                          child: _imagePath.isEmpty
                              ? Icon(Icons.add_a_photo, size: 40, color: Colors.grey)
                              : null,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _userName.isNotEmpty ? _userName : 'User Name',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        _userID.isNotEmpty ? 'ID: $_userID' : 'ID: 12345',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        _major.isNotEmpty ? 'Major: $_major' : 'Major: Computer Science',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Schedule: ${_schedule.isNotEmpty ? _schedule.join(", ") : 'No schedule available'}',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Edit Profile');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text('Edit Profile', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                'Notifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Switch(
                value: isSwitch,
                onChanged: (value) {
                  setState(() {
                    isSwitch = value;
                  });
                },
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                'Preferences',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
            ),
            const Divider(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// class Globals {
//   static String userID = "";
//   static String roll = "";
//   static List<String> Schedule = [];
//   static List<String> Friends = [];
//   static String courseName = "";
//   static List<Map<String, Map<String, List<String>>>> categories = [];
//
//   static Future<void> saveToPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('userID', userID);
//     await prefs.setString('roll', roll);
//     await prefs.setStringList('Schedule', Schedule);
//     await prefs.setStringList('Friends', Friends);
//     await prefs.setString('courseName', courseName);
//   }
//
//   static Future<void> loadFromPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userID = prefs.getString('userID') ?? '';
//     roll = prefs.getString('roll') ?? '';
//     Schedule = prefs.getStringList('Schedule') ?? [];
//     Friends = prefs.getStringList('Friends') ?? [];
//     courseName = prefs.getString('courseName') ?? '';
//   }
// }
