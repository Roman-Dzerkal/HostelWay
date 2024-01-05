import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostelway/features/create_hotel/bloc/create_hotel_bloc.dart';
import 'package:hostelway/features/create_hotel/navigation/create_hotel_navigator.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/widget_helpers/best_button.dart';

class CreateHotelView extends StatelessWidget {
  const CreateHotelView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreateHotelBloc(navigator: CreateHotelNavigator(context)),
      child: const CreateHotelLayout(),
    );
  }
}

class CreateHotelLayout extends StatelessWidget {
  const CreateHotelLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<CreateHotelBloc>();
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
            body: Column(
              children: [
                if (state.photos.isNotEmpty)
                  GridView.builder(
                    itemCount: state.photos.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    dragStartBehavior: DragStartBehavior.down,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 4),
                    itemBuilder: (context, index) {
                      return Image.file(state.photos[index]);
                    },
                  ),
                BestButton(
                    height: 50,
                    width: 100,
                    text: 'Add Photo',
                    backgroundColor: CustomColors.black,
                    textColor: CustomColors.white,
                    onTap: () {
                      bloc.add(OnTapAddPhotoEvent());
                    })
              ],
            ));
      },
    );
  }
}
