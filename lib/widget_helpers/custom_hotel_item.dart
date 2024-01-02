import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/resources/text_styling.dart';

class CustomHotelItem extends StatelessWidget {
  HotelModel model;
  final double height;
  CustomHotelItem(this.model, this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 15),
        height: height,
        width: 300.w,
        child: Row(
          children: [
            Container(
              width: height * 0.8,
              height: height * 0.8,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image:
                      DecorationImage(image: NetworkImage(model.photos.first))),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(model.name,
                    style: TextStyling.blackText(14, FontWeight.bold)),
                Text(model.city,
                    style: TextStyling.blackText(14, FontWeight.bold))
              ],
            )
          ],
        ));
  }
}
