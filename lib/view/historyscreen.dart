import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class MoodHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    // Self-defined values for the pie chart
    final Map<String, double> pieChartData = {
      'Happy': 50.0, // 50% of the data
      'Neutral': 30.0, // 30% of the data
      'Sad': 20.0, // 20% of the data
    };

    final Map<String, Color> colorMap = {
      'Happy': Colors.blue,
      'Neutral': Colors.grey,
      'Sad': Colors.red,
    };

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.04),
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.07,
              ),
              Text(
                'Profile & Settings',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: screenSize.height * 0.4,
                child: Center(
                  // Center the PieChart
                  child: PieChart(
                    dataMap: pieChartData,
                    colorList: colorMap.values
                        .toList(), // Use color values for the chart
                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    centerText: "Mood",
                    legendOptions: LegendOptions(
                      showLegends: false, // Disable default legend
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: screenSize.height *
                      0.02), // Space between chart and color legend
              Column(
                children: colorMap.entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: entry.value,
                        ),
                        SizedBox(width: 8),
                        Text(
                          entry.key,
                          style: TextStyle(fontSize: screenSize.width * 0.04),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: screenSize.height * 0.03),
              ElevatedButton(
                onPressed: () {},
                child: Text('Export Data'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, screenSize.height * 0.06),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
