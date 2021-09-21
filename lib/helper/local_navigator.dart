
import 'package:flutter/material.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/routes/router.dart';
import 'package:serow/routes/routes.dart';

Navigator localNavigator() =>   Navigator(
  key: navigationController.navigatorKey,
 onGenerateRoute: generateRoute,
  initialRoute: OverviewPageRoute,
);


