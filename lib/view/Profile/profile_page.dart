import 'package:e_commerce/routes/routes_name.dart';
import 'package:e_commerce/services/local_storage.dart';
import 'package:e_commerce/utils/app_style.dart';
import 'package:e_commerce/utils/utils.dart';
import 'package:e_commerce/view/Profile/widgets/personal_info_setcion.dart';
import 'package:e_commerce/view/Profile/widgets/saved_address_section.dart';
import 'package:e_commerce/view/ReUsable/custom_expansion_tile.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildOrderAndCartSection(context),
            PersonalInfoSetcion(),
            SavedAddressSection(),
            _buildPasswordChangeSection(context),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderAndCartSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButtonCard(
            text: 'Orders',
            icon: Icons.shopping_bag_outlined,
            onpressed: () => {}),
        _buildButtonCard(
            text: 'Cart',
            icon: Icons.shopping_cart_outlined,
            onpressed: () => Navigator.pushNamed(context, RouteName.login))
      ],
    );
  }

  Widget _buildPasswordChangeSection(BuildContext context) {
    return CustomExpansionTile(
      leading: const Icon(Icons.password),
      title: 'Change Password',
      isExpandable: true, // Always expandable
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  prefixIcon: Icon(Icons.lock_reset),
                ),
              ),
              const SizedBox(height: 20),
              Utils.button(
                isLoading: false,
                text: 'Change Password',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonCard(
      {required String text,
      required IconData icon,
      required VoidCallback onpressed}) {
    return SizedBox(
        width: 170,
        height: 60,
        child: GestureDetector(
          onTap: onpressed,
          child: Card(
            shape: StadiumBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: const Color.fromARGB(255, 40, 32, 0),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    text,
                    style: headline2,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Utils.button(
        isLoading: false,
        color: Colors.red,
        text: 'Log Out',
        onPressed: () async {
          await LocalStorage.clearUser();
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.login, (route) => false);
        },
      ),
    );
  }
}
