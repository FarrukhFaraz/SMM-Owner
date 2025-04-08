import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/webview_screen.dart';
import 'package:sms_owner/core/cubit/general_cubit.dart';
import 'package:sms_owner/core/utils/app_color.dart';

class PopUpMenuIconWidget extends StatelessWidget {
  const PopUpMenuIconWidget({super.key, required this.menuKey});

  final GlobalKey<PopupMenuButtonState<int>> menuKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _PopUpMenuItem(menuKey: menuKey),
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            menuKey.currentState!.showButtonMenu();
          },
          child: Container(
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25))),
            padding: const EdgeInsets.all(7),
            margin: const EdgeInsets.only(left: 12, right: 15, top: 10),
            child: Image.asset("assets/icons/settings_menu.png"),
          ),
        ),
      ],
    );
  }
}

class _PopUpMenuItem extends StatelessWidget {
  const _PopUpMenuItem({required this.menuKey});

  final GlobalKey<PopupMenuButtonState<int>> menuKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: PopupMenuButton<int>(
            padding: const EdgeInsets.all(0),
            key: key,
            surfaceTintColor: AppColor.kWhite,
            menuPadding: EdgeInsets.zero,
            useRootNavigator: true,
            color: AppColor.kWhite,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
            onSelected: (newValue) {},
            icon: Container(),
            itemBuilder:
                (context) => [
                  const PopupMenuItem(height: 10.0, enabled: false, child: SizedBox(height: 10)),
                  PopupMenuItem(
                    height: 40,
                    value: 4,
                    onTap: () {},
                    child: SizedBox(
                      height: 20.0,
                      child: menuItem(context: context, iconPath: "assets/icons/profile_status_new.png", label: "Profile Status"),
                    ),
                  ),
                  PopupMenuItem(
                    height: 0,
                    value: 4,
                    onTap: () {
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).push(CupertinoPageRoute(builder: (context) => WebViewPage(url: 'https://pub.dev/', appName: "About Us")));
                    },
                    child: menuItem(context: context, iconPath: "assets/icons/about.png", label: "About Us"),
                  ),
                  PopupMenuItem(
                    height: 0,
                    value: 4,
                    onTap: () {
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).push(CupertinoPageRoute(builder: (context) => WebViewPage(url: 'https://pub.dev/', appName: "Privacy Policy")));
                    },
                    child: menuItem(context: context, iconPath: "assets/icons/about.png", label: "Privacy Policy"),
                  ),
                  const PopupMenuItem(height: 30.0, enabled: false, child: SizedBox(height: 30)),
                  const PopupMenuItem(height: 0, padding: EdgeInsets.zero, child: Divider(color: AppColor.kcLightGreyColor, height: 0)),
                  PopupMenuItem(
                    height: 50,
                    value: 8,
                    enabled: false,
                    child: Center(
                      child: Text(
                        "Version ${context.read<GeneralCubit>().packageInfo?.version}(${context.read<GeneralCubit>().packageInfo?.buildNumber})",
                        style: context.defaultTextStyle?.copyWith(fontWeight: FontWeight.w500, color: const Color(0xff252525).withOpacity(0.4)),
                      ),
                    ),
                  ),
                ],
          ),
        ),
      ],
    );
  }

  Widget menuItem({required String iconPath, required String label, required BuildContext context, bool isSvg = false}) {
    return SizedBox(
      width: 169,
      child: Row(
        children: <Widget>[
          Container(width: 30, alignment: Alignment.center, child: isSvg ? SvgPicture.asset(iconPath) : Image.asset(iconPath, height: 30)),
          const SizedBox(width: 10),
          Text(label, style: context.text16Medium),
        ],
      ),
    );
  }
}
