import 'package:flutter/material.dart';
import 'package:shoply/app_pages/home_page.dart';
import 'package:shoply/app_pages/search_page.dart';
import 'package:shoply/app_pages/orders_page.dart';
import 'package:shoply/app_pages/admin_page/admin_users_page.dart';
import 'package:shoply/app_pages/admin_page/admin_shops_page.dart';
import 'package:shoply/app_pages/admin_page/admin_create_shop_page.dart';
import 'package:shoply/registration/admin_pass_page.dart';
import 'package:shoply/app_pages/shop_pages/shop_interface_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoply',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AdminPassPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // List of pages to navigate between
  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const OrdersPage(), // Report page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, -2), // Shadow upwards
            ),
          ],
        ),
        padding:
            const EdgeInsets.only(top: 8), // Add padding to center items better
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor:
              Colors.transparent, // Transparent to keep custom container color
          selectedItemColor: const Color(0xFF2A567F), // Selected item color
          unselectedItemColor: Colors.grey,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            // Home Button
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? _buildSelectedItem(Icons.home_outlined, 'Home')
                  : const Icon(Icons.home_outlined),
              label: '',
            ),

            // Search Button
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? _buildSelectedItem(Icons.search, 'Search')
                  : const Icon(Icons.search),
              label: '',
            ),

            // Orders Button
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? _buildSelectedItem(Icons.assignment_outlined, 'Orders')
                  : const Icon(Icons.assignment_outlined),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  // Custom selected item design
  Widget _buildSelectedItem(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF88B2D9), // Selected background color
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: const Color(0xFF2A567F), // Icon color
            size: 20,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF2A567F), // Text color
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
