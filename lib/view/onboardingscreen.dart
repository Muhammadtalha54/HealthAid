import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Loginscreen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: "Welcome to HealthAid!",
      description: "Your personal guide to mental well-being.",
      image: "assets/on1.png",
    ),
    // OnboardingPage(
    //   title: "Personalized Suggestions",
    //   description: "Get tailored health tips based on your mood analysis.",
    //   image: "assets/on1.png",
    // ),
    // OnboardingPage(
    //   title: "Track Your Progress",
    //   description: "Visualize your mood trends over time.",
    //   image: "assets/on2.png",
    // ),
    OnboardingPage(
      title: "Set Your Preferences",
      description: "Customize how you'll input your mood and preferences.",
      image: "assets/on2.png",
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  void _skipToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double padding = screenWidth * 0.04; // 4% of screen width
    final double imageSize = screenWidth * 0.6; // 60% of screen width
    final double fontSizeTitle = screenWidth * 0.06; // 6% of screen width
    final double fontSizeDescription = screenWidth * 0.04; // 4% of screen width
    final double buttonHeight = screenHeight * 0.07; // 7% of screen height

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _pages[index];
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _skipToLogin,
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSizeDescription,
                        ),
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: _pages.length,
                      effect: WormEffect(
                        dotColor: Colors.white.withOpacity(0.5),
                        activeDotColor: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _nextPage,
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? "Get Started"
                            : "Next",
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        backgroundColor: Colors.white,
                        minimumSize: Size(buttonHeight, buttonHeight),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double imageSize = screenWidth * 0.6; // 60% of screen width
    final double fontSizeTitle = screenWidth * 0.06; // 6% of screen width
    final double fontSizeDescription = screenWidth * 0.04; // 4% of screen width

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: imageSize,
            width: imageSize,
          ),
          SizedBox(height: screenWidth * 0.1),
          Text(
            title,
            style: TextStyle(
              fontSize: fontSizeTitle,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenWidth * 0.04),
          Text(
            description,
            style: TextStyle(
              fontSize: fontSizeDescription,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
