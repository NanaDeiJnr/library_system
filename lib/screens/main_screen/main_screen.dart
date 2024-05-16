import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lmsystem_app/components/custom_navbar_item.dart';
import 'package:lmsystem_app/screens/main_screen/navigation_screens/booking_screen.dart';
import 'package:lmsystem_app/screens/main_screen/navigation_screens/chat_screen.dart';
import 'package:lmsystem_app/screens/main_screen/navigation_screens/home_screen.dart';
import 'package:lmsystem_app/screens/main_screen/navigation_screens/profile_screen.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class MainScreen extends StatefulWidget {
  final bool? isSelected;
  final User user;
  const MainScreen({super.key, this.isSelected, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  void _onBottomNavTapped(int index){
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: _onPageChanged,
            children: [
              HomeScreen(user: widget.user,),
              const BookingScreen(),
              const ChatScreen(),
              const ProfileScreen()
            ],
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MainColors.primaryColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomNavBarItem(
                      icon: Ionicons.home,
                      label: 'Home',
                      isSelected: _currentIndex == 0,
                      onTap: () => _onBottomNavTapped(0),
                    )
                  ),

                  Expanded(
                    child: CustomNavBarItem(
                      icon: Ionicons.book,
                      label: 'Booking',
                      isSelected: _currentIndex == 1,
                      onTap: () => _onBottomNavTapped(1),
                    )
                  ),

                  Expanded(
                    child: CustomNavBarItem(
                      icon: Ionicons.people,
                      label: 'Chat',
                      isSelected: _currentIndex == 2,
                      onTap: () => _onBottomNavTapped(2),
                    )
                  ),

                  Expanded(
                    child: CustomNavBarItem(
                      icon: Icons.person,
                      label: 'Home',
                      isSelected: _currentIndex == 3,
                      onTap: () => _onBottomNavTapped(3),
                    )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}