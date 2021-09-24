import 'package:flutter/material.dart';

const OverviewPageRoute = 'Overview';
const NotificationsPageRoute = 'Notifications';
const ProductsPageRoute = 'Products';
const CustomersPageRoute = 'Customers';
const SuppliersPageRoute = 'Suppliers';
const AccountsPageRoute = 'Accounts';
const ReportsPageRoute = 'Reports';
const OrdersPageRoute = 'Orders';
const PredictionsPageRoute = 'Predictions';
const TeamPageRoute = 'Team';
const FAQPageRoute = 'FAQ';
const HelpSupportPageRoute = 'Help';
const SettingPageRoute = 'Settings';
const AuthenticationPageRoute = 'Log Out';

List sideMenuItems = [OverviewPageRoute, NotificationsPageRoute];


// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// for(var item in list ) Text(item)
// ],
// ),
List sideItems1 = [ProductsPageRoute, CustomersPageRoute, SuppliersPageRoute];

List sideItems2 = [
  AccountsPageRoute,
  ReportsPageRoute,
  OrdersPageRoute,
  PredictionsPageRoute,
  TeamPageRoute,
];

List sideItems3 = [
  FAQPageRoute,
  HelpSupportPageRoute,
];
List sideItems4 = [
  SettingPageRoute,
  AuthenticationPageRoute,
];
