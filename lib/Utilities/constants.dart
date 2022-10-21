import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
var kcurrent_datetime = DateTime.now();
var kformatedDate= "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

Color kshadow_color = Color(0xffCAE9FC);
Color kbackground_color = Color(0xffE2F1FA);
double k_shadow_blur_radius = 5;
double k_shadow_spread_radius = 5;
BoxShadow kboxShadow =  BoxShadow(
  color: kshadow_color,
  blurRadius: k_shadow_blur_radius,
  spreadRadius: k_shadow_spread_radius,
);
Color xnot_selected_container_color = Colors.white;
const xselected_container_color = Color(0xffDFDCDC);
Color male_color = xnot_selected_container_color;
Color female_color = xnot_selected_container_color;
const xcontainer_text_style = TextStyle(
  fontSize: 18.0,
  color: Colors.black,
  fontFamily: 'Oswald',
);
const xhieght_container_text_style = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.w500,
  fontFamily: 'Oswald',
  color: Color(0xff5F5F5F),
);
const xhieght_container_unit_text_style = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w400,
  color: Color(0xff5F5F5F),
  fontFamily: 'Oswald'
);
int hieght = 1;
const xicon_not_selected_color = Color(0x30ffffff);
const xicon_selected_color = Colors.white;
int bai_hieght = 1;
int bai_weight = 1;

int bai_age= 20;