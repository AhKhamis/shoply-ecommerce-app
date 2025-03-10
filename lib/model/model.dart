import 'dart:math';

class Product {
  final String name;
  final String shortDescription;
  final String longDescription;
  final int quantity;
  final String image;
  final double price;
  final String category;
  bool isWishlisted; // ✅ Wishlist status
  bool isInCart; // ✅ Added isInCart field

  Product({
    required this.name,
    required this.shortDescription,
    required this.longDescription,
    required this.quantity,
    required this.image,
    required this.price,
    required this.category,
    this.isWishlisted = false,
    this.isInCart = false, // ✅ Default to false
  });
}

class Shop {
  final String name;
  final String description;
  bool isFollowed;
  final String logo;
  final String backgroundImage;
  final List<Product> products;

  Shop({
    required this.name,
    required this.description,
    required this.isFollowed,
    required this.logo,
    required this.backgroundImage,
    required this.products,
  });
}

List<Shop> shops = [
  // ✅ Beauty Shop (Health Products Category)
  Shop(
    name: "Beauty Haven",
    description: "Premium skincare and beauty products for radiant skin.",
    isFollowed: true,
    logo: "assets/shop1.png",
    backgroundImage: "assets/shopbackground1.png",
    products: [
      Product(
        name: "Hydrating Face Cream",
        shortDescription: "Moisturizing and refreshing",
        longDescription:
            "A lightweight hydrating face cream that locks in moisture and gives a fresh look all day long.",
        quantity: 20,
        image: "assets/product1.png",
        price: 29.99,
        category: "Health Products",
      ),
      Product(
        name: "Anti-Aging Night Cream",
        shortDescription: "Reduces fine lines",
        longDescription:
            "This night cream works overnight to reduce wrinkles and fine lines, leaving your skin smooth and youthful.",
        quantity: 15,
        image: "assets/product2.png",
        price: 39.99,
        category: "Health Products",
      ),
      Product(
        name: "Vitamin C Serum",
        shortDescription: "Brightens and firms skin",
        longDescription:
            "A powerful Vitamin C serum that brightens the skin and reduces dark spots, giving you a radiant glow.",
        quantity: 30,
        image: "assets/product3.png",
        price: 25.99,
        category: "Health Products",
      ),
    ],
  ),

  // ✅ Furniture Shop (Furniture Category)
  Shop(
    name: "Home Comfort",
    description: "Modern and stylish furniture for your home.",
    isFollowed: true,
    logo: "assets/shop2.png",
    backgroundImage: "assets/shopbackground2.png",
    products: [
      Product(
        name: "Wooden Cabinet",
        shortDescription: "Elegant and spacious",
        longDescription:
            "A beautifully crafted wooden cabinet that provides ample storage space while adding elegance to your room.",
        quantity: 10,
        image: "assets/product7.png",
        price: 150.00,
        category: "Furniture",
      ),
      Product(
        name: "Luxury Couch",
        shortDescription: "Comfortable and stylish",
        longDescription:
            "A luxurious couch made with high-quality materials, providing unmatched comfort and style.",
        quantity: 8,
        image: "assets/product8.png",
        price: 500.00,
        category: "Furniture",
      ),
      Product(
        name: "Glass Cabinet",
        shortDescription: "Modern and minimalist design",
        longDescription:
            "A modern glass cabinet with a minimalist design, perfect for showcasing your favorite items.",
        quantity: 5,
        image: "assets/product9.png",
        price: 200.00,
        category: "Furniture",
      ),
    ],
  ),

  // ✅ Makeup Shop (Accessories Category)
  Shop(
    name: "Glam Up",
    description: "Top-quality makeup products for a stunning look.",
    isFollowed: true,
    logo: "assets/shop3.png",
    backgroundImage: "assets/shopbackground3.png",
    products: [
      Product(
        name: "Makeup Brush Set",
        shortDescription: "Soft and precise",
        longDescription:
            "A set of high-quality makeup brushes for easy application and flawless blending.",
        quantity: 12,
        image: "assets/product13.png",
        price: 19.99,
        category: "Accessories",
      ),
      Product(
        name: "Matte Lipstick",
        shortDescription: "Long-lasting color",
        longDescription:
            "A long-lasting matte lipstick available in a variety of shades for every occasion.",
        quantity: 6,
        image: "assets/product14.png",
        price: 12.99,
        category: "Accessories",
      ),
      Product(
        name: "Foundation Brush",
        shortDescription: "Smooth and even application",
        longDescription:
            "A soft foundation brush designed to provide smooth and even coverage.",
        quantity: 20,
        image: "assets/product15.png",
        price: 14.99,
        category: "Accessories",
      ),
    ],
  ),

  // ✅ Construction Materials Shop (Construction Category)
  Shop(
    name: "Builder's Mart",
    description: "High-quality tools and materials for your projects.",
    isFollowed: true,
    logo: "assets/shop4.png",
    backgroundImage: "assets/shopbackground4.png",
    products: [
      Product(
        name: "Steel Screws",
        shortDescription: "Rust-resistant and durable",
        longDescription:
            "A pack of 100 steel screws designed to resist rust and provide strong holding power.",
        quantity: 25,
        image: "assets/product10.png",
        price: 10.00,
        category: "Construction",
      ),
      Product(
        name: "Heavy Duty Hammer",
        shortDescription: "Strong and balanced",
        longDescription:
            "A heavy-duty hammer with a strong handle for all types of construction work.",
        quantity: 18,
        image: "assets/product11.png",
        price: 25.00,
        category: "Construction",
      ),
      Product(
        name: "Electric Drill",
        shortDescription: "High-speed and powerful",
        longDescription:
            "An electric drill with variable speed settings for precise and fast drilling.",
        quantity: 10,
        image: "assets/product12.png",
        price: 75.00,
        category: "Construction",
      ),
    ],
  ),

  // ✅ Fashion Shop (Women Category)
  Shop(
    name: "Trendy Bags",
    description: "Stylish and functional bags for every occasion.",
    isFollowed: true,
    logo: "assets/shop5.png",
    backgroundImage: "assets/shopbackground5.png",
    products: [
      Product(
        name: "Leather Handbag",
        shortDescription: "Premium leather",
        longDescription:
            "A chic leather handbag made from premium materials. Spacious and elegant.",
        quantity: 50,
        image: "assets/product4.png",
        price: 120.00,
        category: "Women",
      ),
      Product(
        name: "Tote Bag",
        shortDescription: "Casual and spacious",
        longDescription:
            "A large and stylish tote bag, perfect for daily use and carrying essentials.",
        quantity: 20,
        image: "assets/product5.png",
        price: 60.00,
        category: "Women",
      ),
      Product(
        name: "Crossbody Bag",
        shortDescription: "Lightweight and secure",
        longDescription:
            "A lightweight and secure crossbody bag, designed for convenience and style.",
        quantity: 30,
        image: "assets/product6.png",
        price: 75.00,
        category: "Women",
      ),
    ],
  ),
];

// ✅ Added category to Order Model for consistency

class OrderItem {
  final String name;
  final String shortDescription;
  final String longDescription;
  final int quantity;
  final String image;
  final double price;

  OrderItem({
    required this.name,
    required this.shortDescription,
    required this.longDescription,
    required this.quantity,
    required this.image,
    required this.price,
  });
}

class Order {
  final String serialNumber;
  final String status; // New field for status (Pending or Completed)
  final DateTime date; // New field for order date
  final List<OrderItem> items;

  Order({
    required this.serialNumber,
    required this.status,
    required this.date,
    required this.items,
  });
}

// Function to generate a random 6-digit serial number
String generateSerialNumber() {
  Random random = Random();
  return (100000 + random.nextInt(900000)).toString(); // Ensures 6 digits
}

// Sample data for orders
List<Order> orders = [
  // ✅ Single Order - Completed
  Order(
    serialNumber: generateSerialNumber(),
    status: 'Completed',
    date: DateTime(2025, 3, 5), // Example random date
    items: [
      OrderItem(
        name: "Hydrating Face Cream",
        shortDescription: "Moisturizing and refreshing",
        longDescription:
            "A lightweight hydrating face cream that locks in moisture and gives a fresh look all day long.",
        quantity: 2,
        image: "assets/product1.png",
        price: 29.99,
      ),
    ],
  ),

  // ✅ Single Order - Pending
  Order(
    serialNumber: generateSerialNumber(),
    status: 'Pending',
    date: DateTime(2025, 2, 28), // Example random date
    items: [
      OrderItem(
        name: "Luxury Couch",
        shortDescription: "Comfortable and stylish",
        longDescription:
            "A luxurious couch made with high-quality materials, providing unmatched comfort and style.",
        quantity: 1,
        image: "assets/product8.png",
        price: 500.00,
      ),
    ],
  ),

  // ✅ Multi-Item Order - Completed
  Order(
    serialNumber: generateSerialNumber(),
    status: 'Completed',
    date: DateTime(2025, 1, 15), // Example random date
    items: [
      OrderItem(
        name: "Matte Lipstick",
        shortDescription: "Long-lasting color",
        longDescription:
            "A long-lasting matte lipstick available in a variety of shades for every occasion.",
        quantity: 2,
        image: "assets/product14.png",
        price: 12.99,
      ),
      OrderItem(
        name: "Electric Drill",
        shortDescription: "High-speed and powerful",
        longDescription:
            "An electric drill with variable speed settings for precise and fast drilling.",
        quantity: 1,
        image: "assets/product12.png",
        price: 75.00,
      ),
      OrderItem(
        name: "Leather Handbag",
        shortDescription: "Premium leather",
        longDescription:
            "A chic leather handbag made from premium materials. Spacious and elegant.",
        quantity: 1,
        image: "assets/product4.png",
        price: 120.00,
      ),
    ],
  ),
];
