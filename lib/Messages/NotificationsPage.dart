import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
   const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<String> notifications = List.generate(10, (index) => 'Notification ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(notifications[index]),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                notifications.removeAt(index);
              });
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.notifications),
              ),
              title: Text(notifications[index]),
              subtitle: Text('Notification Description ${index + 1}'),
              onTap: () {
                // Implement notification click functionality
              },
            ),
          );
        },
      ),
    );
  }
}
