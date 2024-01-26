import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/app/auth_bloc/authentication_bloc.dart';
import 'package:hostelway/app/repository/auth_repository.dart';
import 'package:hostelway/main.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/services/overlay_service.dart';
import 'package:hostelway/views/profile/bloc/profile_bloc.dart';
import 'package:hostelway/views/profile/navigation/profile_navigator.dart';
import 'package:hostelway/widget_helpers/best_button.dart';
import 'package:hostelway/widget_helpers/custom_text_field.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
          navigator: ProfileNavigator(context),
          authRepository: context.read<AuthorizationRepository>())
        ..add(ProfileLoadEvent()),
      child: const ProfileLayout(),
    );
  }
}

class ProfileLayout extends StatelessWidget {
  const ProfileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ProfileBloc>();
    return BlocConsumer<ProfileBloc, ProfileState>(
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
            //backgroundColor: CustomColors.lightGrey,
            appBar: AppBar(
                backgroundColor: CustomColors.primary,
                leading: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_left,
                      color: CustomColors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationLogoutEvent());
                        bloc.add(const ProfileLogoutEvent());
                      },
                      icon: const Icon(
                        Icons.exit_to_app,
                        color: CustomColors.white,
                      ))
                ],
                centerTitle: true,
                title: Text('Profile',
                    style: TextStyling.whiteText(18, FontWeight.bold))),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15),
                        child:
                            Stack(alignment: Alignment.bottomRight, children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://via.placeholder.com/100'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: 100.w,
                            height: 100.h,
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                debugPrint('Change Profile Picture');
                              },
                              child: Container(
                                width: 30.w,
                                height: 30.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CustomColors.primary,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: CustomColors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      const Divider(color: CustomColors.lightGrey),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Bookings',
                                    style: TextStyling.greyText(
                                        14, FontWeight.bold)),
                                Text('0',
                                    style: TextStyling.primaryText(
                                        14, FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Reviews',
                                    style: TextStyling.greyText(
                                        14, FontWeight.bold)),
                                Text('0',
                                    style: TextStyling.primaryText(
                                        14, FontWeight.bold))
                              ],
                            ),
                            Column(
                              children: [
                                Text('Favorites',
                                    style: TextStyling.greyText(
                                        14, FontWeight.bold)),
                                Text('0',
                                    style: TextStyling.primaryText(
                                        14, FontWeight.bold))
                              ],
                            )
                          ],
                        ),
                      ),
                      const Divider(color: CustomColors.lightGrey),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15),
                        child: CustomTextField(
                          height: 80.h,
                          helperText: 'Email',
                          outlineInputBorderColor:
                              const Color.fromARGB(0, 255, 255, 255),
                          helperTextStyle:
                              TextStyling.blackText(14, FontWeight.w600),
                          onChanged: (value) {},
                          borderRad: 10.r,
                          readOnly: true,
                          hintText: 'aprilliss.2001@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                          hintTextStyle:
                              TextStyling.greyText(14, FontWeight.normal),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextField(
                              width: 170.w,
                              height: 80.h,
                              controller:
                                  TextEditingController(text: state.firstName),
                              onChanged: (value) {},
                              borderRad: 10.r,
                              helperText: 'First Name',
                              hintText: 'John',
                              keyboardType: TextInputType.text,
                              helperTextStyle:
                                  TextStyling.blackText(14, FontWeight.w600),
                              hintTextStyle:
                                  TextStyling.greyText(14, FontWeight.normal),
                            ),
                            CustomTextField(
                              width: 170.w,
                              height: 80.h,
                              onChanged: (value) {},
                              borderRad: 10.r,
                              controller:
                                  TextEditingController(text: state.lastName),
                              helperText: 'Last Name',
                              helperTextStyle:
                                  TextStyling.blackText(14, FontWeight.w600),
                              hintText: 'Doe',
                              keyboardType: TextInputType.text,
                              hintTextStyle:
                                  TextStyling.greyText(14, FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: BestButton(
                          onTap: () {},
                          height: 60.h,
                          text: "Save",
                          backgroundColor: CustomColors.primary,
                          borderRadius: 100.r,
                        ),
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
