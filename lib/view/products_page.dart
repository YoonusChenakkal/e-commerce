import 'package:e_commerce/routes/routes_name.dart';
import 'package:e_commerce/view/ReUsable/product_card.dart';
import 'package:e_commerce/view/ReUsable/sub_catrgory_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/view_model/store_provider.dart';

class ProductsPage extends StatelessWidget {
  final Category category;
  final List<SubCategory> subCategories;

  const ProductsPage({
    super.key,
    required this.category,
    required this.subCategories,
  });

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Column(
        children: [
          // Sub-category Chips
          if (subCategories.isNotEmpty)
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: subCategories.length,
                itemBuilder: (context, index) {
                  final subCategory = subCategories[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SubCatrgoryChip(
                      subCategory: subCategory,
                      isSelected:
                          storeProvider.selectedSubCategoryId == subCategory.id,
                      onTap: () {
                        storeProvider.selectSubCategory(subCategory.id);
                      },
                    ),
                  );
                },
              ),
            ),

          // Products Grid
          Expanded(
            child: storeProvider.subCatogoryfilteredProducts.isEmpty
                ? Center(child: Text('No Products Found'))
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: storeProvider.subCatogoryfilteredProducts.length,
                    itemBuilder: (context, index) {
                      final product =
                          storeProvider.subCatogoryfilteredProducts[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteName.productDetails,
                            arguments: product,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
