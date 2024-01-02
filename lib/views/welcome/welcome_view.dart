import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/resources/assets.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/views/welcome/bloc/welcome_bloc.dart';
import 'package:hostelway/views/welcome/navigation/welcome_navigator.dart';
import 'package:hostelway/widget_helpers/best_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(WelcomeNavigator(context)),
      child: const WelcomeLayout(),
    );
  }
}

class WelcomeLayout extends StatelessWidget {
  const WelcomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<WelcomeBloc>();
    return BlocBuilder<WelcomeBloc, WelcomeState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            scrollBehavior: const ScrollBehavior(),
            controller: state.pageController,
            scrollDirection: Axis.horizontal,
            children: [
              _buildFirstPage(state),
              _buildSecondPage(state),
              _buildThirdPage(bloc, state),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildThirdPage(WelcomeBloc bloc, WelcomeState state) {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, bottom: 50.0),
                  child: Assets.images.splashImage3.image(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyling.blackText(18, FontWeight.bold),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                        'Praesent tellus mauris, tincidunt nec ipsum id, taucibus pellentesque leo. Nunc congue ac tellus quis porttitor.',
                        style: TextStyling.greyText(15, FontWeight.normal)),
                  ],
                ),
              ],
            ),
            BestButton(
                height: 50.h,
                borderRadius: 50,
                text: 'Get Started',
                textColor: CustomColors.white,
                backgroundColor: CustomColors.primary,
                onTap: () {
                  bloc.add(const WelcomePageGetStartedButtonTapEvent());
                }),
          ]),
    ),
  );
}

Widget _buildSecondPage(WelcomeState state) {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, bottom: 50.0),
                  child: Assets.images.splashImage2.image(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyling.blackText(18, FontWeight.bold),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                        'Praesent tellus mauris, tincidunt nec ipsum id, taucibus pellentesque leo. Nunc congue ac tellus quis porttitor.',
                        style: TextStyling.greyText(15, FontWeight.normal)),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 10.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        color: CustomColors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 10.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        color: CustomColors.primary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 10.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        color: CustomColors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
                BestButton(
                  onTap: () async {
                    await state.pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut);
                  },
                  height: 35.h,
                  width: 120.w,
                  borderRadius: 50,
                  text: 'Next',
                  textColor: CustomColors.white,
                  backgroundColor: CustomColors.primary,
                ),
              ],
            )
          ]),
    ),
  );
}

Widget _buildFirstPage(WelcomeState state) {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, bottom: 50.0),
                  child: Assets.images.splashImage1.image(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyling.blackText(18, FontWeight.bold),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                        'Praesent tellus mauris, tincidunt nec ipsum id, taucibus pellentesque leo. Nunc congue ac tellus quis porttitor.',
                        style: TextStyling.greyText(15, FontWeight.normal)),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 10.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        color: CustomColors.primary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 10.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        color: CustomColors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 10.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        color: CustomColors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
                BestButton(
                  onTap: () async {
                    await state.pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut);
                  },
                  height: 35.h,
                  width: 120.w,
                  borderRadius: 50,
                  text: 'Next',
                  textColor: CustomColors.white,
                  backgroundColor: CustomColors.primary,
                ),
              ],
            )
          ]),
    ),
  );
}
