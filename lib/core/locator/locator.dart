import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

// import '../base/bottom_nav_model.dart';

BuildContext? locatorContext;

///multi-providers as a single child widget
final allProviders = <SingleChildWidget>[
  // ChangeNotifierProvider(create: (_) => BottomNavModel()),
];
