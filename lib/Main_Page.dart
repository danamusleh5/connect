import 'package:CampusConnect/ToDoList/ToDoList.dart';
import 'package:CampusConnect/Calendar/CalendarPage.dart';
import 'package:CampusConnect/Library/LibraryPage.dart';
import 'package:CampusConnect/Messages/NotificationsPage.dart';
import 'package:CampusConnect/PostWidget.dart';
import 'package:CampusConnect/UserPage/ProfilePage.dart';
import 'package:CampusConnect/UserPage/SettingsPage.dart';
import 'package:CampusConnect/WelocomeLogIn/About.dart';
import 'package:CampusConnect/WelocomeLogIn/LogInPage.dart';
import 'package:flutter/material.dart';
import 'package:CampusConnect/Posts.dart';
import 'package:CampusConnect/Library/PrevoisMaterial.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:CampusConnect/Messages/ChatListScreen.dart';
import 'package:provider/provider.dart';
import 'package:CampusConnect/Messages/ChatProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Posts> posts = [
  Posts(
    userName: 'Hadi',
    userImageUrl: 'https://picsum.photos/250?image=9',
    postImageUrl: 'https://picsum.photos/250?image=9',
    caption: 'ضيعت شنتتي في المجمع, حدا شافها؟',
    likeCounter: 0,
  ),

  Posts(
    userName: 'Hadi',
    userImageUrl: 'https://picsum.photos/250?image=9',
    postImageUrl: 'https://picsum.photos/250?image=9',
    caption: 'ضيعت شنتتي في المجمع, حدا شافها؟',
    likeCounter: 0,
  ),
  Posts(
    userName: 'Hadi',
    userImageUrl: 'https://picsum.photos/250?image=9',
    postImageUrl: 'https://picsum.photos/250?image=9',
    caption: 'ضيعت شنتتي في المجمع, حدا شافها؟',
    likeCounter: 0,
  ),
  // Add more posts as needed
];

class Main_Page extends StatefulWidget {
  const Main_Page({Key? key}) : super(key: key);

  @override
  Main_PageState createState() => Main_PageState();
}

class Main_PageState extends State<Main_Page> {
  int currentPage = 2;
  // Future<String> get _userName async => Globals.userID;

  final List<Widget> _pages = [
    const CalendarPage(),
    ProfilePage(),
    MainHomePage(),
    const NotificationsPage(),
    About(),
  ];

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'images/ConnectBZU.png', // Path to your logo image
                height: 20, // Adjust the height as needed
              ),
              SizedBox(width: 8), // Space between the logo and the title
              Text("0".tr),
            ],
          ),


          //   IconButton(
          //       icon: Icon(Icons.search),
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) =>
          //                 ChatListScreen(currentUserId: Globals.userID),
          //           ),
          //         );
          //       }),
           actions: <Widget>[

             IconButton(
              icon: const Icon(
                  Icons.message_rounded,
                  size: 23,
                  color: Colors.deepPurple,
              ),
              onPressed: () async {
                print("Messages tapped");
                if (Globals.Friends.isEmpty) {
                  print('No friends found');
                  return;
                }
                // Create chats for all friends if they don't exist
                for (String friendId in Globals.Friends) {
                  print(friendId);
                  print("HEY");
                  await chatProvider.createChat([Globals.userID, friendId]);
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatListScreen(currentUserId: Globals.userID),
                  ),
                );
              },
            ),
             SizedBox(width: 8),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [Colors.deepPurpleAccent, Colors.purple],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Adding the image
                    CircleAvatar(
                      radius: 38, // Adjust the size as needed
                      backgroundColor:
                          Colors.grey, // Add your desired background color
                      child: Icon(
                        Icons.person,
                        size: 50, // Adjust the icon size as needed
                        color: Colors.white, // Add your desired icon color
                      ), // Path to your image
                    ),
                    SizedBox(
                        width:
                            16), // Adding some space between the image and the text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Globals.userID, // First text
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        SizedBox(height: 8), // Adding some space between texts
                        Text(
                          "welcome".tr,
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontFamily: 'Nunito',
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(
                icon: Icons.calendar_month_outlined,
                title: "calendar".tr,
                onTap: () {
                  if (Globals.Schedule.contains("Private") ||
                      Globals.Schedule.contains("Public")) {
                  } else {
                    Globals.Schedule.add("Private");
                    Globals.Schedule.add("Public");
                  }
                  _navigateToPage(const CalendarPage());
                },
              ),
              _buildDrawerItem(
                icon: Icons.book_online_sharp,
                title: "library".tr,
                onTap: () => _navigateToPage(const LibraryPage()),
              ),
              _buildDrawerItem(
                icon: Icons.library_books_outlined,
                title: "previous".tr,
                onTap: () => _navigateToPage(const PreviousMaterial()),
              ),
              _buildDrawerItem(
                icon: Icons.person,
                title: "profile".tr,
                onTap: () => _navigateToPage(ProfilePage()),
              ),
              _buildDrawerItem(
                icon: Icons.notifications,
                title: "notification".tr,
                onTap: () => _navigateToPage(const NotificationsPage()),
              ),
              _buildDrawerItem(
                icon: Icons.settings,
                title: "settings".tr,
                onTap: () => _navigateToPage(const SettingsPage()),
              ),
              // _buildDrawerItem(
              //   icon: Icons.login,
              //   title: 'LogIn',
              //   onTap: () => _navigateToPage(LogInPage()),
              // ),
              _buildDrawerItem(
                icon: Icons.logout,
                title: "logout".tr,
                onTap: () => _navigateToPage(LogInPage()),
              ),
              _buildDrawerItem(
                icon: Icons.info,
                title: "about".tr,
                onTap: () => _navigateToPage(const About()),
              ),
              _buildDrawerItem(
                icon: Icons.view_timeline_outlined,
                title: "todolist".tr,
                onTap: () => _navigateToPage(ToDoList()),
              ),
            ],
          ),
        ),
        body: _pages[currentPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined), label: 'Calendar'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_sharp), label: 'Search'),

          ],
          backgroundColor:
              Colors.deepPurpleAccent, // Background color of the navigation bar
          selectedItemColor:
              Colors.deepPurple.shade700, // Color of the selected item
          unselectedItemColor:
              Colors.grey.shade700, // Color of the unselected items
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String title,
      required void Function() onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class MainHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostWidget(
              post: posts[index],
            );
          },
        ),
      ],
    );
  }
}
