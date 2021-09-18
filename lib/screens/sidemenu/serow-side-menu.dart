import 'package:flutter/material.dart';
import 'package:serow/screens/sidemenu/serow-list-title.dart';
import 'package:serow/screens/sidemenu/serow-menu-title.dart';

class SerowSideMenu extends StatelessWidget {
  const SerowSideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
              child: Image.asset(
            "assets/images/logox.png",
          )),
          SerowListTitle(
            title: "Overview",
            imageSrc: "assets/icons/menu.svg",
            press: () => {},
          ),
          SerowListTitle(
            title: "Notifications",
            imageSrc: "assets/icons/menu_notification.svg",
            press: () => {},
          ),
          SerowMenuTitle(
            title: "Sales",
          ),
          SerowListTitle(
            title: "Products",
            imageSrc: "assets/icons/product.svg",
            press: () => {},
          ),
          SerowListTitle(
            title: "Customers",
            imageSrc: "assets/icons/rating.svg",
            press: () => {},
          ),
          SerowListTitle(
            title: "Suppliers",
            imageSrc: "assets/icons/production.svg",
            press: () => {},
          ),
          SerowMenuTitle(
            title: "Manage",
          ),
          SerowListTitle(
            title: "Accounts",
            imageSrc: "assets/icons/money-bag.svg",
            press: () => {},
          ),
          SerowListTitle(
            title: "Reports",
            imageSrc: "assets/icons/pie-chart.svg",
            press: () => {},
          ),
          SerowListTitle(
            title: "Orders",
            imageSrc: "assets/icons/shopping-bag.svg",
            press: () => {},
          ),
          SerowListTitle(
            title: "Predictions",
            imageSrc: "assets/icons/graph.svg",
            press: () => {},
          ),
          SerowListTitle(
            title: "Team",
            imageSrc: "assets/icons/specialist-user.svg",
            press: () => {},
          ),
          SerowMenuTitle(
            title: "Other",
          ),
          SerowListTitle(
            title: "FAQ",
            imageSrc: "assets/icons/faq.svg",
            press: () => {},
          ),
          SerowListTitle(
            title: "Help & Support",
            imageSrc: "assets/icons/chat.svg",
            press: () => {},
          ),
        ],
      ),
    ));
  }
}
