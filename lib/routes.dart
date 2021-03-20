import 'package:flutter/material.dart';

import 'example_2.dart';
import 'home.dart';

const String homeRoute = '/';

const String staggeredCountCountRoute = '/staggered_count_count';
const String staggeredExtentCountRoute = '/staggered_extent_count';
const String staggeredCountExtentRoute = '/staggered_count_extent';
const String staggeredExtentExtentRoute = '/staggered_extent_extent';

const String spannableCountCountRoute = '/spannable_count_count';
const String spannableExtentCountRoute = '/spannable_extent_count';
const String spannableCountExtentRoute = '/spannable_count_extent';
const String spannableExtentExtentRoute = '/spannable_extent_extent';

const String example01 = '/example_01';
const String example02 = '/example_02';
const String example03 = '/example_03';
const String example04 = '/example_04';
const String example05 = '/example_05';
const String example06 = '/example_06';
const String example07 = '/example_07';
const String example08 = '/example_08';
const String exampleTests = '/example_tests';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  homeRoute: (BuildContext context) => new Home(),
  // staggeredCountCountRoute: (BuildContext context) =>
  //     new StaggeredCountCountPage(),
  // staggeredExtentCountRoute: (BuildContext context) =>
  //     new StaggeredExtentCountPage(),
  // staggeredCountExtentRoute: (BuildContext context) =>
  //     new StaggeredCountExtentPage(),
  // staggeredExtentExtentRoute: (BuildContext context) =>
  //     new StaggeredExtentExtentPage(),
  // spannableCountCountRoute: (BuildContext context) =>
  //     new SpannableCountCountPage(),
  // spannableExtentCountRoute: (BuildContext context) =>
  //     new SpannableExtentCountPage(),
  // spannableCountExtentRoute: (BuildContext context) =>
  //     new SpannableCountExtentPage(),
  // spannableExtentExtentRoute: (BuildContext context) =>
  //     new SpannableExtentExtentPage(),
  // example01: (BuildContext context) => new Example01(),
  example02: (BuildContext context) => new Example02(),
};
