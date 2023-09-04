import 'package:flutter/material.dart';

class ImagesDisplayPage extends StatefulWidget {
  const ImagesDisplayPage({super.key});

  @override
  ImagesDisplayPageState createState() => ImagesDisplayPageState();
}

class ImagesDisplayPageState extends State<ImagesDisplayPage> {
  int _selectedImageIndex = 0;

  final List<String> _imageUrls = [
    'assets/images/chart2.png',
    'assets/images/chart1.jpg',
    'assets/images/chart3.jpg',
  ];

  void _selectImage(int index) {
    setState(() {
      _selectedImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => _selectImage(0),
              child: Container(
                decoration: BoxDecoration(
                    color: _selectedImageIndex == 0 ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(10),
                width: 100,
                height: 40,
                child: const Center(
                  child: Text(
                    'overview',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _selectImage(1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _selectedImageIndex == 1
                      ? Colors.deepPurpleAccent[400]
                      : Colors.grey,
                ),
                margin: const EdgeInsets.all(10),
                width: 100,
                height: 40,
                child: const Center(
                  child: Text(
                    'My Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _selectImage(2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _selectedImageIndex == 2 ? Colors.black : Colors.grey,
                ),
                margin: const EdgeInsets.all(10),
                width: 100,
                height: 40,
                child: const Center(
                  child: Text(
                    'Data Tools',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image.asset(
            _imageUrls[_selectedImageIndex],
            width: 300,
            height: 300,
          ),
        ),
      ],
    );
  }
}
