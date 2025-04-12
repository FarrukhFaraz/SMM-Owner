import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/utils/app_color.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    this.profileUrl,
    this.name,
    this.height = 35,
    this.width = 35,
    this.border,
    this.placeHolderImage,
    this.boxFit,
    this.backgroundColor,
    this.placeholderPadding = const EdgeInsets.all(0),
  });

  final String? name;
  final String? profileUrl;
  final double? height;
  final double? width;
  final Border? border;
  final String? placeHolderImage;
  final EdgeInsets placeholderPadding;
  final BoxFit? boxFit;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          profileUrl != null && Uri.parse(profileUrl!).isAbsolute && profileUrl?.contains('m3u8') == false
              ? Container(
                width: width,
                height: height,
                decoration: BoxDecoration(shape: BoxShape.circle, border: border),
                child: CachedNetworkImage(
                  imageUrl: profileUrl!,
                  cacheKey: profileUrl,
                  imageBuilder:
                      (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: boxFit ?? BoxFit.cover,
                            scale: 1,
                            // opacity: 0.8,
                          ),
                        ),
                      ),
                  fit: BoxFit.cover,
                  fadeInDuration: Duration.zero,
                  placeholder: (context, url) => _noImageWidget(context, isPlaceholderOnly: true),
                  errorWidget: (context, url, error) => _noImageWidget(context),
                ),
              )
              : _noImageWidget(context, isPlaceholderOnly: true),
    );
  }

  Widget _noImageWidget(BuildContext context, {bool isPlaceholderOnly = false}) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor ?? AppColor.kcLightGreyColor),
      child:
          placeHolderImage != null
              ? Padding(padding: placeholderPadding, child: Image.asset(placeHolderImage!, fit: BoxFit.fitHeight))
              : Text(
                _profilePlaceHolderText(),
                style: context.defaultTextStyle?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: height != 20 ? 14 * height! / 40 : 10,
                ),
              ),
    );
  }

  String _profilePlaceHolderText() {
    List<String> namesList = name?.split(' ') ?? [];
    String? firstName = namesList.isNotEmpty ? namesList[0] : null;
    String? lastName = namesList.length > 1 ? namesList[1] : null;
    if (firstName != null) {
      if (lastName != null) {
        return firstName[0].toUpperCase() + lastName[0].toUpperCase();
      } else {
        List<String> names = firstName.split(' ');
        if (names.length > 1) {
          return names[0][0].toUpperCase() + names[1][0].toUpperCase();
        } else if (firstName.isNotEmpty) {
          return firstName[0].toUpperCase() + firstName[1].toUpperCase();
        } else {
          return '';
        }
      }
    } else {
      return 'P';
    }
  }
}
