import 'package:e_commerce/routes/routes_name.dart';
import 'package:e_commerce/utils/app_style.dart';
import 'package:e_commerce/view_model/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildOrderAndCartSection(context),
            const SizedBox(height: 20),
            _buildPersonalInfoSection(context, profileProvider),
            const SizedBox(height: 20),
            _buildSavedAddressSection(context, profileProvider),
            const SizedBox(height: 20),
            _buildPasswordChangeSection(context),
            const SizedBox(height: 20),
            _buildLogoutButton(),
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

  Widget _buildPersonalInfoSection(
      BuildContext context, ProfileProvider profileProvider) {
    return Card(
      margin: EdgeInsets.zero, // Ensures no extra margin outside the card

      child: Theme(
        data: Theme.of(context)
            .copyWith(dividerColor: Colors.transparent), // Removes lines
        child: ExpansionTile(
          leading: Icon(Icons.person),
          initiallyExpanded: true,
          title: Text(
            'Personal Info',
            style: headline2,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                },
                children: [
                  _buildTableDetailsRow(
                      'Name', profileProvider.user?.name ?? 'Not found'),
                  _buildTableDetailsRow(
                      'Email', profileProvider.user?.email ?? 'Not found'),
                  _buildTableDetailsRow('Phone',
                      profileProvider.user?.mobileNumber ?? 'Not found'),
                  _buildTableDetailsRow(
                      'Gender', profileProvider.user?.gender ?? 'Not set'),
                  _buildTableDetailsRow(
                      'Date of Birth', profileProvider.user?.dob ?? 'Not set'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedAddressSection(
      BuildContext context, ProfileProvider profileProvider) {
    return Card(
      margin: EdgeInsets.zero, // Ensures no extra margin outside the card

      child: Theme(
        data: Theme.of(context)
            .copyWith(dividerColor: Colors.transparent), // Removes lines
        child: ExpansionTile(
          leading: Icon(Icons.place),
          title: Text(
            'Saved Address',
            style: headline2,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2), // Label column width
                  1: FlexColumnWidth(3), // Value column width
                },
                children: [
                  _buildTableDetailsRow('Address', 'adress'),
                  _buildTableDetailsRow('Road Name', 'road_name'),
                  _buildTableDetailsRow('City', 'city'),
                  _buildTableDetailsRow('State', 'state'),
                  _buildTableDetailsRow('Pincode', 'pincode'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordChangeSection(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero, // Ensures no extra margin outside the card

      child: Theme(
        data: Theme.of(context)
            .copyWith(dividerColor: Colors.transparent), // Removes lines
        child: ExpansionTile(
          leading: Icon(Icons.password),
          title: Text('Change Password', style: headline2),
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
                  ElevatedButton(
                    onPressed: () {/* Change password logic */},
                    child: const Text('Update Password'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

  TableRow _buildTableDetailsRow(String label, dynamic value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            '$label : ',
            style: headline3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            value ?? 'Not set',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.logout),
        label: const Text('Log Out'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {/* Logout logic */},
      ),
    );
  }
}
