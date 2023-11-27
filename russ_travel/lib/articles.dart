import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JsonScreen extends StatefulWidget {
  @override
  _JsonScreenState createState() => _JsonScreenState();
}

class _JsonScreenState extends State<JsonScreen> {
  String _jsonData = "";

  Future<void> fetchJsonData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _jsonData = jsonData.toString();
      });
    } else {
      setState(() {
        _jsonData = 'Failed to load data';
      });
    }
  }
  
  @override
  void initState() {
    super.initState();
    fetchJsonData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON Data'),
      ),
      body: Center(
        child: Text(_jsonData),
      ),
    );
  }
}
















