import 'package:e_commerce/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  final Widget leading;
  final dynamic onExpansionChanged;
  final String title;
  final List<Widget> children;
  final bool isExpandable;
  final bool initiallyExpanded;

  const CustomExpansionTile({
    super.key,
    required this.leading,
    required this.title,
    required this.children,
    this.onExpansionChanged,
    this.isExpandable = true,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          leading: leading,
          title: Text(
            title,
            style: headline3,
          ),
          trailing: isExpandable ? null : const SizedBox.shrink(),
          onExpansionChanged:onExpansionChanged,
          children: children,
        ),
      ),
    );
  }
}
