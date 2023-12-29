import 'package:flutter/material.dart';

class CalendarsPage extends StatefulWidget {
  const CalendarsPage({super.key});

  @override
  State<CalendarsPage> createState() => _dashboards_PageState();
}

// ignore: camel_case_types
class _dashboards_PageState extends State<CalendarsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: const Center(
        child: Text('i will create calendar data late'),
      ),
    );
  }
}

