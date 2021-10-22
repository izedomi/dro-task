import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double aspectRatio(BuildContext context) {
  final double itemHeight = (deviceHeight(context) - kToolbarHeight - 24) / 2;
  final double itemWidth = deviceHeight(context) / 2;

  double aspectRatio = (itemWidth / itemHeight);

  return aspectRatio;
}
