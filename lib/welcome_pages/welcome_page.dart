import 'package:flutter/material.dart';
import 'package:shoply/home_screen/home_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int currentPage = 0; // To track the current page index

  final List<Map<String, String>> pages = [
    {
      "image": "assets/1.png",
      "title": "Your Ultimate Shopping Destination",
      "description":
          "Discover a wide range of products and shops, all in one place, tailored just for you!"
    },
    {
      "image": "assets/2.png",
      "title": "Explore Shops & Discover Products",
      "description":
          "Search effortlessly and explore your favorite shops. Find the products you love in seconds!"
    },
    {
      "image": "assets/3.png",
      "title": "Add, Checkout, Done!",
      "description":
          "Add your favorites to the cart, enjoy a seamless checkout experience, and get fast delivery to your doorstep."
    },
    {
      "image": "assets/4.png",
      "title": "Experience Shopping Like Never Before",
      "description":
          "Enjoy a smarter, faster, and more personalized shopping experience—right at your fingertips!"
    },
  ];

  void navigateToNextPage() {
    if (currentPage < pages.length - 1) {
      setState(() {
        currentPage++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          pages[currentPage]["image"]!,
                          width: 200, // Adjust the size of the image
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          pages[currentPage]["title"]!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          pages[currentPage]["description"]!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      width: currentPage == index ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? const Color(0xFF267093) // Active dot color
                            : Colors.grey, // Inactive dot color
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentPage != pages.length - 1)
                        ElevatedButton(
                          onPressed: skip,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 18, // Increase height
                            ),
                            backgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      if (currentPage != pages.length - 1)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: currentPage != pages.length - 1
                              ? 120
                              : 0, // Adjust width for transition
                          height: 50, // Increased height
                          child: ElevatedButton(
                            onPressed: navigateToNextPage,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              backgroundColor: const Color(0xFF267093),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      if (currentPage == pages.length - 1)
                        Expanded(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 50, // Increased height
                            child: ElevatedButton(
                              onPressed: navigateToNextPage,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                backgroundColor: const Color(0xFF267093),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Get Started",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                    ],
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
