import 'package:flutter/material.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';

class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({super.key, required this.item});

  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: 1, color: Color(0xffbed2d0)),
      ),
      padding: EdgeInsets.all(11),
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Category:', style: context.text12Medium),
                    SizedBox(width: 6),
                    Text('Instagram Followers', style: context.text12Regular),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Text('Services:', style: context.text12Medium),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '(ID# 323232)  Instagram Followers Refill 30 days - Guaranteed',
                        style: context.text12Regular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text('\$ 123', style: context.text12Medium),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 6),
          GestureDetector(
            onTap: () {},
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.bookmark, size: 36, color: Color(0xfff28a00)),
                Icon(Icons.favorite_outline_rounded, color: Colors.white, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
