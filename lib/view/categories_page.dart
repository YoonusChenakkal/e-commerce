import 'package:e_commerce/view_model/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    super.initState();
    // Fetch data when the page initializes
    final storeProvider = Provider.of<StoreProvider>(context, listen: false);
    storeProvider.fetchCategories(context);
    storeProvider.fetchSubCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  leading: Image.network(
                    category.imageUrl,
                    width: 40,
                    height: 40,
                    errorBuilder: (_, __, ___) => const Icon(Icons.category),
                  ),
                  title: Text(category.name),
                  children: [
                    if (subCategories.isEmpty)
                      const ListTile(
                        title: Text('No subcategories available'),
                      )
                    else
                      ...subCategories.map((subCategory) => ListTile(
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
                              // Handle subcategory tap
                            },
                          )),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
