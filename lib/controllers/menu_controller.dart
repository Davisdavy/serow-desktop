import 'package:flutter/material.dart';
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
        return _customIcon(Icons.trending_up, itemName);
      case NotificationsPageRoute:
        return _customIcon(Icons.drive_eta, itemName);
      case ProductsPageRoute:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case CustomersPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      case SuppliersPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      case AccountsPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      case ReportsPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      case OrdersPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      case PredictionsPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      case TeamPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      case FAQPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      case HelpSupportPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      case SettingPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      case AuthenticationPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 22, color: primaryColor);

    return Icon(
      icon,
      color: isHovering(itemName) ? primaryColor : Colors.grey,
    );
  }
}