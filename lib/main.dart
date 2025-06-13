import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:api/api.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final Map<String, dynamic> data = jsonDecode(jsonString);

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    final List<dynamic> backdropList = data['info']['backdrop_path'];
    final String? backdropUrl = backdropList.isNotEmpty
        ? backdropList.first
        : null;
    final String title = data['info']['name'] ?? 'No title';
    final String plot = data['info']['plot'] ?? 'No description';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Movie Details')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20,),
              if (backdropUrl != null)
                Image.network(backdropUrl)
              else
                const Text('No backdrop available'),
                SizedBox(height: 20,),
                Text(plot, style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
