import 'package:api/Activity.dart';
import 'package:flutter/material.dart';
import 'package:api/api_2.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isLoading = false;
  String? error;
  Activity data = Activity(
    activity: "",
    availability: 0.0,
    type: "",
    participants: 0,
    price: 0.0,
    accessibility: "",
    duration: "",
    kidFriendly: false,
    link: "",
    key: "",
  );
  ApiService api = ApiService();

  Future<void> onPressed() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final response = await api.getActivity();
      setState(() {
        data = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Random Activities')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading) const CircularProgressIndicator(),
                if (error != null)
                    Text(error!, style: const TextStyle(color: Colors.red)),
                if (!isLoading && error == null && data.activity.isNotEmpty)
                Card(
                  margin: EdgeInsets.all(16),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.event),
                          title: Text(
                            data.activity.isNotEmpty
                                ? data.activity
                                : "No Activity",
                          ),
                          subtitle: Text("Type: ${data.type}"),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.people),
                          title: Text("Participants: ${data.participants}"),
                          subtitle: Text(
                            "Kid Friendly: ${data.kidFriendly ? "Yes" : "No"}",
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.access_time),
                          title: Text("Duration: ${data.duration}"),
                          subtitle: Text("Availability: ${data.availability}"),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text("Price: ${data.price}"),
                          subtitle: Text("Accessibility: ${data.accessibility}"),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.link),
                          title: Text(
                            data.link.isNotEmpty
                                ? data.link
                                : "No Link Available",
                            style: TextStyle(
                              color: data.link.isNotEmpty
                                  ? Colors.blue
                                  : Colors.grey,
                              decoration: data.link.isNotEmpty
                                  ? TextDecoration.underline
                                  : null,
                            ),
                          ),
                          onTap: data.link.isNotEmpty && Uri.tryParse(data.link)?.hasAbsolutePath == true
    ? () {
        launchUrlString(data.link);
      }
    : null,
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.vpn_key),
                          title: Text("Key: ${data.key}"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: onPressed,
                      child: Text('Show Activities'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          data = Activity(
                            activity: "",
                            availability: 0.0,
                            type: "",
                            participants: 0,
                            price: 0.0,
                            accessibility: "",
                            duration: "",
                            kidFriendly: false,
                            link: "",
                            key: "",
                          );
                          error = null;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                      ),
                      child: Text('Clear'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
