import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/component/navigator.dart';
import 'package:manzal_office/core/constant/app_localizations.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/features/accept_property/accept_property.dart';
import 'package:manzal_office/features/edite_profile/Edite_profile.dart';
import 'package:manzal_office/features/followers/followers.dart';
import 'package:manzal_office/features/profile/component/divader_component.dart';
import 'package:manzal_office/features/profile/component/profile_item.dart';
import 'package:manzal_office/features/profile/component/setting_item.dart';
import 'package:manzal_office/features/profile/controller/profile_cubit.dart';
import 'package:manzal_office/features/profile/language_page.dart';
import 'package:manzal_office/features/request/request_page.dart';
import 'package:manzal_office/features/subscription/subscription.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {

    final localizer = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return BlocProvider(
  create: (context) => ProfileCubit()..getProfile(),
  child: Directionality(
    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,

    child: Scaffold(
      appBar:   AppBar(

          leading:  Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleIcon(
              icon: Icons.arrow_back_ios_new_rounded,
              iconOnTap: () {
                Navigator.pop(context);
              },
            ),
          ),

          title: Text(localizer.translate("profile"),style: Theme.of(context).textTheme.titleSmall,),
        ),

        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<ProfileCubit, ProfileState>(
    builder: (context, state) {
      ProfileCubit cubit=ProfileCubit.get(context);
      if(state is GetProfileDataLoading)
        {return Center(child: CircularProgressIndicator(color: mainColor1,),);}
      if(cubit.profile!=null){
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(

                  radius:60 ,
                  backgroundImage: NetworkImage(ApiConstance.urlImage(cubit.profile?.image??"")),
                ),
              ),
              SizedBox(height: screenHeight(context)*0.01,),
              Card(

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            navigatTo(context: context, page: Followers());
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("${cubit.profile?.followersCount??0}", style: Theme.of(context).textTheme.titleSmall),
                              SizedBox(height: screenHeight(context) * 0.01),
                              Text(localizer.translate("followers"), style: Theme.of(context).textTheme.titleSmall),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50, child: VerticalDivider(thickness: 1)),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            navigatTo(context: context, page: AcceptProperty());
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("${cubit.profile?.acceptedPropertiesCount??0}", style: Theme.of(context).textTheme.titleSmall),
                              SizedBox(height: screenHeight(context) * 0.01),
                              Text(localizer.translate("property"), style: Theme.of(context).textTheme.titleSmall),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50, child: VerticalDivider(thickness: 1)),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            navigatTo(context: context, page: RequestPage());
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("${cubit.profile?.pendingPropertiesCount??0}", style: Theme.of(context).textTheme.titleSmall),
                              SizedBox(height: screenHeight(context) * 0.01),
                              Text(localizer.translate("requests"), style: Theme.of(context).textTheme.titleSmall),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                ),
              ),
              SizedBox(height: screenHeight(context)*0.03,),
              Text(localizer.translate("personal data"),style: Theme.of(context).textTheme.titleSmall,),
              SizedBox(height: screenHeight(context)*0.01,),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ProfileItem(iconData: Icons.person_outline, title:  localizer.translate("name"), text: '${cubit.profile?.name}',),
                      Divider(),
                      ProfileItem(iconData: Icons.notes, title: localizer.translate("description"), text: '${cubit.profile?.description}',),
                      Divider(),

                      ProfileItem(iconData: Icons.person_outline, title: localizer.translate("percentage"), text: '${cubit.profile?.percentage}%',),
                      Divider(),

                      ProfileItem(iconData: Icons.email_outlined, title: localizer.translate("email"), text: '${cubit.profile?.email}',),
                      Divider(),

                      ProfileItem(iconData: Icons.phone_outlined, title: localizer.translate("number"), text: '${cubit.profile?.phone}',),

                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight(context)*0.03,),
              Text(localizer.translate("setting"),style: Theme.of(context).textTheme.titleSmall,),
              SizedBox(height: screenHeight(context)*0.01,),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SettingItem(iconData: Icons.edit, title: localizer.translate("edit"),onTap: (){navigatTo(context: context, page: EditeProfile(phone: '${cubit.profile?.phone}', name: '${cubit.profile?.name}', email: '${cubit.profile?.email}', percentage: '${cubit.profile?.percentage}', description: '${cubit.profile?.description}',imageurl: '${cubit.profile?.image}',));},),
                      Divider(),
                      SettingItem(iconData: Icons.language, title: localizer.translate("language"),onTap: (){navigatTo(context: context, page: LanguagePage());},),
                      Divider(),

                      SettingItem(iconData: Icons.payment, title:localizer.translate("subscription"),onTap: (){navigatTo(context: context, page: Subscription());},),
                      Divider(),

                      SettingItem(iconData: Icons.logout, title: localizer.translate("logout"),onTap: (){cubit.logOut(context);},iconColor: Colors.red,titleColor: Colors.red,),

                    ],
                  ),
                ),
              ),

            ],
          ),
        );

      }else{
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
                "Check Your Connection",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: mainColor2),
              ),
            ],
          ),
        );
      }
    },
    ),
        ),
      ),
  ),
);
  }
}
