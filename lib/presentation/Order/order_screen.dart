import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_owner/config/env/config_model/order_config.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/custom_appBar.dart';
import 'package:sms_owner/core/components/custom_textfield.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController searchFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, orderConfigration) {
        final orderConfig = orderConfigration.orderConfig;
        final homeConfig = orderConfigration.homeConfig;
        return Scaffold(
          backgroundColor: orderConfig.backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top Bar
                  Container(
                    padding: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: orderConfig.topContainerColor,
                    ),
                    child: customAppBar(homeConfig),
                  ),
                  // Order History Title and Filter
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          orderConfig.screenTitle,
                          style: context.text18Bold?.copyWith(
                            color: orderConfig.orderHistoryTextColor,
                            fontFamily: GoogleFonts.agbalumo.toString(),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orderConfig.filterButtonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: Icon(
                            Icons.filter_list,
                            color: orderConfig.filterIconColor,
                          ),
                          label: Text('Filter', style: context.text15Medium),
                        ),
                      ],
                    ),
                  ),

                  // Search Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: CustomTextField(
                      hintText: orderConfig.searchHint,
                      controller: searchFieldController,
                      fillColor: orderConfig.searchFieldColor,
                      inputTextStyle: context.text13Medium?.copyWith(
                        color: orderConfig.searchFieldTextColor,
                      ),
                      hintStyle: context.text14Medium?.copyWith(
                        color: orderConfig.hintTextColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Order Cards List
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return _orderCard(
                        context,
                        index,
                        orderConfig: orderConfig,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _orderCard(
    BuildContext context,
    int index, {
    required OrderConfig orderConfig,
  }) {
    final statuses = ["Completed", "Pending", "InProgress", "Refill"];
    final statusColors = {
      "Completed": Colors.green,
      "Pending": Colors.orange,
      "InProgress": Colors.blue,
      "Refill": Colors.yellow[700],
    };
    final currentStatus = statuses[index % statuses.length];

    return Card(
      color: orderConfig.cardColor,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),

            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: orderConfig.topContainerColor,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order ID: 132311${index + 1}",
                  style: context.text14Bold?.copyWith(color: Colors.white),
                ),
                Text(
                  "12/11/2025 - 02:56",
                  style: context.text12Medium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          /// Product Title
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Instagram Followers Service - Refill 30 Days Guarantee",
              style: context.text13Bold?.copyWith(
                color: orderConfig.orderProductColor,
              ),
            ),
          ),

          const SizedBox(height: 4),

          /// Link
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "🔗 https://www.likelife.com/order-history",
              style: context.text12Medium?.copyWith(
                color: orderConfig.linkColor,
              ),
            ),
          ),

          const SizedBox(height: 6),

          /// Price + Status Badge
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$200",
                  style: context.text16Bold?.copyWith(
                    color: orderConfig.priceColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: statusColors[currentStatus],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    currentStatus,
                    style: TextStyle(
                      color: orderConfig.statusColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statBlock("Start Count", "100000"),
                _statBlock("Order Quantity", "100000"),
                _statBlock("Total Quantity", "100000"),
                _statBlock("Remains", "100000"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Action"),
                ),
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  offset: const Offset(0, 40),
                  color: orderConfig.dropdownBackgroundColor,
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem(
                          value: "ticket",
                          child: Text("Create Ticket"),
                        ),
                        const PopupMenuItem(
                          value: "reorder",
                          child: Text("Reorder"),
                        ),
                      ],
                  onSelected: (value) {
                    if (value == "ticket") {
                      // Handle ticket
                    } else {
                      // Handle reorder
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statBlock(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationIcon(
    IconData icon,
    int count,
    OrderConfig orderConfig,
  ) {
    return Stack(
      children: [
        Icon(icon, color: orderConfig.menuIconColor),
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
}
