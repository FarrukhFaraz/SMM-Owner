import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_owner/config/env/config_model/order_config.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
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
                              Icon(
                                Icons.menu,
                                color: orderConfig.menuIconColor,
                              ),
                              SizedBox(width: 60),
                              CircleAvatar(backgroundColor: Colors.grey),
                              const SizedBox(width: 10),
                              Text(
                                "Logo here",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: orderConfig.logoTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              _buildNotificationIcon(
                                Icons.verified,
                                13,
                                orderConfig,
                              ),
                              const SizedBox(width: 10),
                              _buildNotificationIcon(
                                Icons.notifications,
                                13,
                                orderConfig,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                      controller: searchFieldController,
                      fillColor: orderConfig.backgroundColor,
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
                      return _orderCard(context, index);
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

  Widget _orderCard(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    index % 2 == 0 ? 'Completed' : 'Pending',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              'Instagram Followers Service - Refill 30 Days Guarantee',
              style: const TextStyle(fontSize: 13),
            ),

            const SizedBox(height: 10),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '\$3200',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),

                // Buttons
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            index % 2 == 0 ? Colors.blue : Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Active'),
                    ),
                    const SizedBox(width: 5),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "ticket") {
                          // Handle ticket creation
                        } else {
                          // Handle reorder
                        }
                      },
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
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
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
