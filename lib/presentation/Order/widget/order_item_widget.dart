import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/presentation/Order/model/order_model.dart';

import 'cancel_refill_widget.dart';

part 'stat_block.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, config) {
        final orderConfig = config.orderConfig;
        Color? statusColor =
            orderModel.status == "Completed"
                ? Colors.green
                : orderModel.status == "Pending"
                ? Colors.orange
                : orderModel.status == "InProgress"
                ? Colors.blue
                : orderModel.status == "Refill"
                ? Colors.yellow[700]
                : null;
        return Card(
          color: orderConfig.cardColor,
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Product id , date
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: orderConfig.topContainerColor,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Order ID: ${orderModel.orderId}", style: context.text14Bold?.copyWith(color: Colors.white)),
                    if (orderModel.createdAt != null)
                      Text(
                        DateFormat('dd/MM/yyyy - hh:mm').format(orderModel.createdAt!),
                        style: context.text12Medium?.copyWith(color: Colors.white),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 6),

              /// Product Title
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(orderModel.serviceName ?? '', style: context.text13Bold?.copyWith(color: orderConfig.orderProductColor)),
              ),

              const SizedBox(height: 4),

              /// Link
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text("🔗 ${orderModel.serviceUrl}", style: context.text12Medium?.copyWith(color: orderConfig.linkColor)),
              ),

              const SizedBox(height: 6),

              /// Price + Status Badge
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${orderModel.price ?? '0'}", style: context.text16Bold?.copyWith(color: orderConfig.priceColor)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(20)),
                      child: Text(orderModel.status ?? '', style: TextStyle(color: orderConfig.statusColor, fontSize: 12)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              CancelRefillWidget(
                canCancel: orderModel.canCancel ?? false,
                canRefill: orderModel.refillAvailable ?? false,
                onCancel: () {
                  // TODO: Show confirmation and call cancel API
                },
                onRefill: () {
                  // TODO: Call refill API
                },
              ),
              const SizedBox(height: 10),

              /// Stats Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatBlock(title: "Start Count", value: "${orderModel.startCount ?? 0}"),
                    _StatBlock(title: "Order Quantity", value: "${orderModel.orderQuantity ?? 0}"),
                    _StatBlock(title: "Total Quantity", value: "${orderModel.totalQuantity ?? 0}"),
                    _StatBlock(title: "Remains", value: "${orderModel.remainingQuantity ?? 0}"),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                            const PopupMenuItem(value: "ticket", child: Text("Create Ticket")),
                            const PopupMenuItem(value: "reorder", child: Text("Reorder")),
                          ],
                      onSelected: (value) {
                        if (value == "ticket") {
                          // Handle ticket
                        } else if (value == 'reorder') {
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
      },
    );
  }
}
