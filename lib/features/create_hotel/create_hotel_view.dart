import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/features/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:hostelway/features/create_hotel/bloc/create_hotel_bloc.dart';
import 'package:hostelway/features/create_hotel/navigation/create_hotel_navigator.dart';
import 'package:hostelway/repositories/hotels_repository.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/services/search_places_service.dart';
import 'package:hostelway/widget_helpers/best_button.dart';
import 'package:hostelway/widget_helpers/custom_text_field.dart';
import 'package:hostelway/widget_helpers/search_places_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CreateHotelView extends StatelessWidget {
  const CreateHotelView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateHotelBloc(
          hotelsRepository: context.read<HotelsRepository>(),
          navigator: CreateHotelNavigator(context)),
      child: const CreateHotelLayout(),
    );
  }
}

class CreateHotelLayout extends StatelessWidget {
  const CreateHotelLayout({super.key});

  @override
  Widget build(BuildContext context) {
    CreateHotelBloc bloc = context.read<CreateHotelBloc>();
    return BlocBuilder<CreateHotelBloc, CreateHotelState>(
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
                padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CustomTextField(
                          helperText: 'Hotel Name',
                          outlineInputBorderColor:
                              const Color.fromARGB(0, 255, 255, 255),
                          helperTextStyle:
                              TextStyling.blackText(14, FontWeight.w600),
                          onChanged: (value) {},
                          borderRad: 10.r,
                          hintText: 'Hotel Name',
                          keyboardType: TextInputType.name,
                          hintTextStyle:
                              TextStyling.greyText(14, FontWeight.normal),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CustomTextField(
                          helperText: 'Description',
                          outlineInputBorderColor:
                              const Color.fromARGB(0, 255, 255, 255),
                          helperTextStyle:
                              TextStyling.blackText(14, FontWeight.w600),
                          onChanged: (value) {},
                          borderRad: 10.r,
                          hintText: 'Description',
                          keyboardType: TextInputType.text,
                          hintTextStyle:
                              TextStyling.greyText(14, FontWeight.normal),
                        ),
                      ),
                       
                      BestButton(
                        onTap: () {
                          bloc.add(CreateHotelButtonTapEvent(
                              name: "1223",
                              description: "fgfgfg",
                              city: "ghgh",
                              facilities: ['kk', 'hj'],
                              managerId: "ggg",
                              photos: ['hjhjhj']));
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
