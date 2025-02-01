import 'package:e_commerce/routes/routes_name.dart';
import 'package:e_commerce/view/ReUsable/custom_expansion_tile.dart';
import 'package:e_commerce/view_model/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Categories'),
      ),
      body: Consumer<StoreProvider>(
        builder: (context, storeProvider, _) {
          if (storeProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: storeProvider.categories.length,
            itemBuilder: (context, index) {
              final category = storeProvider.categories[index];
              final subCategories = storeProvider.subCategories
                  .where((sub) => sub.category == category.id)
                  .toList();

              return CustomExpansionTile(
                onExpansionChanged: (expanded) {
                  if (subCategories.isEmpty) {
                    storeProvider.selectCategory(category.id);
                    storeProvider.selectSubCategory(null);
                    Navigator.pushNamed(context, RouteName.products,
                        arguments: {
                          'category': category,
                          'subCategories': subCategories,
                        });
                  }
                },
                leading: Image.network(
                  category.imageUrl,
                  width: 40,
                  height: 40,
                  errorBuilder: (_, __, ___) => const Icon(Icons.category),
                ),
                title: category.name,
                isExpandable: subCategories.isNotEmpty,
                children: subCategories
                    .map(
                      (subCategory) => ListTile(
                        leading: Image.network(
                          subCategory.subCategoryImage,
                          width: 40,
                          height: 40,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.subtitles),
                        ),
                        title: Text(subCategory.name),
                        subtitle: Text(subCategory.categoryName),
                        onTap: () {
                          // Update provider state
                          storeProvider.selectCategory(category.id);
                          storeProvider.selectSubCategory(subCategory.id);

                          // Navigate to ProductsPage
                          Navigator.pushNamed(context, RouteName.products,
                              arguments: {
                                'category': category,
                                'subCategories': subCategories,
                              });
                        },
                      ),
                    )
                    .toList(),
              );
            },
          );
        },
      ),
    );
  }
}
