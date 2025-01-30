import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/routes/routes_name.dart';
import 'package:e_commerce/view/widgets/product_card.dart';
import 'package:e_commerce/view/widgets/category_chip.dart';
import 'package:e_commerce/view/product_details_page.dart';
import 'package:e_commerce/view_model/cart_provider.dart';
import 'package:e_commerce/view_model/store_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fresh Grocery'),
        actions: [
          IconButton(
            icon: Badge(
              isLabelVisible: cartProvider.items.isNotEmpty,
              label: Text('${cartProvider.items.length}'),
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () => Navigator.pushNamed(context, RouteName.cart),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await storeProvider.fetchProducts(context);
          await storeProvider.fetchCategories(context);
        },
        child: CustomScrollView(
          slivers: [
            _buildPromoBanner(storeProvider),
            _buildCategorySection(),
            _buildProductSection(),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPromoBanner(StoreProvider storeProvider) {
    return SliverToBoxAdapter(
      child: CarouselSlider.builder(
        itemCount: storeProvider.carousel.length,
        itemBuilder: (context, index, realIndex) {
          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(storeProvider.carousel[index].imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: 160, // Adjust height as needed
          autoPlay: true, // Enables auto-scrolling
          autoPlayInterval: Duration(seconds: 3), // Set autoplay speed
          enlargeCenterPage: true, // Makes the current item bigger
          viewportFraction:
              0.9, // Adjusts how much of the next image is visible
          onPageChanged: (index, reason) {},
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildCategorySection() {
    return SliverToBoxAdapter(
      child: Consumer<StoreProvider>(
        builder: (context, provider, _) => SizedBox(
          height: 65,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              CategoryChip(
                category: Category(
                  id: -1,
                  name: "All",
                  imageUrl: "",
                  enableCategory: true,
                ),
                isSelected: provider.selectedCategoryId == null,
                onTap: () => provider.selectCategory(null),
              ),
              ...provider.categories.map(
                (category) => CategoryChip(
                  category: category,
                  isSelected: category.id == provider.selectedCategoryId,
                  onTap: () => provider.selectCategory(category.id),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _buildProductSection() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: Consumer<StoreProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()));
          }

          return provider.filteredProducts.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Text(
                      "No products found",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                )
              : SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ProductCard(
                      product: provider.filteredProducts[index],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailPage(
                            product: provider.filteredProducts[index],
                          ),
                        ),
                      ),
                    ),
                    childCount: provider.filteredProducts.length,
                  ),
                );
        },
      ),
    );
  }
}
