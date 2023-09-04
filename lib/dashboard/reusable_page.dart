import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final Color cardColor;

  //  final Widget child;
  //   const TopCard({Key key, this.title}) : super(key: key);

  const TopCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.cardColor,
  }) : super(key: key);

  //const TopCard({super.key});

 

  //  Color _parseColor(String colorString) {
  //   // Function to parse a color string and convert it to a Color object
  //   String sanitizedColorString = colorString;
  //   if (sanitizedColorString.startsWith('#')) {
  //     sanitizedColorString = sanitizedColorString.substring(1); // Remove '#' if present
  //   }
  //   return Color(int.parse(sanitizedColorString, radix: 16));
  // }


  @override
  Widget build(BuildContext context) {
    //Color parsedColor = _parseColor(cardColor as String); // Convert string to Color
    //print(parsedColor); // Print the parsed color
     
    return Card(
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(55.0),
              child: Image.asset(
                image,
                height: 90,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final ImageProvider avatarImage;
  final String title;
  final String subtitle;

  const MyCard({super.key, 
    required this.avatarImage,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: avatarImage,
              radius: 30.0,
            ),
            const SizedBox(width: 18.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}