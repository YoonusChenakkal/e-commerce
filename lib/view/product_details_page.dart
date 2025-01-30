import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/view/widgets/add_to_cart%20_sheet.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      itemCount: product.imageUrl[0].length,
                      itemBuilder: (_, index) => Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₹${product.offerPrice}',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (product.offerPrice < product.price)
                          Text(
                            '₹${product.price}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const SizedBox(height: 16),
                        Text(
                          'description',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildAddToCartBar(context),
        ],
      ),
    );
  }

  Widget _buildAddToCartBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.shopping_cart),
              label: const Text('ADD TO CART'),
              onPressed: () => _showAddToCartDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddToCartDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => AddToCartSheet(product: product),
    );
  }
}
