import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';

import '../../../config/env/config_model/home_config.dart';
import '../../../config/env/env_cubit.dart';
import '../../../config/env/env_model.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/custom_appBar.dart';
import '../../../core/components/custom_textField.dart';
import '../../../core/components/range_input_formatter.dart';
import '../../../core/components/show_dialog_loading.dart';
import '../../../core/components/snack_message.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/utils/common_keys.dart';
import '../../order/cubit/order_cubit.dart';
import '../../service/model/service_model.dart';
import '../../service/screens/bottom_sheet/select_service.dart';
import '../../service/screens/bottom_sheet/select_service_category.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {

  OrderCubit orderCubit = OrderCubit();

  TextEditingController quantityController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  ServiceCategoryModel? selectedCategory;
  ServiceModel? selectedService;
  double total = 0.0;
  final FocusNode _quantityNode = FocusNode();
  final FocusNode _linkNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _linkNode.unfocus();
    _quantityNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, homeConfiguration) {
        final homeConfig = homeConfiguration.homeConfig;
        return Scaffold(
          backgroundColor: homeConfig.backGroundColor,
          appBar: customAppBar2(backgroundColor: Color(0xff00695c)),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                _dropdownSection(
                  title: 'Category',
                  value: selectedCategory?.name ?? '',
                  onTap: () async {
                    _linkNode.unfocus();
                    _quantityNode.unfocus();
                    await showModalBottomSheet(
                      context: context,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.8,
                        minHeight: MediaQuery.of(context).size.height * 0.8,
                      ),
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      useSafeArea: true,
                      sheetAnimationStyle: AnimationStyle(curve: Curves.easeInOutBack),
                      showDragHandle: false,
                      builder: (context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width,
                          child: SelectServiceCategoryView(
                            onSelected: (ServiceCategoryModel model) {
                              Navigator.pop(context);
                              selectedCategory = model;
                              selectedService = null;
                              setState(() {});
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                _dropdownSection(
                  title: 'Services',
                  value: selectedService?.name ?? '',
                  disabled: selectedCategory == null,
                  onTap: () async {
                    _linkNode.unfocus();
                    _quantityNode.unfocus();
                    await showModalBottomSheet(
                      context: context,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.8,
                        minHeight: MediaQuery.of(context).size.height * 0.8,
                      ),
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      useSafeArea: true,
                      sheetAnimationStyle: AnimationStyle(curve: Curves.easeInOutBack),
                      showDragHandle: false,
                      builder: (context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width,
                          child: SelectServiceView(
                            categoryId: selectedCategory?.id?.toString() ?? '',
                            onSelected: (ServiceModel model) {
                              Navigator.pop(context);
                              selectedService = model;
                              if (quantityController.text.isNotEmpty) {
                                double rate = (double.tryParse('${selectedService?.rate ?? 0.0}') ?? 0.0);
                                double qty = (double.tryParse(quantityController.text) ?? 0.0);
                                total = rate * qty;
                              }

                              setState(() {});
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
                _linkField(homeConfig, label: "Link"),
                _quantitySection(homeConfig),
                const SizedBox(height: 30),
                Text("Total: \$${total.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blue)),
                const SizedBox(height: 20),
                BlocConsumer<OrderCubit, OrderState>(
                  bloc: orderCubit,
                  listener: (context, state) {
                    if (state.status == OrderStatus.success || state.status == OrderStatus.error) {
                      if (state.createOrderModel?.statusCode == 200) {
                        selectedCategory = null;
                        selectedService = null;
                        quantityController.clear();
                        linkController.clear();
                        total = 0.0;
                        Navigator.pop(context);
                        showSnackMessage(context, state.createOrderModel?.message ?? '');
                      } else if (state.createOrderModel?.statusCode == 404) {
                        Navigator.pop(context);
                        showSnackErrorMessage(context, state.createOrderModel?.message ?? '', 3);
                      }
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      buttonColor: Color(0xffffc61a),
                      buttonTitle: 'order Now',
                      disable: selectedCategory == null || selectedService == null || linkController.text.isEmpty || total == 0,
                      textStyle: context.text16Bold?.copyWith(color: Colors.white),
                      width: MediaQuery.of(context).size.width / 2,
                      onPressed: () async {
                        _linkNode.unfocus();
                        _quantityNode.unfocus();

                        await showDialogLoading(context, msg: 'Creating');

                        Map<String, dynamic> body = {
                          "user_id": await SecureStorageService.getString(CommonKeys.userId),
                          "service": selectedService?.id,
                          "link": linkController.text,
                          "quantity": quantityController.text,
                          "charge": total,
                          "type": "normal",
                        };
                        await orderCubit.createOrder(body);
                      },
                    );
                  },
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _dropdownSection({required String title, required Function() onTap, required String value, bool disabled = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.only(left: 10), child: Text(title, style: context.text14Bold, maxLines: 2)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: disabled ? null : onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: disabled ? Colors.grey[350]! : Colors.grey),
              ),
              child: Text(
                value.isNotEmpty ? value : 'Select ${title.toLowerCase()}',
                style: context.text14Regular?.copyWith(
                  color:
                      disabled
                          ? Colors.grey[350]
                          : value.isEmpty
                          ? Colors.black45
                          : Colors.black,
                ),
              ),
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
            child: Text(label, style: context.text12Medium?.copyWith(color: homeConfig.categoryTextColor, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            controller: linkController,
            hintText: 'link ....',
            focusNode: _linkNode,
            inputTextStyle: context.text15Medium?.copyWith(color: homeConfig.dropDownTextColor),
            hintStyle: context.text12Medium?.copyWith(color: Colors.grey),
            keyboardType: TextInputType.visiblePassword,
            fillColor: homeConfig.textFieldColor,
            suffix: GestureDetector(
              onTap: () async {
                final String text = await FlutterClipboard.paste();
                linkController.text = text;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: homeConfig.pasteButtonBackgroundColor, borderRadius: BorderRadius.circular(5)),
                child: Text("Paste", style: context.text12Bold?.copyWith(color: homeConfig.pasteButtonTextColor)),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(width: 1, color: homeConfig.textFieldBorderColor),
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
            child: Text("Quantity", style: context.text12Medium?.copyWith(color: homeConfig.categoryTextColor, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            controller: quantityController,
            hintText: '100',
            focusNode: _quantityNode,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3), RangeInputFormatter(min: 1, max: 1000)],
            onChanged: (value) {
              if (value.isEmpty) {
                total = 0.0;
              } else {
                if (selectedService != null) {
                  double rate = (double.tryParse('${selectedService?.rate ?? 0.0}') ?? 0.0);
                  double qty = (double.tryParse(value) ?? 0.0);
                  total = rate * qty;
                } else {
                  total = 0.0;
                }
              }
              setState(() {});
            },
            hintStyle: context.text12Medium?.copyWith(color: homeConfig.hintTextColor),
            keyboardType: TextInputType.visiblePassword,
            fillColor: homeConfig.textFieldColor,
            inputTextStyle: context.text15Medium?.copyWith(color: homeConfig.dropDownTextColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(width: 1, color: homeConfig.textFieldBorderColor),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Min: 1", style: TextStyle(fontStyle: FontStyle.italic)),
                Text("Max: 1000", style: TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
