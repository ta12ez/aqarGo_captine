import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/request/component/request_item_component.dart';
import 'package:manzal_office/features/request/controller/request_cubit.dart';

import '../../core/component/shimmer_component.dart';
import '../../core/constant/app_localizations.dart';
import '../../core/constant/color.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return BlocProvider(
      create: (context) => RequestCubit()..getPendingRequest(),
      child: BlocBuilder<RequestCubit, RequestState>(
        builder: (context, state) {
          var cubit = RequestCubit.get(context);
          if (state is GetPendingRequestsLoadingState) {
            return ShimmerComponent(
              height: screenHeight(context),
              width: screenWidth(context),
            );
          }
          return Directionality(
            textDirection:  isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "${localizer.translate("requests")}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleIcon(
                    icon: Icons.arrow_back_ios_new_rounded,
                    iconOnTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              body: Builder(
                builder: (context) {
                  if (cubit.requestModel == null) {
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

                  if (cubit.requestModel!.pendingRequests.isEmpty) {
                    return Center(
                      child: Text(
                        "${localizer.translate("no new requests")}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: mainColor2),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) =>
                                RequestItemComponent(
                                  pendingRequest:
                                  cubit.requestModel!.pendingRequests[index],
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                height: screenHeight(context) * 0.01),
                            itemCount:
                            cubit.requestModel!.pendingRequests.length,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
