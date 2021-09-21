import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:get/get.dart';
import 'package:serow/constants.dart';
import 'package:serow/routes/routes.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = OverviewPageRoute.obs;
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
      case OverviewPageRoute:
        return _customIcon("assets/icons/menu.svg", itemName);
      case NotificationsPageRoute:
        return _customIcon("assets/icons/ringing.svg", itemName);
      case ProductsPageRoute:
        return _customIcon("assets/icons/product.svg", itemName);
      case CustomersPageRoute:
        return _customIcon("assets/icons/rating.svg", itemName);
      case SuppliersPageRoute:
        return _customIcon("assets/icons/production.svg", itemName);
      case AccountsPageRoute:
        return _customIcon("assets/icons/money-bag.svg", itemName);
      case ReportsPageRoute:
        return _customIcon("assets/icons/pie-chart.svg", itemName);
      case OrdersPageRoute:
        return _customIcon("assets/icons/shopping-bag.svg", itemName);
      case PredictionsPageRoute:
        return _customIcon("assets/icons/graph.svg", itemName);
      case TeamPageRoute:
        return _customIcon("assets/icons/specialist-user.svg", itemName);
      case FAQPageRoute:
        return _customIcon("assets/icons/faq.svg", itemName);
      case HelpSupportPageRoute:
        return _customIcon("assets/icons/help.svg", itemName);
      case SettingPageRoute:
        return _customIcon("assets/icons/settings.svg", itemName);
      case AuthenticationPageRoute:
        return _customIcon("assets/icons/power-button.svg", itemName);
      default:
        return _customIcon("assets/icons/power-button.svg", itemName);
    }
  }

  Widget _customIcon(String icon, String itemName) {
    if (isActive(itemName)) return SvgPicture.asset(icon, height: 18,fit: BoxFit.fitHeight,color: primaryColor);

    return SvgPicture.asset(
      icon.toString(),
      height: 16,
      color: isHovering(itemName) ? primaryColor : secondaryColor,
    );
  }
}