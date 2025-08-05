import 'package:flutter/material.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, this.onTap, required this.name, required this.value});

  final String name;
  final String value;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: 1, color: Colors.grey),
      ),
      padding: EdgeInsets.all(11),
      margin: EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(width: 6),
            Expanded(child: Text(name, style: context.text14Regular, maxLines: 2, overflow: TextOverflow.ellipsis)),
            SizedBox(width: 6),
            Text(value, style: context.text15Medium),
          ],
        ),
      ),
    );
  }
}
