import 'package:flutter/material.dart';
import 'package:shoply/model/model.dart';
import 'package:shoply/app_pages/shop_page.dart'; // ✅ Import ShopPage
import 'package:shoply/app_pages/search_page.dart';
import 'package:shoply/app_pages/whishlist_page.dart';
import 'package:shoply/app_pages/product_page.dart';
import 'package:shoply/app_pages/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> isWishlisted = [];

  @override
  void initState() {
    super.initState();
    isWishlisted = List.generate(
      shops.expand((shop) => shop.products).length,
      (index) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F6FD),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 0, top: 10),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [Color(0xFF3DAFE7), Color(0xFF1A4C64)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            child: const Text(
              'Shoply',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              // ✅ Wishlist Button
              Padding(
                padding: const EdgeInsets.only(right: 12, top: 5),
                child: GestureDetector(
                  onTap: () {
                    // ✅ Navigate to WishlistPage with Back Button
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WishlistPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF267093),
                      border: Border.all(
                        color: const Color(0xFF267093),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                ),
              ),

              // ✅ Cart Button
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 5),
                child: GestureDetector(
                  onTap: () {
                    // ✅ Navigate to CartPage with Back Button
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CartPage(), // ✅ Navigate to CartPage
                      ),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF267093),
                      border: Border.all(
                        color: const Color(0xFF267093),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Following Section
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    const Text(
                      'Following',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SearchPage(), // ✅ Navigate to SearchPage
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          minimumSize: const Size(0, 28),
                          backgroundColor: const Color(0xFF267093),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'View More >',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ✅ Horizontal List of Followed Shops
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none, // ✅ Prevent shadow clipping
                  itemCount:
                      shops.where((shop) => shop.isFollowed).toList().length,
                  itemBuilder: (context, index) {
                    var followedShops =
                        shops.where((shop) => shop.isFollowed).toList();
                    var shop = followedShops[index];

                    return GestureDetector(
                      onTap: () {
                        // ✅ Navigate to ShopPage when tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopPage(shop: shop),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Material(
                          elevation:
                              18, // ✅ Increased elevation for deeper shadow
                          borderRadius: BorderRadius.circular(16),
                          shadowColor: Colors.black
                              .withOpacity(0.4), // ✅ Stronger shadow color
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xFF93B4C1),
                              image: shop.logo.isNotEmpty
                                  ? DecorationImage(
                                      image: AssetImage(shop.logo),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // ✅ Posts Section
              const Text(
                'Posts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // ✅ Vertical List of Posts
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: shops.expand((shop) => shop.products).length,
                itemBuilder: (context, index) {
                  var allProducts =
                      shops.expand((shop) => shop.products).toList();
                  var product = allProducts[index];

                  return GestureDetector(
                    onTap: () {
                      // ✅ Navigate to ProductPage when product is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(product: product),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Column(
                        children: [
                          // ✅ Product Image Box with Wishlist Button
                          Stack(
                            children: [
                              // ✅ Product Image with Hero Transition
                              Hero(
                                tag:
                                    'product_${product.name}', // ✅ Hero tag for smooth transition
                                child: Container(
                                  width: double.infinity,
                                  height: 320,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xFF93B4C1),
                                    image: product.image.isNotEmpty
                                        ? DecorationImage(
                                            image: AssetImage(product.image),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                ),
                              ),

                              // ✅ Wishlist Button in Bottom Right Corner
                              Positioned(
                                bottom: 12,
                                right: 12,
                                child: GestureDetector(
                                  onTap: () {
                                    // ✅ Update the product's wishlist status in the model
                                    setState(() {
                                      product.isWishlisted =
                                          !product.isWishlisted;
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 6,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      product.isWishlisted
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: product.isWishlisted
                                          ? Colors.red
                                          : Colors.grey,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // ✅ Product Name & Price (Centered)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${product.price} BD',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          // ✅ Product Short Description
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                product.shortDescription,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
