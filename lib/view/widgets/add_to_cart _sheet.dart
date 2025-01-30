import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/utils/utils.dart';
import 'package:e_commerce/view_model/cart_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddToCartSheet extends StatefulWidget {
  final Product product;

  const AddToCartSheet({super.key, required this.product});

  @override
  State<AddToCartSheet> createState() => _AddToCartSheetState();
}

class _AddToCartSheetState extends State<AddToCartSheet> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add to Cart',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: _decrementQuantity,
              ),
              Text(
                '$_quantity',
                style: const TextStyle(fontSize: 18),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _incrementQuantity,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<CartProvider>().addToCart(widget.product, _quantity);
              Navigator.pop(context); // Close the bottom sheet
              Utils.flushBar('${widget.product.name} added to cart', context,
                  color: Colors.green);
            },
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
