import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/utils/utils.dart';
import 'package:e_commerce/view/ReUsable/custom_expansion_tile.dart';
import 'package:e_commerce/view_model/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PersonalInfoSetcion extends StatelessWidget {
  const PersonalInfoSetcion({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileProvider>(context).user;
    return CustomExpansionTile(
        leading: const Icon(Icons.person),
        title: 'Personal Info',
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                Utils.tableRow(label: 'Name', value: user?.name ?? 'Not found'),
                Utils.tableRow(
                    label: 'Email', value: user?.email ?? 'Not found'),
                Utils.tableRow(
                    label: 'Phone', value: user?.mobileNumber ?? 'Not found'),
                Utils.tableRow(
                    label: 'Gender', value: user?.gender ?? 'Not set'),
                Utils.tableRow(
                    label: 'Date of Birth', value: user?.dob ?? 'Not set'),
              ],
            ),
          ),
          Utils.button(
            isLoading: false,
            text: 'Edit Info',
            onPressed: () {
              print(user?.name);
              if (user != null) _showEditPersonalInfoDialog(context, user);
            },
          )
        ]);
  }

  // Edit Personal Info Dialog
  void _showEditPersonalInfoDialog(BuildContext context, UserModel user) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final phoneController = TextEditingController(text: user.mobileNumber);
    final dobController = TextEditingController(text: user.dob);
    String? selectedGender = user.gender; // Store current gender

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Personal Info'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              TextFormField(
                controller: dobController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                onTap: () async {
                  // Optional: Add date picker
                  final date = await showDatePicker(
                    initialDatePickerMode: DatePickerMode.year,
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme:
                              ColorScheme.fromSeed(seedColor: primaryColor),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (date != null) {
                    dobController.text = DateFormat('dd-MM-yyyy').format(date);
                  }
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: const [
                  DropdownMenuItem(
                    value: 'Male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem(
                    value: 'Female',
                    child: Text('Female'),
                  ),
                ],
                onChanged: (value) => selectedGender = value,
                validator: (value) => value == null ? 'Select gender' : null,
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
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
