import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/show_dialog_loading.dart';
import 'package:sms_owner/core/components/snack_message.dart';
import 'package:sms_owner/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:sms_owner/presentation/favorite/widgets/favorite_item_widget.dart';
import 'package:sms_owner/presentation/service/cubit/service_cubit/service_cubit.dart';
import 'package:sms_owner/presentation/service/model/service_model.dart';

import '../../../core/components/custom_appBar.dart';

class AllServiceScreen extends StatefulWidget {
  const AllServiceScreen({super.key});

  @override
  State<AllServiceScreen> createState() => _AllServiceScreenState();
}

class _AllServiceScreenState extends State<AllServiceScreen> {
  late ServiceCubit _serviceCubit;

  List<ServiceModel> serviceList = [];

  int currentPage = 1;
  Map<String, dynamic> queryParam = {"page": 1, "per_page": 10};
  bool event = true;

  @override
  void initState() {
    super.initState();
    serviceList.clear();
    _serviceCubit = context.read<ServiceCubit>();
    _serviceCubit.fetchAllService(queryParam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: customAppBar2(backgroundColor: Color(0xff00695c)),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          if (state.status == ServiceStatus.success) {
            serviceList.addAll(state.serviceResponseModel?.service ?? []);
            if ((state.serviceResponseModel?.totalPages ?? 0) > currentPage) {
              event = false;
            }
          }
        },
        builder: (context, state) {
          if (state.status == ServiceStatus.loading) {
            return Padding(padding: EdgeInsets.only(top: 100), child: Center(child: CircularProgressIndicator()));
          }
          if ((state.serviceResponseModel?.service?.isEmpty ?? true) && state.status != ServiceStatus.initial) {
            return Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('No Service found.', style: context.text14Regular)]),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('All Services', style: context.text16Medium),
              ),
              Expanded(
                child: NotificationListener(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (event == false && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      event = true;
                      currentPage++;
                      Map<String, dynamic> queryParam = {"page": currentPage, "per_page": 10};
                      _serviceCubit.fetchAllService(queryParam  , moreLoading: true);
                      return true;
                    }
                    return false;
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    itemCount: serviceList.length + 1 ,
                    itemBuilder: (context, index) {
                      if( index == serviceList.length){
                        if((state.serviceResponseModel?.totalPages??0)>currentPage) {
                          return Center(child: CircularProgressIndicator());
                        }else{
                          return Center(child: Text('No more items'));
                        }
                      }

                      ServiceModel item = serviceList[index];
                      return FavoriteItemWidget(
                        item: item,
                        onFavoriteTap: () async {
                          showDialogLoading(context, msg: (item.isFavorite ?? false) ? 'Removing' : 'Adding');
                          if ((item.isFavorite ?? false)) {
                            bool val = await context.read<FavoriteCubit>().removeFromFavorite(item.id.toString());
                            Navigator.pop(context);
                            if (val) {
                              showSnackMessage(context, 'Removed from favorite' ,  milli: 900);
                            }
                            item.isFavorite = false;
                          } else {
                            bool val = await context.read<FavoriteCubit>().addToFavorite(item.id.toString());
                            Navigator.pop(context);
                            if (val) {
                              showSnackMessage(context, 'Added to favorite', milli: 900);
                            }
                            item.isFavorite = true;
                          }
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
