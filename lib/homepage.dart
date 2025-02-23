import 'package:flutter/material.dart';
import 'cart.dart';
import 'home.dart';
import 'profile_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentPage = 0;

  final List<Widget> pages = [
    const Home(),
    const CartDetails(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 35,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        selectedItemColor: Colors.yellow[700],
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: "Cart"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPage,
        children: pages
      ),
    );
  }
}