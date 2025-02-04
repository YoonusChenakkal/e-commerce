import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/utils/utils.dart';
import 'package:e_commerce/view_model/cart_provider.dart';
import 'package:e_commerce/view_model/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final user = Provider.of<ProfileProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 🏡 Address Section
          _buildAddressSection(user!),

          // 🛒 Order Summary
          _buildOrderSummary(cartProvider),

          // 💳 Payment Buttons (COD & Online Payment)
          _buildPaymentButtons(
            onCODSelected: () {
              // Handle Cash on Delivery
            },
            onOnlinePaymentSelected: () {
              // Handle Online Payment
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection(UserModel user) {
    String displayAddress = user.address ?? 'No address Added.';

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Delivery Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              displayAddress,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
          Utils.button(onPressed: (){}, text: 'Add Address', isLoading:false )
          ],
        ),
      ),
    );
  }

  // 🛒 Order Summary Section
  Widget _buildOrderSummary(CartProvider cartProvider) {
    final baseUrl = 'https://groceryct.pythonanywhere.com';

    double deliveryCharge = cartProvider.totalPrice >= 500 ? 0 : 30;
    double totalSavings = cartProvider.calculateTotalSavings();
    double finalPayable =
        cartProvider.totalPrice + deliveryCharge - totalSavings;

    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Order Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // 🛍 List of Products
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartProvider.cartItems[index];

                    // Only parse selectedWeight to double if weightMeasurement is kg or g
                    String selectedWeight;
                    if (item.product.weightMeasurement == "kg" ||
                        item.product.weightMeasurement == "g") {
                      selectedWeight =
                          double.parse(item.selectedWeight).toStringAsFixed(1);
                    } else {
                      selectedWeight = item
                          .selectedWeight; // No parsing needed if it's not kg or g
                    }

                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          baseUrl + item.product.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        item.product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        item.quantity > 1
                            ? "${item.quantity}x $selectedWeight ${item.product.weightMeasurement}"
                            : "$selectedWeight ${item.product.weightMeasurement}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: Text(
                        "₹${item.price * item.quantity}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),

              const Divider(),

              // 💰 Price Breakdown
              _buildPriceRow("Subtotal", "₹${cartProvider.totalPrice}"),
              _buildPriceRow(
                "Total Savings",
                "- ₹${totalSavings.toStringAsFixed(1)}",
                color: Colors.green,
              ),
              _buildPriceRow(
                "Delivery Charge",
                deliveryCharge == 0 ? "₹30 Free" : "₹$deliveryCharge",
                isDeliveryCharge:
                    deliveryCharge == 0, // Pass `true` to show strikethrough
              ),

              const Divider(),

              // 🔥 Total Payable Amount
              _buildPriceRow(
                "Total Payable",
                "₹${finalPayable.toStringAsFixed(1)}",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔢 Price Row Widget (With Strikethrough for ₹30)
  Widget _buildPriceRow(
    String label,
    String value, {
    Color color = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w500,
    bool isDeliveryCharge = false, // Special handling for Delivery Charge
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
          ),
          isDeliveryCharge
              ? RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "₹30 ",
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                          color: Colors.grey,
                          decoration:
                              TextDecoration.lineThrough, // Strikethrough
                        ),
                      ),
                      TextSpan(
                        text: " Free Delivery",
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color:
                              Colors.green, // Green color for "Free Delivery"
                        ),
                      ),
                    ],
                  ),
                )
              : Text(
                  value,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: color,
                  ),
                ),
        ],
      ),
    );
  }

  // 💳 Payment Buttons Section
  Widget _buildPaymentButtons({
    required VoidCallback onCODSelected,
    required VoidCallback onOnlinePaymentSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onCODSelected,
              icon: const Icon(Icons.currency_rupee, color: Colors.white),
              label: const Text("Cash on Delivery"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onOnlinePaymentSelected,
              icon: const Icon(Icons.payment, color: Colors.white),
              label: const Text("Pay Online"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
