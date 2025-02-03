import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/view_model/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // context.read<CartProvider>().clearCart();
              cartProvider.fetchCart();
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, _) {
          if (cart.cartItems.isEmpty) {
            return const Center(
              child: Text('Your cart is empty.'),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cart.cartItems[index];
                    return _buildCartItem(context, item);
                  },
                ),
              ),
              _buildTotalSection(context, cart),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem cartItem) {
    final baseUrl = 'https://groceryct.pythonanywhere.com';
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.network(
          baseUrl + cartItem.product.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(cartItem.product.name),
        subtitle: Text(
          cartItem.product.weightMeasurement.toLowerCase() != 'kg'
              ? '₹${cartItem.price} x ${cartItem.quantity}'
              : '${cartItem.selectedWeight} x ${cartItem.quantity}= ${cartItem.price}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            // context.read<CartProvider>().removeFromCart( cartItem.product.id);
          },
        ),
      ),
    );
  }

  Widget _buildTotalSection(BuildContext context, CartProvider cart) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total:',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            '₹ ${cart.totalPrice}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
