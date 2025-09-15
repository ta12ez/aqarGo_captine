import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/followers/component/followers_item.dart';
import 'package:manzal_office/features/followers/controller/followers_cubit.dart';

import '../../core/component/shimmer_component.dart';
import '../../core/constant/app_localizations.dart';
import '../../core/constant/color.dart';

class Followers extends StatelessWidget {
  const Followers({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return BlocProvider(
      create: (context) => FollowersCubit()..getFollowers(),
      child: BlocBuilder<FollowersCubit, FollowersState>(
        builder: (context, state) {
          var cubit = FollowersCubit.get(context);
          if (state is GetFollowersLoadingState){
           return Expanded(
              child: ShimmerComponent(
                height: screenHeight(context),
                width: screenWidth(context),
              ),
            );}

          return Directionality(
            textDirection:  isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleIcon(
                    icon: Icons.arrow_back_ios_new_rounded,
                    iconOnTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                title: Row(
                  children: [
                    Icon(Icons.person,color: mainColor2,size: 30,),
                    SizedBox(width: screenWidth(context)*0.02,),
                    Text('${localizer.translate("followers")} :', style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall,),
                    SizedBox(width: screenWidth(context)*0.02,),
                    Text('${cubit.followersModel?.followersCount}', style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall,),
                    SizedBox(width: screenWidth(context)*0.02,),

                  ],
                ),
              ),
              body: Builder(
                builder: (context) {
                  if (cubit.followersModel == null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: mainColor2,
                            size: 40,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${localizer.translate("check your connection")}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: mainColor2),
                          ),
                        ],
                      ),
                    );
                  }

                  if (cubit.followersModel!.followers.isEmpty) {
                    return Center(
                      child: Text(
                        "${localizer.translate("no followers")}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: mainColor2),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return FollowersItem(follower: cubit.followersModel!.followers[index],);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: screenHeight(context) * 0.01,);
                              },
                              itemCount:cubit.followersModel!.followersCount)),
                    ],
                  );
                }
              ),
            ),
          );
        },
      ),
    );
  }
}
