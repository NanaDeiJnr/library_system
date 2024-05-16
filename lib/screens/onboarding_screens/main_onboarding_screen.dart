import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lmsystem_app/components/primary_button.dart';
import 'package:lmsystem_app/screens/auth_screens/login_screen.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import smooth_page_indicator package

class MainOnboardingScreen extends StatefulWidget {
  const MainOnboardingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainOnboardingScreenState createState() => _MainOnboardingScreenState();
}

class _MainOnboardingScreenState extends State<MainOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _buildScreen(
                    'Header Section 1',
                    SvgPicture.asset(
                      'assets/images/booking.svg',
                      height: 200,
                    ),
                    'Simplify Your Library Experience 1',
                    'Simplify your library experience with our user-friendly interface. Navigate effortlessly, discover resources quickly, and manage your bookings with ease. Enjoy a hassle-free library experience!',
                  ),
                  _buildScreen(
                    'Header Section',
                    SvgPicture.asset(
                      'assets/images/chat.svg',
                      height: 200,
                    ),
                    'Stay Connected Anytime, Anywhere',
                    'Stay connected with fellow students and librarians using our in-app messaging feature. Ask questions, share resources, and collaborate seamlessly within the app.',
                  ),
                  _buildScreen(
                    'Header Section 3',
                    SvgPicture.asset(
                      'assets/images/simple.svg',
                      height: 200,
                    ),
                    'Simplify Your Library Experience',
                    'Simplify your library experience with our user-friendly interface. Navigate effortlessly, discover resources quickly, and manage your bookings with ease. Enjoy a hassle-free library experience!',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SmoothPageIndicator( // Use SmoothPageIndicator instead of DotsIndicator
                controller: _pageController,
                count: 3,
                effect: const WormEffect(
                  dotHeight: 5
                ), // You can customize the effect
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: PrimaryButton(
                title: _currentPage == 2 ? 'Get Started' : 'Next',
                textColor: Colors.white,
                backgroundColor: MainColors.primaryColor,
                onTap: () {
                  if (_currentPage == 2) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()), // Replace MainScreen with your main screen
                    );
                  } else {
                    _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(String headerText, Widget image, String title, String description) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            headerText,
            style: GoogleFonts.workSans(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),

          const Spacer(),

          Center(child: image),

          const Spacer(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.workSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.workSans(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
