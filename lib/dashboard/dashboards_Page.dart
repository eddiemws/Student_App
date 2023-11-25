import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

///import 'package:student_app/dashboard/images_Page.dart';  // Import the new file
import 'package:student_app/dashboard/reusable_page.dart';
import 'package:student_app/dashboard/images_Page.dart'; // Corrected import statement

class DashboardsPage extends StatelessWidget {
  DashboardsPage({super.key});

  late final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.calendar_month_outlined),
                    Text(
                      'Dashboard',
                      style: TextStyle(fontSize: 25),
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/passport1-photo.jpg'),
                      radius: 20.0,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            // ignore: sized_box_for_whitespace
            Container(
                height: 140,
                child: PageView(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  children: const [
                    TopCard(
                        title: 'Today',
                        subtitle: 'You have 12 tasks left to do',
                        image: 'images/today.png',
                        cardColor: Colors.blueGrey),
                    TopCard(
                        title: 'Week',
                        subtitle: 'You completed all the marked task',
                        image: 'images/week.png',
                        cardColor: Colors.green),
                    Tooltip(
                        message: 'Last month was an 80% completion rate',
                        child: TopCard(
                            title: 'month',
                            subtitle: 'Last month was a great month overall.',
                            image: 'images/month.png',
                            cardColor: Colors.black))
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: const ExpandingDotsEffect(),
            ),
            const SizedBox(
              height: 25,
            ),
            const ImagesDisplayPage(), // Use the new widget here
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Activity',
                    style: TextStyle(fontSize: 23, color: Colors.white)),
                Text('View history',
                    style: TextStyle(fontSize: 14, color: Colors.blue)),
              ],
            ),
            const MyCard(
                avatarImage: AssetImage('images/icon6.jpg'),
                title: 'Created a new task #5967',
                subtitle: '2 min ago'),
            const MyCard(
                avatarImage: AssetImage('images/icon3.jpg'),
                title: 'Created a subtask for #6789',
                subtitle: '30 min ago'),
            const MyCard(
                avatarImage: AssetImage('images/icon4.jpg'),
                title: 'Completed the task #8900',
                subtitle: '2 days ago'),
            const MyCard(
                avatarImage: AssetImage('images/icon7.jpeg'),
                title: 'Deleted the completed task',
                subtitle: '2 days ago'),
          ],
        )),
      ),
    );
  }
}
