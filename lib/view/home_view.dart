import 'package:example/controller/home_controller.dart';
import 'package:example/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce Shop'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const CategoryTabs(),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.carts.isEmpty) {
                return const Center(
                  child: Text('No products available'),
                );
              } else {
                return ProductGrid(carts: controller.carts);
              }
            }),
          ),
        ],
      ),
      floatingActionButton: Icon(Icons.abc),
    );
  }
}

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [
          CategoryTab(title: 'All Products'),
          CategoryTab(title: 'Jackets'),
          CategoryTab(title: 'Sneakers'),
          CategoryTab(title: 'Nike Air Max'),
          CategoryTab(title: 'Nike Origanis'),
        ],
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String title;
  const CategoryTab({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final RxList<CartModel> carts;
  const ProductGrid({super.key, required this.carts});

  @override
  Widget build(BuildContext context) {
    // Get all products from all carts
    final allProducts = <Products>[];
    for (var cart in carts) {
      allProducts.addAll(cart.products);
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.8,
      ),
      itemCount: allProducts.length,
      itemBuilder: (context, index) {
        return ProductCard(product: allProducts[index]);
      },
    );
  }
}

class ProductCard extends StatefulWidget {
  final Products product;
  ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(widget.product.thumbnail),
                fit: BoxFit.cover,
              ),
            ),
            // child: Stack(
            //   children: [
            //     // Trending Now badge
            //     Positioned(
            //       top: 8,
            //       left: 8,
            //       child: Container(
            //         padding:
            //             const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //         decoration: BoxDecoration(
            //           color: Colors.red,
            //           borderRadius: BorderRadius.circular(4),
            //         ),
            //         child: const Text(
            //           'Trending Now',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 10,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //     ),
            //     // Out of Stock badge (if needed)
            //     if (product.price > 150)
            //       Positioned(
            //         top: 8,
            //         right: 8,
            //         child: Container(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 8, vertical: 4),
            //           decoration: BoxDecoration(
            //             color: Colors.grey[700],
            //             borderRadius: BorderRadius.circular(4),
            //           ),
            //           child: const Text(
            //             'Out of Stock',
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 10,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ),
            //       ),
            //   ],
            // ),
          ),
          // Product Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${widget.product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      // Add to cart functionality
                      setState(() {
                        isSelected = !isSelected;
                      });
                      // Get.snackbar(
                      //   'Added to Cart',
                      //   '${product.title} added to your cart',
                      //   snackPosition: SnackPosition.BOTTOM,
                      // );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green : Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8), // نفس البادينغ تبع الزر
                      alignment: Alignment.center,
                      child: Text(
                        isSelected ? "Added" : 'Add to Cart',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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
