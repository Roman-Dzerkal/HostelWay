import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/views/hotel_page/bloc/hotel_page_bloc.dart';
import 'package:hostelway/views/hotel_page/navigation/hotel_page_navigator.dart';

class HotelPageView extends StatelessWidget {
  const HotelPageView(
      {required this.hotel, required this.navigator, super.key});

  final HotelModel hotel;
  final HotelPageNavigator navigator;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelPageBloc(hotel),
      child: HotelPageViewLayout(
        hotel: hotel,
        navigator: navigator,
      ),
    );
  }
}

class HotelPageViewLayout extends StatelessWidget {
  const HotelPageViewLayout(
      {required this.hotel, required this.navigator, super.key});
  final HotelModel hotel;
  final HotelPageNavigator navigator;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocBuilder<HotelPageBloc, HotelPageState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.keyboard_arrow_left,
                    color: CustomColors.white),
                onPressed: () => Navigator.pop(context),
              ),
              backgroundColor: CustomColors.primary,
              centerTitle: true,
              title: Text(hotel.name,
                  style: TextStyling.whiteText(18, FontWeight.bold)),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: hotel.photos.first,
                  width: screenSize.width,
                  height: screenSize.height / 3,
                  fit: BoxFit.cover,
                ),
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text('ABOUT',
                        style: TextStyling.blackText(18, FontWeight.bold))),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 15, bottom: 15, right: 15),
                    child: Text(hotel.description,
                        textAlign: TextAlign.justify,
                        style: TextStyling.blackText(
                          14,
                          FontWeight.normal,
                        )))
              ],
            ));
      },
    );
  }
}
