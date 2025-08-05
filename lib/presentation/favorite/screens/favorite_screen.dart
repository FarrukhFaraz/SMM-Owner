import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/buttons.dart';
import 'package:sms_owner/core/components/show_dialog_loading.dart';
import 'package:sms_owner/core/components/snack_message.dart';
import 'package:sms_owner/core/utils/navigation.dart';
import 'package:sms_owner/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:sms_owner/presentation/favorite/model/favorite_model.dart';
import 'package:sms_owner/presentation/favorite/widgets/favorite_item_widget.dart';
import 'package:sms_owner/presentation/service/screens/service_screen.dart';

import '../../../core/components/custom_appBar.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen({super.key});

  @override
  State<MyFavoritesScreen> createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
  final List<Map<String, String>> favorites = [
    {"category": "Instagram followers", "service": "Instagram followers [48h refill]", "price": "\$100"},
    {"category": "Instagram followers", "service": "Instagram followers [1k] refill - USA", "price": "\$200"},
    {"category": "Instagram views", "service": "Instagram views [1M] refill", "price": "\$300"},
  ];

  late FavoriteCubit _favoriteCubit;

  @override
  void initState() {
    super.initState();
    _favoriteCubit = context.read<FavoriteCubit>();
    _favoriteCubit.fetchUserFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      appBar: customAppBar2(backgroundColor: Color(0xff00695c)),
      body: BlocConsumer<FavoriteCubit, FavoriteState>(
        listener: (context, state) {
          if (state.status == FavoriteStatus.error) {
            showSnackErrorMessage(context, state.message, 4);
          }
        },
        builder: (context, state) {
          if (state.status == FavoriteStatus.loading) {
            return Padding(padding: EdgeInsets.only(top: 100),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.favoriteList.isEmpty && state.status != FavoriteStatus.initial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No favorite found.', style: context.text14Regular),
                  SizedBox(height: 20),
                  CustomButton(
                    buttonColor: Color(0xffffc61a),
                    buttonTitle: 'Go to Service',
                    width: 146,
                    height: 42,
                    textStyle: context.text14Medium?.copyWith(color: Colors.white),
                    onPressed: () {
                      NavigationService.push(AllServiceScreen());
                    },
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text('My favorite list', style: context.text16Medium),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        NavigationService.push(AllServiceScreen());
                      },
                      child: Text('View all',
                      style: context.text16Medium?.copyWith(color: Color(0xffffc61a),
                      decoration: TextDecoration.underline
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  itemCount: state.favoriteList.length,
                  itemBuilder: (context, index) {
                    FavoriteModel item = state.favoriteList[index];
                    return FavoriteItemWidget(
                      item: item.service,
                      onFavoriteTap: () async {
                        showDialogLoading(context, msg: (item.service?.isFavorite ?? false) ? 'Removing' : 'Adding');
                        if ((item.service?.isFavorite ?? false)) {
                          bool val = await _favoriteCubit.removeFromFavorite(item.serviceId.toString());
                          Navigator.pop(context);
                          if (val) {
                            showSnackMessage(context, 'Removed from favorite');
                          }
                        } else {
                          bool val = await _favoriteCubit.addToFavorite(item.serviceId.toString());
                          Navigator.pop(context);
                          if (val) {
                            showSnackMessage(context, 'Added to favorite');
                          }
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
