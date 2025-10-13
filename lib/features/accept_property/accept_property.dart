import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/component/shimmer_component.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/accept_property/component/accept_property_item_list.dart';
import 'package:manzal_office/features/accept_property/controller/accept_property_cubit.dart';
import 'package:manzal_office/features/accept_property/see_more_property.dart';

import '../../core/component/navigator.dart';
import '../../core/component/section_component.dart';

class AcceptProperty extends StatelessWidget {
  const AcceptProperty({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AcceptPropertyCubit()..getAcceptProperty(),
  child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Accepted Property",
          style: Theme.of(context).textTheme.titleSmall,
        ),

        leading:  Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleIcon(
            icon: Icons.arrow_back_ios_new_rounded,
            iconOnTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Builder(
            builder: (context) {
              var cubit = AcceptPropertyCubit.get(context);
              return RefreshIndicator(
                onRefresh: () async {
                  cubit.getAcceptProperty();
                },
                displacement: 10,
                color: mainColor1,
                backgroundColor: Theme.of(context).cardColor,
                child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight(context) * 0.02),

                SectionComponent(
                  title: 'Residential',
                  textButtonTitle: "seeMore",
                  onPressed: () {
                    if (cubit.residentalProperties !=
                        null) {
                      navigatTo(
                        context: context,
                        page: SeeMoreProperty(
                          type: 'Residential',
                          cubit: cubit,
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: screenHeight(context) * 0.01),

                BlocBuilder<AcceptPropertyCubit, AcceptPropertyState>(
                  builder: (context, state) {
                    // var cubit = HomeCubit.get(context);
                    if (state is GetAcceptPropertyLoadingState) {
                      return ShimmerComponent(
                        width: screenWidth(context) * 0.8,
                        height: screenHeight(context) * 0.25,
                        scrollDirection: Axis.horizontal,
                        borderRadius: BorderRadius.circular(20),
                      );
                    } else if (cubit.residentalProperties != null &&
                        cubit
                            .residentalProperties!
                            .isNotEmpty) {
                      return AcceptPropertyItemList(
                        properties:
                        cubit.residentalProperties,
                      );
                    } else {
                      return Container(
                        height: screenHeight(context) * 0.25,
                        width: double.infinity,
                        child: Center(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: mainColor2,
                              ),
                              Text(
                                "No data",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: mainColor2),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: screenHeight(context) * 0.02),

                SectionComponent(
                  title: 'Commercial',
                  textButtonTitle: "seeMore",
                  onPressed: () {
                    // var cubit = HomeCubit.get(context);
                    if (cubit.commercialProperties !=
                        null) {
                      navigatTo(
                        context: context,
                        page: SeeMoreProperty(
                          type: 'Commercial',
                          cubit: cubit,
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: screenHeight(context) * 0.01),

                BlocBuilder<AcceptPropertyCubit, AcceptPropertyState>(
                  builder: (context, state) {
                    // var cubit = HomeCubit.get(context);
                    if (state is GetAcceptPropertyLoadingState) {
                      return ShimmerComponent(
                        width: screenWidth(context) * 0.8,
                        height: screenHeight(context) * 0.25,
                        scrollDirection: Axis.horizontal,
                        borderRadius: BorderRadius.circular(20),
                      );
                    } else if (cubit.commercialProperties != null &&
                        cubit

                            .commercialProperties!
                            .isNotEmpty) {
                      return AcceptPropertyItemList(
                        properties:
                        cubit.commercialProperties,
                      );
                    } else {

                      return Container(
                        height: screenHeight(context) * 0.25,
                        width: double.infinity,
                        child: Center(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,

                            children: [
                              Icon(
                                Icons.error_outline,
                                color: mainColor2,
                              ),
                              Text(
                                "No data",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: mainColor2),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: screenHeight(context) * 0.02),

                SectionComponent(
                  title: 'Agricultural',
                  textButtonTitle: "seeMore",
                  onPressed: () {
                    // var cubit = HomeCubit.get(context);
                    if (cubit.agriculturalProperties !=
                        null) {
                      navigatTo(
                        context: context,
                        page: SeeMoreProperty(
                          type: 'Agricultural',
                          cubit: cubit,
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: screenHeight(context) * 0.01),

                BlocBuilder<AcceptPropertyCubit, AcceptPropertyState>(
                  builder: (context, state) {
                    // var cubit = HomeCubit.get(context);
                    if (state is GetAcceptPropertyLoadingState) {
                      return ShimmerComponent(
                        width: screenWidth(context) * 0.8,
                        height: screenHeight(context) * 0.25,
                        scrollDirection: Axis.horizontal,
                        borderRadius: BorderRadius.circular(20),
                      );
                    } else if (cubit.agriculturalProperties != null &&
                        cubit.agriculturalProperties!
                            .isNotEmpty) {
                      return AcceptPropertyItemList(
                        properties:
                        cubit.agriculturalProperties,
                      );
                    } else {
                      return Container(
                        height: screenHeight(context) * 0.25,
                        width: double.infinity,
                        child: Center(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: mainColor2,
                              ),
                              Text(
                                "No data",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: mainColor2),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: screenHeight(context) * 0.02),

                SectionComponent(
                  title: 'industrial',
                  textButtonTitle: "seeMore",
                  onPressed: () {
                    // var cubit = HomeCubit.get(context);
                    if (cubit.industrialProperties !=
                        null) {
                      navigatTo(
                        context: context,
                        page: SeeMoreProperty(
                          type: 'industrial',
                          cubit: cubit,
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: screenHeight(context) * 0.01),

                BlocBuilder<AcceptPropertyCubit, AcceptPropertyState>(
                  builder: (context, state) {
                    // var cubit = HomeCubit.get(context);
                    if (state is GetAcceptPropertyLoadingState) {
                      return ShimmerComponent(
                        width: screenWidth(context) * 0.8,
                        height: screenHeight(context) * 0.25,
                        scrollDirection: Axis.horizontal,
                        borderRadius: BorderRadius.circular(20),
                      );
                    } else if (cubit.industrialProperties != null &&
                        cubit
                            .industrialProperties!
                            .isNotEmpty) {
                      return AcceptPropertyItemList(
                        properties:
                        cubit.industrialProperties,
                      );
                    } else {
                      return Container(
                        height: screenHeight(context) * 0.25,
                        width: double.infinity,
                        child: Center(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,

                            children: [
                              Icon(
                                Icons.error_outline,
                                color: mainColor2,
                              ),
                              Text(
                                "No data",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: mainColor2),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
    );
  },
),
      ),
    ),
);
  }
}
