import 'package:flutter/material.dart';
import 'package:shoply/model/model.dart';
import 'package:shoply/app_pages/product_page.dart';

class ShopPage extends StatefulWidget {
  final Shop shop;

  const ShopPage({super.key, required this.shop});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late bool isFollowing;

  @override
  void initState() {
    super.initState();
    isFollowing = widget.shop.isFollowed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ✅ Background Section (Keep Original Size)
          SliverAppBar(
            expandedHeight: 200, // ✅ Keep Original Size
            pinned: true,
            stretch: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // ✅ Background Image
                  Positioned.fill(
                    child: widget.shop.backgroundImage.isNotEmpty
                        ? Image.asset(
                            widget.shop.backgroundImage,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: const Color(0xFF93B4C1),
                          ),
                  ),

                  // ✅ Dark Overlay for Contrast
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // ✅ Draggable Content Section (WITH RADIUS)
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), // ✅ Keep Radius
                  topRight: Radius.circular(24), // ✅ Keep Radius
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Shop Info Section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ✅ Shop Logo (Square)
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(12), // ✅ Square edges
                          color: const Color(0xFF93B4C1),
                          image: widget.shop.logo.isNotEmpty
                              ? DecorationImage(
                                  image: AssetImage(widget.shop.logo),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: widget.shop.logo.isEmpty
                            ? const Icon(Icons.store,
                                size: 40, color: Colors.grey)
                            : null,
                      ),
                      const SizedBox(width: 12),

                      // ✅ Shop Name and Description
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.shop.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.shop.description,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ✅ Follow Button
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isFollowing = !isFollowing;
                        widget.shop.isFollowed = isFollowing;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFollowing
                          ? Colors.grey[400]
                          : const Color(0xFF246793),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isFollowing ? 'Following' : 'Follow',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // ✅ Product Grid Section
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = widget.shop.products[index];
                  return _buildProductCard(product);
                },
                childCount: widget.shop.products.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16, // ✅ Increased from 12 → 16
                mainAxisSpacing: 20, // ✅ Increased from 12 → 20
                childAspectRatio: 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Product Card
  Widget _buildProductCard(Product product) {
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: () {
            // ✅ Navigate to ProductPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(product: product),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // ✅ Center content horizontally
              children: [
                // ✅ Product Image + Like Button
                Stack(
                  children: [
                    Hero(
                      tag:
                          'product_${product.name}', // ✅ Hero transition for smooth animation
                      child: Container(
                        height: 160, // ✅ Keep original product image size
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
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          // ✅ Update the model's wishlist status
                          setState(() {
                            product.isWishlisted = !product.isWishlisted;
                          });
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            product.isWishlisted
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                product.isWishlisted ? Colors.red : Colors.grey,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // ✅ Product Name (Centered)
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center, // ✅ Center text
                ),

                const SizedBox(height: 4),

                // ✅ Product Short Description (Centered)
                Text(
                  product.shortDescription,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 4),

                // ✅ Product Price (Centered)
                Text(
                  '${product.price.toStringAsFixed(2)} BD',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
