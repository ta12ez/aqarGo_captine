import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/component/navigator.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/features/request_details/controller/request_details_cubit.dart';
import 'package:manzal_office/features/request_details/full_screen_image.dart';

class ImagesPageViewComponent extends StatelessWidget {
   ImagesPageViewComponent({super.key,required this.images,required this.propertyType});
  List<String> images ;
  String propertyType;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestDetailsCubit, RequestDetailsState>(
  builder: (context, state) {
    var cubit = RequestDetailsCubit.get(context);
    cubit.putImages(images);
    final selectedIndex =  cubit.selectedIndex;
    return SizedBox(
      height: screenHeight(context)*0.6,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30)
        ),
        child: Stack(
          children: [
            PageView.builder(
              controller: cubit.pageController,

              onPageChanged: (index) {
                cubit.selectImage(index);
              },
              itemCount: cubit.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FullScreenViewer(
                          images: cubit.images,
                          initialIndex: index,
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                  "${ApiConstance.basUrlImage}${cubit.images[index]}",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),


            Positioned(
              top: 5,
              left: 5,
              child: CircleIcon(iconOnTap: (){navigatPop( context: context);},icon: Icons.arrow_back,),
            ),

            Positioned(
              bottom: 5,
              right: 5,
              child: SizedBox(
                height: screenHeight(context)*0.2,
                width: screenWidth(context)*0.25,
                child: ListView.builder(
                  controller: cubit.scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: cubit.images.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == selectedIndex;
                    return GestureDetector(
                      onTap: () {
                        cubit.selectImage(index);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          border: isSelected
                              ? Border.all(color: Colors.green, width: 2)
                              : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            "${ApiConstance.basUrlImage}${cubit.images[index]}",
                            width: screenWidth(context)*0.25,
                            height: screenHeight(context)*0.1,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: mainColor2.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(50)
                ),
                child:Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:Text('$propertyType',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: whitColor),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
)
    ;
  }
}
