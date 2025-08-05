import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/custom_textField.dart';
import 'package:sms_owner/presentation/service/cubit/service_cubit/service_cubit.dart';

import '../../../favorite/widgets/favorite_item_widget.dart';
import '../../model/service_model.dart';
import 'item_widget.dart';

class SelectServiceView extends StatefulWidget {
  const SelectServiceView({super.key, required this.onSelected, required this.categoryId});

  final void Function(ServiceModel) onSelected;
  final String categoryId;

  @override
  State<SelectServiceView> createState() {
    return _SelectServiceViewState();
  }
}

class _SelectServiceViewState extends State<SelectServiceView> {
  final ServiceCubit _serviceCubit = ServiceCubit();
  List<ServiceModel> serviceList = [];
  List<ServiceModel> searchedList = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _serviceCubit.fetchServicesByCategory(widget.categoryId);
  }


  @override
  void dispose() {
    _serviceCubit.close();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceState>(
      bloc: _serviceCubit,
      listener: (context, state) {
        if (state.status == ServiceStatus.success) {
          serviceList = state.serviceResponseModel?.service ?? [];
          searchedList = serviceList;
        }
      },
      builder: (context, state) {
        if (state.status == ServiceStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if ((state.serviceResponseModel?.service?.isEmpty ?? true) && state.status != ServiceStatus.initial) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(child: Text('No Service found with selected category', style: context.text14Regular)),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            _searchField(),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 20,right: 20 , bottom: 20),
                itemCount: searchedList.length,
                itemBuilder: (context, index) {
                  ServiceModel? item = searchedList[index];
                  return ItemWidget(
                    name: item.name??'',
                    value: '\$ ${item.rate ?? ''}',
                    onTap: () {
                      widget.onSelected(item);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
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
        fillColor: Colors.white,
        inputTextStyle: context.text15Medium,
        suffix: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(90)),
          child: Icon(Icons.search, color: Colors.white),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide(width: 1, color: Colors.grey)),
        onChanged: (value) {
          String val = value.toLowerCase();
          if (val.isEmpty) {
            searchedList = serviceList;
          } else {
            searchedList =
                serviceList.where((test) {
                  bool status = test.name.toString().toLowerCase().contains(val) || test.details.toString().toLowerCase().contains(val);
                  return status;
                }).toList();
          }

          setState(() {});
        },
      ),
    );
  }
}
