import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

class OwnerProducts extends StatelessWidget {
  const OwnerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const _OwnerProductsBody();
  }
}

class _OwnerProductsBody extends StatefulWidget {
  const _OwnerProductsBody();

  @override
  State<_OwnerProductsBody> createState() => _OwnerProductsBodyState();
}

class _OwnerProductsBodyState extends State<_OwnerProductsBody> {
  final TextEditingController searchController = TextEditingController();
  String selectedCategory = "All";

  final List<String> categories = const [
    "All",
    "Engine",
    "Brakes",
    "Electrical",
    "Body Parts",
    "Accessories",
  ];

  final List<Map<String, dynamic>> dummyProducts = List.generate(10, (i) {
    return {
      "name": "Steel Bolt $i",
      "category": i % 2 == 0 ? "Electrical" : "Engine",
      "price": 120 + i,
      "image": "https://picsum.photos/200?random=$i",
    };
  });

  @override
  Widget build(BuildContext context) {
    final filtered = selectedCategory == "All"
        ? dummyProducts
        : dummyProducts
              .where((p) => p["category"] == selectedCategory)
              .toList();

    return Scaffold(
      backgroundColor: ColorConstants.surface,
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: ColorConstants.surface,
        elevation: 0,
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorConstants.owner,
        onPressed: () {},
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Add Product", style: TextStyle(color: Colors.white)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// SEARCH
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 16),

            /// CATEGORY CHIPS + ADD CATEGORY BUTTON
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: categories.map(_buildCategoryChip).toList(),
                    ),
                  ),
                  const SizedBox(width: 8),

                  GestureDetector(
                    onTap: () {
                      // TODO: show add category bottom sheet
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: ColorConstants.primary,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// PRODUCT GRID
            Expanded(
              child: filtered.isEmpty
                  ? const Center(
                      child: Text(
                        "No products found",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : GridView.builder(
                      itemCount: filtered.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 0.78,
                          ),
                      itemBuilder: (_, i) => _ProductCard(product: filtered[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(category),
        selected: isSelected,
        selectedColor: ColorConstants.primary,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
        ),
        onSelected: (_) => setState(() => selectedCategory = category),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: show product details bottom sheet
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.cardBg,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              offset: const Offset(2, 4),
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Column(
          children: [
            /// IMAGE
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: Image.network(
                  product["image"],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// TEXT DETAILS
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["name"],
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product["category"],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "₹${product["price"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
