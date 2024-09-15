// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// void main() {
//   runApp(MentalHealthCompanionApp());
// }

// class MentalHealthCompanionApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Mental Health Companion',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   final List<Widget> _children = [
//     DashboardScreen(),
//     ChatScreen(),
//     CheckInScreen(),
//     ResourcesScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mental Health Companion'),
//       ),
//       body: _children[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: onTabTapped,
//         currentIndex: _currentIndex,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard),
//             label: 'Dashboard',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat),
//             label: 'Chat',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.check_circle_outline),
//             label: 'Check-in',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.library_books),
//             label: 'Resources',
//           ),
//         ],
//       ),
//     );
//   }

//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
// }

// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Welcome back! How are you feeling today?',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ),
//           MoodSelector(),
//           SizedBox(height: 20),
//           HealthTrackingChart(),
//           SizedBox(height: 20),
//           DailyTipCard(),
//         ],
//       ),
//     );
//   }
// }

// class MoodSelector extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         MoodButton(emoji: '😊', label: 'Happy'),
//         MoodButton(emoji: '😐', label: 'Neutral'),
//         MoodButton(emoji: '😢', label: 'Sad'),
//         MoodButton(emoji: '😠', label: 'Angry'),
//       ],
//     );
//   }
// }

// class MoodButton extends StatelessWidget {
//   final String emoji;
//   final String label;

//   const MoodButton({Key? key, required this.emoji, required this.label}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Text(emoji, style: TextStyle(fontSize: 40)),
//         Text(label),
//       ],
//     );
//   }
// }

// class HealthTrackingChart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       padding: EdgeInsets.all(16),
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(show: false),
//           borderData: FlBorderData(show: false),
//           minX: 0,
//           maxX: 6,
//           minY: 0,
//           maxY: 6,
//           lineBarsData: [
//             LineChartBarData(
//               spots: [
//                 FlSpot(0, 3),
//                 FlSpot(1, 2),
//                 FlSpot(2, 4),
//                 FlSpot(3, 3),
//                 FlSpot(4, 5),
//                 FlSpot(5, 3),
//               ],
//               isCurved: true,
//               color: Colors.blue,
//               barWidth: 4,
//               isStrokeCapRound: true,
//               dotData: FlDotData(show: false),
//               belowBarData: BarAreaData(show: false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DailyTipCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(16),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Daily Tip',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Take a few deep breaths when you feel stressed. It can help calm your mind and body.',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ChatScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Expanded(
//           child: ListView(
//             children: <Widget>[
//               ChatBubble(
//                 message: "Hello! How can I assist you today?",
//                 isUser: false,
//               ),
//               ChatBubble(
//                 message: "I'm feeling a bit anxious about my upcoming presentation.",
//                 isUser: true,
//               ),
//               ChatBubble(
//                 message: "I understand. It's normal to feel anxious about presentations. Would you like some tips to manage your anxiety?",
//                 isUser: false,
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Type your message...',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.send),
//                 onPressed: () {
//                   // Send message logic
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ChatBubble extends StatelessWidget {
//   final String message;
//   final bool isUser;

//   const ChatBubble({Key? key, required this.message, required this.isUser}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isUser ? Colors.blue : Colors.grey[300],
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           message,
//           style: TextStyle(color: isUser ? Colors.white : Colors.black),
//         ),
//       ),
//     );
//   }
// }

// class CheckInScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Daily Check-in',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Text('How would you rate your mood today?'),
//             Slider(
//               value: 3,
//               min: 1,
//               max: 5,
//               divisions: 4,
//               onChanged: (value) {},
//             ),
//             SizedBox(height: 20),
//             Text('Have you experienced any of the following today?'),
//             CheckboxListTile(
//               title: Text('Anxiety'),
//               value: false,
//               onChanged: (bool? value) {},
//             ),
//             CheckboxListTile(
//               title: Text('Depression'),
//               value: false,
//               onChanged: (bool? value) {},
//             ),
//             CheckboxListTile(
//               title: Text('Stress'),
//               value: false,
//               onChanged: (bool? value) {},
//             ),
//             SizedBox(height: 20),
//             Text('Any additional notes?'),
//             TextField(
//               maxLines: 3,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text('Submit Check-in'),
//               onPressed: () {
//                 // Submit check-in logic
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ResourcesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: <Widget>[
//         ResourceCard(
//           title: 'Meditation Techniques',
//           description: 'Learn various meditation techniques to reduce stress and anxiety.',
//           icon: Icons.self_improvement,
//         ),
//         ResourceCard(
//           title: 'Emergency Contacts',
//           description: 'List of helplines and emergency contacts for immediate support.',
//           icon: Icons.emergency,
//         ),
//         ResourceCard(
//           title: 'Self-Care Tips',
//           description: 'Daily self-care practices to improve your mental well-being.',
//           icon: Icons.favorite,
//         ),
//         ResourceCard(
//           title: 'Find a Therapist',
//           description: 'Directory of licensed therapists in your area.',
//           icon: Icons.person,
//         ),
//       ],
//     );
//   }
// }

// class ResourceCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final IconData icon;

//   const ResourceCard({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.icon,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8),
//       child: ListTile(
//         leading: Icon(icon),
//         title: Text(title),
//         subtitle: Text(description),
//         trailing: Icon(Icons.arrow_forward_ios),
//         onTap: () {
//           // Navigate to resource details
//         },
//       ),
//     );
//   }
// }