import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/features/create_hotel/bloc/create_hotel_bloc.dart';
import 'package:hostelway/features/create_hotel/navigation/create_hotel_navigator.dart';
import 'package:hostelway/main.dart';
import 'package:hostelway/repositories/hotels_repository.dart';
import 'package:hostelway/resources/const.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/services/overlay_service.dart';
import 'package:hostelway/widget_helpers/best_button.dart';
import 'package:hostelway/widget_helpers/custom_text_field.dart';
import 'package:place_picker/place_picker.dart';

class CreateHotelView extends StatelessWidget {
  const CreateHotelView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateHotelBloc(
          hotelsRepository: context.read<HotelsRepository>(),
          navigator: CreateHotelNavigator(context))
        ..add(FetchCurrentLocationEvent()),
      child: const CreateHotelLayout(),
    );
  }
}

class CreateHotelLayout extends StatelessWidget {
  const CreateHotelLayout({super.key});

  @override
  Widget build(BuildContext context) {
    CreateHotelBloc bloc = context.read<CreateHotelBloc>();
    return BlocConsumer<CreateHotelBloc, CreateHotelState>(
      listener: (context, state) {
        if (state.isBusy) {
          OverlayService.instance.showBusyOverlay(
            context: context,
            size: size,
          );
        } else {
          OverlayService.instance.closeBusyOverlay(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.keyboard_arrow_left_outlined),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
              backgroundColor: CustomColors.primary,
              title: Text('Create Hotel',
                  style: TextStyling.whiteText(18, FontWeight.bold)),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 15, right: 15),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CustomTextField(
                          height: 80.h,
                          helperText: 'Hotel Name',
                          errorText: state.errorState.isNameError
                              ? state.errorNameMessage
                              : null,
                          outlineInputBorderColor:
                              const Color.fromARGB(0, 255, 255, 255),
                          helperTextStyle:
                              TextStyling.blackText(14, FontWeight.w600),
                          onChanged: (value) {
                            bloc.add(NameChangedEvent(value));
                          },
                          borderRad: 10.r,
                          hintText: 'Hotel Name',
                          keyboardType: TextInputType.name,
                          hintTextStyle:
                              TextStyling.greyText(14, FontWeight.normal),
                        ),
                      ),
                      CustomTextField(
                        height: 80.h,
                        helperText: 'Description',
                        outlineInputBorderColor:
                            const Color.fromARGB(0, 255, 255, 255),
                        errorText: state.errorState.isDescriptionError
                            ? state.errorDescriptionMessage
                            : null,
                        helperTextStyle:
                            TextStyling.blackText(14, FontWeight.w600),
                        onChanged: (value) {
                          bloc.add(DescriptionChangedEvent(value));
                        },
                        onSubmitted: (p0) {
                          bloc.add(DescriptionSubmittedEvent(p0));
                        },
                        borderRad: 10.r,
                        hintText: 'Description',
                        keyboardType: TextInputType.text,
                        hintTextStyle:
                            TextStyling.greyText(14, FontWeight.normal),
                      ),
                      CustomTextField(
                        height: 80.h,
                        helperText: 'Location',
                        outlineInputBorderColor:
                            const Color.fromARGB(0, 255, 255, 255),
                        errorText: state.errorState.isLocationError
                            ? state.errorLocationMessage
                            : null,
                        readOnly: true,
                        helperTextStyle:
                            TextStyling.blackText(14, FontWeight.w600),
                        borderRad: 10.r,
                        onTap: () async {
                          LocationResult result = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => PlacePicker(
                                        googleApiKey,
                                        displayLocation:
                                            state.currentUserLocation == null
                                                ? LatLng(
                                                    state.currentUserLocation!
                                                        .latitude,
                                                    state.currentUserLocation!
                                                        .longitude)
                                                : const LatLng(0, 0),
                                      )));
                          bloc.add(LocationChangedEvent(result));
                        },
                        controller: TextEditingController(
                            text: state.hotelLocation?.formattedAddress),
                        hintText: 'Location',
                        hintTextStyle:
                            TextStyling.greyText(14, FontWeight.normal),
                      ),
                      if (state.localPhotos.isNotEmpty)
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10.w),
                          child: GridView.count(
                            padding: EdgeInsets.only(left: 20.w),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            crossAxisCount: 4,
                            mainAxisSpacing: 8.w,
                            children: [
                              ...state.localPhotos
                                  .map((e) => Container(
                                        width: 78.w,
                                        margin: EdgeInsets.only(right: 8.w),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.r))),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Image.file(
                                              File(e.path),
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                                right: 8.w,
                                                top: 8.w,
                                                child: InkWell(
                                                  onTap: () {
                                                    bloc.add(RemoveImageEvent(
                                                        state.localPhotos
                                                            .indexOf(e)));
                                                  },
                                                  child: Container(
                                                      width: 20.w,
                                                      height: 20.w,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      100.r))),
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                        size: 15,
                                                      )),
                                                ))
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              NewWidget(onTap: () {
                                bloc.add(UploadOnePhotoButtonTapEvent());
                              })
                            ],
                          ),
                        ),
                      if (state.localPhotos.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: NewWidget(onTap: () {
                            bloc.add(UploadPhotoButtonTapEvent());
                          }),
                        ),
                      BestButton(
                        onTap: () {
                          bloc.add(CreateHotelButtonTapEvent());
                        },
                        height: 60.h,
                        text: "Create",
                        backgroundColor: CustomColors.primary,
                        borderRadius: 100.r,
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: 78.w,
          height: 78.w,
          margin: EdgeInsets.only(right: 8.w),
          decoration: BoxDecoration(
              border: Border.all(
                  style: BorderStyle.solid,
                  strokeAlign: BorderSide.strokeAlignInside,
                  color: CustomColors.black),
              borderRadius: BorderRadius.all(Radius.circular(8.r))),
          alignment: Alignment.center,
          child: Text(
            '+',
            style: TextStyling.blackText(24, FontWeight.bold),
          )),
    );
  }
}
