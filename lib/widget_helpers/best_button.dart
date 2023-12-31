import 'package:flutter/material.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';


class BestButton extends StatelessWidget {
  final String? text;
  final void Function()? onTap;
  final Color? backgroundColor, shadowColor;
  final Color textColor, borderColor, loaderColor, notActiveColor;
  final double? progressValue, borderRadius, width;
  final BorderRadius? borderOnly;
  final double height, textSize;
  final Widget? leading, secondary, trailing;
  final MainAxisAlignment alignment;
  final TextAlign? textAlign;
  final bool isLoading, isActive, underline;
  final FontWeight fontWeight;
  final TextStyle? textStyle;
  final double? interiorPadding;
  final double? interiorPaddingLeft;
  final double? interiorPaddingRight;
  final Color? transperetHover;
  final EdgeInsets? buttonPadding;

  const BestButton({
    Key? key,
    this.shadowColor,
    this.text,
    this.onTap,
    this.borderOnly,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.loaderColor = Colors.white,
    this.borderRadius,
    this.alignment = MainAxisAlignment.center,
    required this.height,
    this.progressValue,
    this.width,
    this.leading,
    this.secondary,
    this.trailing,
    this.textAlign = TextAlign.center,
    this.isLoading = false,
    this.isActive = true,
    this.underline = false,
    this.textSize = 16,
    this.fontWeight = FontWeight.w700,
    this.textStyle,
    this.interiorPadding,
    this.transperetHover,
    this.interiorPaddingRight,
    this.buttonPadding,
    this.interiorPaddingLeft,
    this.notActiveColor = CustomColors.black,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sized = (size.shortestSide * 2) - (size.shortestSide * .35);

    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: isActive ? backgroundColor : notActiveColor,
          border: Border.all(color: borderColor),
          borderRadius:
              borderOnly ?? BorderRadius.circular(borderRadius ?? height * .2),
          boxShadow: shadowColor != null
              ? [
                  BoxShadow(
                    color: shadowColor!,
                  ),
                  BoxShadow(
                    color: backgroundColor ?? CustomColors.black,
                    spreadRadius: 0,
                    blurRadius: 10.0,
                    offset: const Offset(-1, -2),
                  ),
                ]
              : null,
        ),
        child: InkWell(
          hoverColor: transperetHover,
          highlightColor: transperetHover,
          borderRadius:
              borderOnly ?? BorderRadius.circular(borderRadius ?? height * .2),
          onTap: isActive ? onTap : null,
          child: isLoading
              ? Center(
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 4.0,
                        color: loaderColor,
                        backgroundColor: backgroundColor,
                        valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
                        value: progressValue,
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: buttonPadding ??
                      EdgeInsets.symmetric(horizontal: sized * .003),
                  child: Row(
                      mainAxisAlignment: alignment,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (leading != null)
                          Padding(
                            padding: EdgeInsets.only(
                              top: interiorPadding ?? 0,
                              left: interiorPadding ?? 0,
                              bottom: interiorPadding ?? 0,
                              right: width == double.infinity || width == null
                                  ? sized * .006
                                  : (width ?? size.width) / 30,
                            ),
                            child: leading,
                          ),
                        if (leading != null || secondary != null)
                          if (text?.isNotEmpty ?? false)
                            Padding(
                              padding: EdgeInsets.only(
                                top: interiorPadding ?? 0,
                                right: interiorPadding ?? 0,
                                bottom: interiorPadding ?? 0,
                                left: interiorPaddingLeft ?? 0,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  text: text ?? '',
                                  style: TextStyling.customText(
                                          textColor, textSize, fontWeight,
                                          underline: underline)
                                      .merge(textStyle),
                                ),
                                textAlign: textAlign ?? TextAlign.start,
                                maxLines: 2,
                              ),
                            ),
                        if (leading == null && secondary == null)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: interiorPaddingLeft ?? 0,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  text: text ?? '',
                                  style: TextStyling.customText(
                                          textColor, textSize, fontWeight,
                                          underline: underline)
                                      .merge(textStyle),
                                ),
                                textAlign: textAlign ?? TextAlign.start,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        if (secondary != null)
                          Padding(
                            padding: EdgeInsets.only(
                                left: width == double.infinity || width == null
                                    ? sized * .006
                                    : (width ?? size.width) / 30),
                            child: secondary,
                          ),
                        if (secondary != null) const Spacer(),
                        if (trailing != null) const Spacer(),
                        if (trailing != null)
                          Padding(
                            padding: EdgeInsets.only(
                              right: interiorPaddingRight ?? 0,
                            ),
                            child: trailing,
                          ),
                      ]),
                ),
        ));
  }
}
