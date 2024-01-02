import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/views/profile/bloc/profile_bloc.dart';
import 'package:hostelway/widget_helpers/best_button.dart';
import 'package:hostelway/widget_helpers/custom_text_field.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: const ProfileLayout(),
    );
  }
}

class ProfileLayout extends StatelessWidget {
  const ProfileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
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
                      onPressed: () {},
                      icon: Icon(
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
                                width:100,
                                height: 100,
                                child: CircleAvatar(
                                  radius: 50.r,
                                  backgroundImage:
                                      NetworkImage('https://via.placeholder.com/150'),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon:
                                      Icon(size: 50, Icons.add, color: CustomColors.primary))
                        ]),
                      ),
                      Divider(color: CustomColors.lightGrey),
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
                      Divider(color: CustomColors.lightGrey),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15),
                        child: CustomTextField(
                          helperText: 'Email',
                          outlineInputBorderColor:
                              Color.fromARGB(0, 255, 255, 255),
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
                              onChanged: (value) {},
                              borderRad: 10.r,
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
