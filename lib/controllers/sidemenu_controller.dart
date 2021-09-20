

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:serow/routes/routes.dart';

class SideMenuController extends GetxController {
  //instance to get access the menu
  static SideMenuController instance = Get.find();
  var activeItem = overViewPageRoute.obs;
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case overViewPageRoute:
        return _customIcon(
            SvgPicture.asset("assets/icons/menu_dashboard.svg"), itemName);
      case NotificationsPageRoute:
        return _customIcon(
            SvgPicture.asset("assets/icons/menu_notification.svg"), itemName);
      case ProductsPageRoute:
        return _customIcon(
            SvgPicture.asset("assets/icons/product.svg"), itemName);
      case CustomersPageRoute:
        return _customIcon(
            SvgPicture.asset("assets/icons/rating.svg"), itemName);
      case SuppliersPageRoute:
        return _customIcon(
            SvgPicture.asset("assets/icons/production.svg"), itemName);
      case AccountsPageRoute:
        return _customIcon(
            SvgPicture.asset("assets/icons/money-bag.svg"), itemName);
      case ReportsPageRoute:
        return _customIcon(
            SvgPicture.asset("assets/icons/pie-chart.svg"), itemName);
      case OrdersPageRoute:
        return _customIcon(
            SvgPicture.asset("assets/icons/shopping-bag.svg"), itemName);
      case Predictions:
        return _customIcon(
            SvgPicture.asset("assets/icons/graph.svg"), itemName);
      case TeamPageRoute:
        return _customIcon(
            SvgPicture.asset("assets/icons/specialist-user.svg"), itemName);
      case FAQPageRoute:
        return _customIcon(
            SvgPicture.asset("assets/icons/faq.svg"), itemName);
      case HelpSupportPageRoute:
        return _customIcon(
            SvgPicture.asset("assets/icons/comment.svg"), itemName);
      case SettingPageRoute:
        return _customIcon(
            SvgPicture.asset("assets/icons/settings.svg"), itemName);
      case AuthenticationPageRoute:
        return _customIcon(
            SvgPicture.asset("assets/icons/power-button.svg"), itemName);
      default:
        return _customIcon(
            SvgPicture.asset('assets/icons/comment.svg'), itemName);
    }
  }

  // Widget _customIcon(IconData icon, String itemName){
  //   if(isActive(itemName)) return Icon(icon, size: 22, color: Colors.white,);
  //   return Icon(icon, color: isHovering(itemName) ? dark,)
  // }
  Widget _customIcon(SvgPicture image, String itemName) {
    if (isActive(itemName))
      return SvgPicture.asset(
        image.toString(),
        color: Colors.red,
        height: 22.0,
      );
    return SvgPicture.asset(
      image.toString(),
      color: isHovering(itemName) ? Colors.blue : Colors.green,
    );
  }
}
