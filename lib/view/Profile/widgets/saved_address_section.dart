import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/utils/utils.dart';
import 'package:e_commerce/view/ReUsable/custom_expansion_tile.dart';
import 'package:e_commerce/view_model/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedAddressSection extends StatelessWidget {
  const SavedAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileProvider>(context).user;

    return CustomExpansionTile(
        initiallyExpanded: true,
        leading: Icon(Icons.location_on),
        title: 'Saved Address',
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2), // Label column width
                1: FlexColumnWidth(3), // Value column width
              },
              children: user != null &&
                      (user.address == null || user.address!.isEmpty)
                  ? [Utils.tableRow(label: 'Address', value: 'Not found')]
                  : [
                      Utils.tableRow(label: 'Address', value: user?.address),
                      Utils.tableRow(label: 'Road Name', value: user?.roadName),
                      Utils.tableRow(label: 'City', value: user?.city),
                      Utils.tableRow(label: 'State', value: user?.state),
                      Utils.tableRow(label: 'Pincode', value: user?.pincode),
                    ],
            ),
          ),
          Utils.button(
            isLoading: false,
            text:
                user != null && (user.address == null || user.address!.isEmpty)
                    ? '+ Address'
                    : 'Edit Address',
            onPressed: () => _showEditAddressDialog(context, user!),
          ),
        ]);
  }

  // Edit Address Dialog

  void _showEditAddressDialog(BuildContext context, UserModel user) {
    final addressController = TextEditingController(text: user.address);
    final cityController = TextEditingController(text: user.city);
    final stateController = TextEditingController(text: user.state);
    final pincodeController = TextEditingController(text: user.pincode);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Address'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Street Address'),
              ),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextFormField(
                controller: stateController,
                decoration: const InputDecoration(labelText: 'State'),
              ),
              TextFormField(
                controller: pincodeController,
                decoration: const InputDecoration(labelText: 'Pincode'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final updatedAddress = '';
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
