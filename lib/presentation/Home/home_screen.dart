import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/env/config_model/home_config.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/custom_appBar.dart';
import 'package:sms_owner/core/components/custom_textfield.dart';
import 'package:sms_owner/core/components/wallet_info.dart';

import '../../core/components/url_lancher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController qunatityController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  final List<SocialIcons> socialIcons = [
    SocialIcons(
      icon: 'assets/png/facebook1.png',
      url: "https://www.facebook.com/?_rdr",
    ),
    SocialIcons(
      icon: 'assets/png/video_library.png',
      url: "https://www.youtube.com/watch?v=_y4nzLXB2Lc",
    ),
    SocialIcons(
      icon: 'assets/png/clear.png',
      url: "https://www.youtube.com/watch?v=_y4nzLXB2Lc",
    ),
    SocialIcons(
      icon: 'assets/png/more.png',
      url: "https://www.youtube.com/watch?v=_y4nzLXB2Lc",
    ),
    SocialIcons(
      icon: 'assets/png/video_call.png',
      url: "https://www.youtube.com/watch?v=_y4nzLXB2Lc",
    ),
    SocialIcons(
      icon: 'assets/png/extension.png',
      url: "https://www.youtube.com/watch?v=_y4nzLXB2Lc",
    ),
    SocialIcons(
      icon: 'assets/png/camera.png',
      url: "https://www.youtube.com/watch?v=_y4nzLXB2Lc",
    ),
    SocialIcons(
      icon: 'assets/png/more_vert.png',
      url: "https://www.youtube.com/watch?v=_y4nzLXB2Lc",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, homeConfiguration) {
        final homeConfig = homeConfiguration.homeConfig;
        return Scaffold(
          backgroundColor: homeConfig.backGroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: homeConfig.backContainerColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        color: homeConfig.frontContainerColor,
                      ),
                      child: Column(
                        children: [
                          customAppBar(homeConfig),
                          //
                          Divider(color: Colors.white),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: homeConfig.walletContainerColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WalletInfo(
                                  title: 'My Wallet',
                                  value: '\$ 350',
                                  homeConfig: homeConfig,
                                ),
                                WalletInfo(
                                  title: 'My Coins',
                                  value: '1,234,567',
                                  homeConfig: homeConfig,
                                ),
                              ],
                            ),
                          ),

                          // Social Icons Grid
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Wrap(
                              spacing: 15,
                              runSpacing: 15,
                              alignment: WrapAlignment.center,
                              children: List.generate(socialIcons.length, (
                                index,
                              ) {
                                return GestureDetector(
                                  onTap: () async {
                                    await launchMyUrl(
                                      "https://www.youtube.com/watch?v=_y4nzLXB2Lc",
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    child: Image.asset(
                                      socialIcons[index].icon,

                                      color: Colors.purple,
                                      fit: BoxFit.fitHeight,

                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                _searchField(homeConfig),

                _dropdownSection(homeConfig),

                _linkField(homeConfig, label: "Link"),

                _quantitySection(homeConfig),

                const SizedBox(height: 20),
                const Text(
                  "Total: \$10000",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Order Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _searchField(HomeConfig homeConfig) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CustomTextField(
        controller: searchController,
        hintText: 'Search Services ....',
        hintStyle: context.text12Medium?.copyWith(color: Colors.grey),
        keyboardType: TextInputType.visiblePassword,
        fillColor: homeConfig.textFieldColor,
        inputTextStyle: context.text15Medium?.copyWith(
          color: homeConfig.dropDownTextColor,
        ),
        suffix: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: homeConfig.searchButtonBackgroundColor,
            borderRadius: BorderRadius.circular(90),
          ),
          child: Icon(Icons.search, color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            width: 1,
            color: homeConfig.textFieldBorderColor,
          ),
        ),
      ),
    );
  }

  Widget _dropdownSection(HomeConfig homeConfig) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Category",
              style: context.text12Medium?.copyWith(
                color: homeConfig.categoryTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField(
            dropdownColor: homeConfig.dropDownColor,
            iconEnabledColor: Colors.black,
            value: "Instagram Followers Service - Refill 30 Days Guarantee",
            items:
                [
                      "Instagram Followers Service - Refill 30 Days Guarantee",
                      "sfhjksdjfhsdjkhfsdkjhfsdjf",
                      "jakdhfsjkdhfbnvmxncsdjn",
                      'skdfjksdhfjksdhfndzvm,cnzx',
                    ]
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: SizedBox(
                          width: 280,
                          child: Text(
                            e,
                            style: context.text10Bold?.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14,
                              color: homeConfig.dropDownTextColor,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (_) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: homeConfig.dropdownBorderColor),
              ),
              fillColor: homeConfig.dropDownFieldColor,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Services",
              style: context.text12Medium?.copyWith(
                color: homeConfig.categoryTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField(
            dropdownColor: homeConfig.dropDownColor,
            iconEnabledColor: Colors.black,
            value: "Instagram Followers Service - Refill 30 Days Guarantee",
            items:
                [
                      "Instagram Followers Service - Refill 30 Days Guarantee",
                      "sfhjksdjfhsdjkhfsdkjhfsdjf",
                      "jakdhfsjkdhfbnvmxncsdjn",
                      'skdfjksdhfjksdhfndzvm,cnzx',
                    ]
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: homeConfig.serviceIdTagColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "ID: 1323113",
                                style: context.text10Bold?.copyWith(
                                  fontSize: 08,
                                ),
                              ),
                            ),
                            const SizedBox(width: 2),
                            SizedBox(
                              width: 230,
                              child: Text(
                                e,
                                style: context.text10Bold?.copyWith(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  color: homeConfig.dropDownTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (_) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: homeConfig.dropdownBorderColor),
              ),
              fillColor: homeConfig.dropDownFieldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _linkField(HomeConfig homeConfig, {required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              label,
              style: context.text12Medium?.copyWith(
                color: homeConfig.categoryTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            controller: linkController,
            hintText: 'link ....',
            inputTextStyle: context.text15Medium?.copyWith(
              color: homeConfig.dropDownTextColor,
            ),
            hintStyle: context.text12Medium?.copyWith(color: Colors.grey),
            keyboardType: TextInputType.visiblePassword,
            fillColor: homeConfig.textFieldColor,
            suffix: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: homeConfig.pasteButtonBackgroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Paste",
                style: context.text12Bold?.copyWith(
                  color: homeConfig.pasteButtonTextColor,
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                width: 1,
                color: homeConfig.textFieldBorderColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantitySection(HomeConfig homeConfig) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Quantity",
              style: context.text12Medium?.copyWith(
                color: homeConfig.categoryTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            controller: qunatityController,
            hintText: '100',
            hintStyle: context.text12Medium?.copyWith(
              color: homeConfig.hintTextColor,
            ),
            keyboardType: TextInputType.visiblePassword,
            fillColor: homeConfig.textFieldColor,
            inputTextStyle: context.text15Medium?.copyWith(
              color: homeConfig.dropDownTextColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                width: 1,
                color: homeConfig.textFieldBorderColor,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Min: 100", style: TextStyle(fontStyle: FontStyle.italic)),
                Text(
                  "Max: 1000000",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SocialIcons {
  String icon;
  String url;
  SocialIcons({required this.icon, required this.url});
}
