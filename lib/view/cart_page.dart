import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/routes/routes_name.dart';
import 'package:e_commerce/utils/utils.dart';
import 'package:e_commerce/view/ReUsable/add_to_cart_sheet.dart';
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
              icon: const Icon(Icons.refresh),
              onPressed: () {
                cartProvider.fetchCart();
              }),
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
                    return _buildCartItem(context, item, cart);
                  },
                ),
              ),
              _buildCheckOutSection(context, cart),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartItem(
      BuildContext context, CartItem cartItem, CartProvider cartProvider) {
    final baseUrl = 'https://groceryct.pythonanywhere.com';
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        enabled: cartItem.product.isAvailable,
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () => _showAddToCartDialog(context, cartItem),
                icon: Icon(Icons.edit)),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () =>
                  cartProvider.removeFromCart(cartItem.id, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckOutSection(BuildContext context, CartProvider cart) {
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '₹ ${cart.totalPrice}',
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  cart.canCheckOut
                      ? Navigator.pushNamed(context, RouteName.checkout)
                      : Utils.flushBar('Remove Stock Out Product', context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      cart.canCheckOut ? Colors.green : Colors.grey[300],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showDeleteAllConformation(BuildContext context, CartProvider cartProvider) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text('Empty Cart'),
                content: Text('Are you sure to Empty Cart'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('cancel')),
                  Utils.button(
                    onPressed: () {},
                    text: 'Delete',
                    isLoading: false,
                  ),
                ]));
  }

  void _showAddToCartDialog(BuildContext context, CartItem cartItem) {
    final product = cartItem.product;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => AddToCartSheet(product: product, isCart: true),
    );
  }
}
