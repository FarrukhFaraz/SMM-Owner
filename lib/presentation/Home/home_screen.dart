import 'package:flutter/material.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/custom_textfield.dart';
import 'package:sms_owner/core/components/wallet_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  final List<IconData> socialIcons = [
    Icons.facebook,
    Icons.video_library,
    Icons.clear,
    Icons.more_horiz,
    Icons.video_call,
    Icons.extension,
    Icons.camera_alt,
    Icons.more_vert,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  color: const Color(0xFF2D6B5F),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 12,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.menu, color: Colors.white),
                          SizedBox(width: 60),
                          CircleAvatar(backgroundColor: Colors.grey),
                          const SizedBox(width: 10),
                          const Text(
                            "Logo here",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          _buildNotificationIcon(Icons.verified, 13),
                          const SizedBox(width: 10),
                          _buildNotificationIcon(Icons.notifications, 13),
                        ],
                      ),
                    ),
                    //
                    Divider(color: Colors.white),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          WalletInfo(title: 'My Wallet', value: '\$ 350'),
                          WalletInfo(title: 'My Coins', value: '1,234,567'),
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
                        children: List.generate(socialIcons.length, (index) {
                          return CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(
                              socialIcons[index],
                              size: 30,
                              color: Colors.black,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            _searchField(),

            _dropdownSection(),

            _textField(label: "Link"),

            _quantitySection(),

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
  }

  Widget _buildNotificationIcon(IconData icon, int count) {
    return Stack(
      children: [
        Icon(icon, color: Colors.white),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: Text(
              "$count",
              style: const TextStyle(fontSize: 10, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CustomTextField(
        controller: searchController,
        hintText: 'Search Services ....',
        hintStyle: context.text12Medium?.copyWith(color: Colors.grey),
        keyboardType: TextInputType.visiblePassword,
        fillColor: Colors.transparent,
        suffix: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Color(0xFF2D6B5F),
            borderRadius: BorderRadius.circular(90),
          ),
          child: Icon(Icons.search),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _dropdownSection() {
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
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField(
            autofocus: true,
            focusColor: Colors.transparent,
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
                        child: Text(
                          e,
                          style: context.text10Bold?.copyWith(fontSize: 11),
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (_) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Services",
              style: context.text12Medium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField(
            focusColor: Colors.transparent,

            autofocus: true,
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
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "ID: 1323113",
                                style: context.text10Bold?.copyWith(
                                  fontSize: 08,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              e,
                              style: context.text10Bold?.copyWith(fontSize: 9),
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
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField({required String label}) {
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
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            controller: searchController,
            hintText: 'link ....',
            hintStyle: context.text12Medium?.copyWith(color: Colors.grey),
            keyboardType: TextInputType.visiblePassword,
            fillColor: Colors.transparent,
            suffix: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Paste",
                style: context.text12Bold?.copyWith(color: Colors.white),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantitySection() {
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
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            controller: searchController,
            hintText: '100',
            hintStyle: context.text12Medium?.copyWith(color: Colors.grey),
            keyboardType: TextInputType.visiblePassword,
            fillColor: Colors.transparent,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Min: 100", style: TextStyle(fontStyle: FontStyle.italic)),
              Text(
                "Max: 1000000",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
