import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/custom_appBar.dart';
import 'package:sms_owner/core/components/custom_textField.dart';
import 'package:sms_owner/presentation/order/cubit/order_cubit.dart';
import 'package:sms_owner/presentation/order/model/order_model.dart';
import 'package:sms_owner/presentation/order/widget/order_item_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController searchFieldController = TextEditingController();

  late OrderCubit _orderCubit;

  @override
  void initState() {
    super.initState();
    _orderCubit = context.read<OrderCubit>();
    _orderCubit.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, config) {
        final orderConfig = config.orderConfig;
        final homeConfig = config.homeConfig;
        return Scaffold(
          backgroundColor: orderConfig.backgroundColor,
          appBar: customAppBar2(
              backgroundColor: Color(0xff00695c)
          ),
          body: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              if (state.status == OrderStatus.loading) {
                return Center(child: CircularProgressIndicator());
              }
              else if (state.status != OrderStatus.initial && state.orderList.isEmpty) {
                return Center(child: Text("No orders found"));
              }
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              icon: Icon(Icons.filter_list, color: orderConfig.filterIconColor),
                              label: Text('Filter', style: context.text15Medium),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CustomTextField(
                          hintText: orderConfig.searchHint,
                          controller: searchFieldController,
                          fillColor: orderConfig.searchFieldColor,
                          inputTextStyle: context.text13Medium?.copyWith(color: orderConfig.searchFieldTextColor),
                          hintStyle: context.text14Medium?.copyWith(color: orderConfig.hintTextColor),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Order Cards List
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: state.orderList.length,
                        itemBuilder: (context, index) {
                          OrderModel orderModel = state.orderList[index];
                          return OrderItemWidget(orderModel: orderModel);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
