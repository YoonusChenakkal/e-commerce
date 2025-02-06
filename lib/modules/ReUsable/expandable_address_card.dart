import 'package:e_commerce/common/models/user_model.dart';
import 'package:e_commerce/common/utils/utils.dart';
import 'package:e_commerce/modules/ReUsable/custom_expansion_tile.dart';
import 'package:e_commerce/modules/profile/view_model/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedAddressSection extends StatelessWidget {
  const SavedAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final user = profileProvider.user;

    return CustomExpansionTile(
      initiallyExpanded: true,
      leading: const Icon(Icons.location_on),
      title: 'Address',
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: (user == null || user.address == null || user.address!.isEmpty)
              ? const Text('No Address Found')
              : Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2), // Label column width
                    1: FlexColumnWidth(3), // Value column width
                  },
                  children: [
                    Utils.tableRow(label: 'Address', value: user.address),
                    Utils.tableRow(label: 'Road Name', value: user.roadName),
                    Utils.tableRow(label: 'City', value: user.city),
                    Utils.tableRow(label: 'State', value: user.state),
                    Utils.tableRow(label: 'Pincode', value: user.pincode),
                  ],
                ),
        ),
        Utils.button(
          isLoading: false,
          text: (user == null || user.address == null || user.address!.isEmpty)
              ? '+ Address'
              : 'Edit Address',
          onPressed: () {
            if (user != null) {
              _showEditAddressDialog(context, user, profileProvider);
            } else {
              Utils.flushBar('Error: User not found!', context);
            }
          },
        ),
      ],
    );
  }

  /// ✅ Edit Address Dialog (Null-Safe)
  void _showEditAddressDialog(
      BuildContext context, UserModel user, ProfileProvider profileProvider) {
    final tcAddress = TextEditingController(text: user.address ?? '');
    final tcCity = TextEditingController(text: user.city ?? '');
    final tcState = TextEditingController(text: user.state ?? '');
    final tcPincode = TextEditingController(text: user.pincode ?? '');
    final tcRoadName = TextEditingController(text: user.roadName ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Address'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: tcAddress,
                decoration: const InputDecoration(labelText: 'Street Address'),
              ),
              TextFormField(
                controller: tcRoadName,
                decoration: const InputDecoration(labelText: 'Road Name'),
              ),
              TextFormField(
                controller: tcCity,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextFormField(
                controller: tcState,
                decoration: const InputDecoration(labelText: 'State'),
              ),
              TextFormField(
                controller: tcPincode,
                keyboardType: TextInputType.number,
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
              // Ensure all fields are filled
              if (tcAddress.text.isEmpty ||
                  tcCity.text.isEmpty ||
                  tcState.text.isEmpty ||
                  tcPincode.text.isEmpty ||
                  tcRoadName.text.isEmpty) {
                Utils.flushBar('Fill All Fields', context);
                return;
              }

              // // Validate and parse pincode safely
              // int? pincode = int.tryParse(tcPincode.text);
              // if (pincode == null) {
              //   Utils.flushBar('Invalid Pincode', context);
              //   return;
              // }

              final data = {
                "address": tcAddress.text,
                "state": tcState.text,
                "pincode": tcPincode.text,
                "city": tcCity.text,
                "road_name": tcRoadName.text
              };

              await profileProvider.changeAddress(context, data);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
