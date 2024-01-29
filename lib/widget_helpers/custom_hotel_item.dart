import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/resources/text_styling.dart';

// ignore: must_be_immutable
class CustomHotelItem extends StatelessWidget {
  HotelModel model;
  final double height;
  //final Function()? onTap;
  CustomHotelItem(this.model, this.height, /*this.onTap,*/ {super.key});

  @override
  Widget build(BuildContext context) {
    double imageSize = height * 1;

    return InkWell(
      //onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(8),
          height: height,
          width: 200.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (model.photos.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: model.photos.first,
                  height: imageSize,
                  width: imageSize,
                  fit: BoxFit.cover,
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(model.name,
                      style: TextStyling.blackText(14, FontWeight.bold)),
                  Text(model.city,
                      style: TextStyling.blackText(14, FontWeight.bold))
                ],
              )
            ],
          )),
    );
  }
}
