import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/repositories/hotels_repository.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/views/hotel_page/bloc/hotel_page_bloc.dart';
import 'package:hostelway/views/hotel_page/navigation/hotel_page_navigator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HotelPageView extends StatelessWidget {
  const HotelPageView(
      {required this.hotel, required this.navigator, super.key});

  final HotelModel hotel;
  final HotelPageNavigator navigator;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelPageBloc(navigator: navigator, model: hotel, rep: context.read<HotelsRepository>()),
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
    HotelPageBloc bloc = context.read<HotelPageBloc>();
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
              actions: <Widget>[
                if ((Supabase.instance.client.auth.currentUser
                        ?.userMetadata?['role'] as String) ==
                    "guest")
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      bloc.add(AddToFavoritesEvent(hotel.id));
                    },
                  )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hotel.photos.isNotEmpty)
                    CarouselSlider(
                      options: CarouselOptions(
                        disableCenter: true,
                        autoPlay: true,
                        pageSnapping: true,
                      ),
                      items: hotel.photos.map((e) {
                        return CachedNetworkImage(
                            imageUrl: e,
                            width: screenSize.width,
                            height: screenSize.height / 3,
                            fit: BoxFit.contain);
                      }).toList(),
                    ),
                  Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text('ABOUT',
                          style: TextStyling.blackText(18, FontWeight.bold))),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 15, bottom: 15, right: 15),
                      child: Text(hotel.description,
                          textAlign: TextAlign.justify,
                          style: TextStyling.blackText(
                            14,
                            FontWeight.normal,
                          ))),
                  SizedBox(
                    height: 300.h,
                    child: GoogleMap(
                      onTap: (argument) => bloc.add(OpenHotelPositionEvent(
                          LatLng(hotel.latitude, hotel.longitude))),
                      mapType: MapType.normal,
                      zoomControlsEnabled: false,
                      scrollGesturesEnabled: false,
                      zoomGesturesEnabled: false,
                      initialCameraPosition: CameraPosition(
                          zoom: 6,
                          target: LatLng(hotel.latitude, hotel.longitude)),
                      markers: {
                        Marker(
                            markerId: const MarkerId("1"),
                            position: LatLng(hotel.latitude, hotel.longitude))
                      },
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
