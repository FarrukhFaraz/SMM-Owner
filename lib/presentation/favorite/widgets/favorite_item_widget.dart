import 'package:flutter/material.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/presentation/service/model/service_model.dart';

class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({
    super.key,
    required this.item,
    this.onFavoriteTap,
    this.onTap,
    this.showFavorite = true,
  });

  final ServiceModel? item;
  final Function()? onFavoriteTap;
  final Function()? onTap;
  final bool showFavorite;


  @override
  Widget build(BuildContext context) {
    bool isFavorite = item?.isFavorite ?? false;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme
            .of(context)
            .scaffoldBackgroundColor,
        border: Border.all(width: 1, color: Colors.grey),
      ),
      padding: EdgeInsets.all(11),
      margin: EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Category:', style: context.text14Medium),
                      SizedBox(width: 6),
                      Text(item?.category?.name ?? '', style: context.text14Regular),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Text('Services:', style: context.text14Medium),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item?.name ?? '',
                          style: context.text14Regular,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text('\$ ${item?.rate ?? ''}', style: context.text15Medium),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 6),
            if(showFavorite)
              GestureDetector(
                onTap: onFavoriteTap,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      isFavorite ?
                      Icons.bookmark
                          : Icons.bookmark_border_rounded,
                      size: 45,
                      color: isFavorite ? Color(0xfff28a00) : Colors.grey,

                    ),
                    Icon(
                      isFavorite ?
                      Icons.favorite_outline_rounded : Icons.favorite,
                      color: isFavorite ? Colors.white : Colors.grey,
                      size: 16,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
