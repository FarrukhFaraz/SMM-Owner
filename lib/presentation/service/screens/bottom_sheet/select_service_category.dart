import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/custom_textField.dart';
import 'package:sms_owner/presentation/service/cubit/category_cubit/service_category_cubit.dart';

import '../../model/service_model.dart';
import 'item_widget.dart';

class SelectServiceCategoryView extends StatefulWidget {
  const SelectServiceCategoryView({super.key, required this.onSelected});

  final void Function(ServiceCategoryModel) onSelected;

  @override
  State<SelectServiceCategoryView> createState() {
    return _SelectServiceCategoryViewState();
  }
}

class _SelectServiceCategoryViewState extends State<SelectServiceCategoryView> {
  final ServiceCategoryCubit _serviceCategoryCubit = ServiceCategoryCubit();
  List<ServiceCategoryModel> serviceList = [];
  List<ServiceCategoryModel> searchedList = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _serviceCategoryCubit.fetchAllCategory();
    super.initState();
  }

  @override
  void dispose() {
    _serviceCategoryCubit.close();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCategoryCubit, ServiceCategoryState>(
      bloc: _serviceCategoryCubit,
      listener: (context, state) {
        if (state.status == ServiceCategoryStatus.success) {
          serviceList = state.categoryList;
          searchedList = serviceList;
        }
      },
      builder: (context, state) {
        if (state.status == ServiceCategoryStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.categoryList.isEmpty && state.status != ServiceCategoryStatus.initial) {
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
                  ServiceCategoryModel? item = searchedList[index];
                  return ItemWidget(
                    name: item.name??'',
                    value: item.status??'',
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
        hintText: 'Search category ....',
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
                  bool status =
                      test.name.toString().toLowerCase().contains(val) ||
                      test.comment.toString().toLowerCase().contains(val) ||
                      test.status.toString().toLowerCase().contains(val);
                  return status;
                }).toList();
          }

          setState(() {});
        },
      ),
    );
  }
}
