import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/pages/authentication/authentication_page.dart';
import 'package:serow/responsive.dart';
import 'package:serow/routes/routes.dart';
import 'package:serow/widgets/side_menu_item.dart';

import 'custom_text.dart';
// class SideMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shadowColor: Colors.grey,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           // border: Border(
//           //     right: BorderSide(
//           //         color: Colors.grey,
//           //         width: 1.0
//           //     )
//           // )
//         ),
//         width: 250.0,
//         height: double.infinity,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.asset(
//                 "assets/images/logo-main.png",
//                 height: 70.0,
//                 filterQuality: FilterQuality.high,
//               ),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/dashboard.png",
//                 title: 'Overview',
//                 onTap: () {},
//               ),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/notification.png",
//                 title: 'Notifications',
//                 onTap: () {},
//               ),
//               SizedBox(height: 10.0,),
//               Padding(
//                 padding: const EdgeInsets.only(left:22.0),
//                 child: Text("SALES",style: Theme.of(context).textTheme.bodyText2,),
//               ),
//               SizedBox(height: 5.0,),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/products.png",
//                 title: 'Products',
//                 onTap: () {},
//               ),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/rating.png",
//                 title: 'Customers',
//                 onTap: () {},
//               ),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/production.png",
//                 title: 'Suppliers',
//                 onTap: () {},
//               ),
//               SizedBox(height: 10.0,),
//               Padding(
//                 padding: const EdgeInsets.only(left:22.0),
//                 child: Text("MANAGE",style: Theme.of(context).textTheme.bodyText2,),
//               ), SizedBox(height: 5.0,),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/money-bag.png",
//                 title: 'Accounts',
//                 onTap: () {},
//               ),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/pie-chart.png",
//                 title: 'Reports',
//                 onTap: () {},
//               ),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/shopping-bag.png",
//                 title: 'Orders',
//                 onTap: () {},
//               ),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/graph.png",
//                 title: 'Predictions',
//                 onTap: () {},
//               ),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/specialist-user.png",
//                 title: 'Team',
//                 onTap: () {},
//               ),
//               SizedBox(height: 10.0,),
//               Padding(
//                 padding: const EdgeInsets.only(left:22.0),
//                 child: Text("OTHER",style: Theme.of(context).textTheme.bodyText2,),
//               ), SizedBox(height: 5.0,),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/faqs.png",
//                 title: 'FAQ',
//                 onTap: () {},
//               ),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/help.png",
//                 title: 'Help & Support',
//                 onTap: () {},
//               ),
//               SizedBox(height: 20.0,),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/settings.png",
//                 title: 'settings',
//                 onTap: () {},
//               ),
//               _SideMenuIconTab(
//                 iconData: "assets/icons/power-button.png",
//                 title: 'Logout',
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class _SideMenuIconTab extends StatelessWidget {
//   final String iconData;
//   final String title;
//   final VoidCallback onTap;
//
//   const _SideMenuIconTab({
//     Key? key,
//      required this.iconData,
//     required this.title,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left:4.8),
//       child: ListTile(
//         visualDensity: VisualDensity(horizontal: 0, vertical: -4),
//         leading: Image.asset(
//           iconData.toString(),
//           color: Theme.of(context).primaryColorDark,
//           height: 22.0,
//         ),
//         title: Text(
//           title,
//           style: Theme.of(context).textTheme.bodyText1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
// }
class SideMenu extends StatelessWidget {
  const SideMenu({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    var sales = ["SALES"];
    return Container(

    color: Colors.white,
    child: ListView(
      children: [
        // if(ResponsiveWidget.isSmallScreen(context))
          Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right:60.0),
                child: Image.asset("assets/images/logo-main.png",),
              ),

            ],
          ),



        Column(
          children:
          sideMenuItems
              .map((itemName) => Column(
            children: [
              SideMenuItem(
                  itemName: itemName == AuthenticationPageRoute ? "Log Out" :itemName,
                  onTap: () {
                    if(itemName == AuthenticationPageRoute){
                      Get.offAll(() => AuthenticationPage());
                      // menuController.changeActiveItemTo(overviewPageDisplayName);

                    }
                    if (!menuController.isActive(itemName)) {
                      menuController.changeActiveItemTo(itemName);
                      // if(ResponsiveWidget.isSmallScreen(context))
                      //   Get.back();
                      navigationController.navigateTo(itemName);
                    }
                  }),
            ],
          ) ).toList()
        ),
        ExpansionTile(
          title: Text("INVENTORY", style: TextStyle(color: Colors.grey, fontSize: 16),),
          children: [
            Column(
                mainAxisSize: MainAxisSize.min,
                children:
                sideItems5
                    .map((itemName) => Column(
                  children: [

                    SideMenuItem(
                        itemName: itemName == AuthenticationPageRoute ? "Log Out" :itemName,
                        onTap: () {
                          if(itemName == AuthenticationPageRoute){
                            Get.offAll(() => AuthenticationPage());
                            // menuController.changeActiveItemTo(overviewPageDisplayName);

                          }
                          if (!menuController.isActive(itemName)) {
                            menuController.changeActiveItemTo(itemName);
                            // if(ResponsiveWidget.isSmallScreen(context))
                            //   Get.back();
                            navigationController.navigateTo(itemName);
                          }
                        }),
                  ],
                ) ).toList()
            ),
          ],
        ),
        ExpansionTile(
          title: Text("SALES", style: TextStyle(color: Colors.grey, fontSize: 16),),
          children: [
            Column(
                mainAxisSize: MainAxisSize.min,
                children:
                sideItems1
                    .map((itemName) => Column(
                  children: [

                    SideMenuItem(
                        itemName: itemName == AuthenticationPageRoute ? "Log Out" :itemName,
                        onTap: () {
                          if(itemName == AuthenticationPageRoute){
                            Get.offAll(() => AuthenticationPage());
                            // menuController.changeActiveItemTo(overviewPageDisplayName);

                          }
                          if (!menuController.isActive(itemName)) {
                            menuController.changeActiveItemTo(itemName);
                            // if(ResponsiveWidget.isSmallScreen(context))
                            //   Get.back();
                            navigationController.navigateTo(itemName);
                          }
                        }),
                  ],
                ) ).toList()
            ),
          ],
        ),

        ExpansionTile(
          title: Text("MANAGE", style: TextStyle(color: Colors.grey, fontSize: 16),),
          children: [Column(
              mainAxisSize: MainAxisSize.min,
              children:
              sideItems2
                  .map((itemName) => Column(
                children: [

                  SideMenuItem(
                      itemName: itemName == AuthenticationPageRoute ? "Log Out" :itemName,
                      onTap: () {
                        if(itemName == AuthenticationPageRoute){
                          Get.offAll(() => AuthenticationPage());
                          // menuController.changeActiveItemTo(overviewPageDisplayName);

                        }
                        if (!menuController.isActive(itemName)) {
                          menuController.changeActiveItemTo(itemName);
                          // if(ResponsiveWidget.isSmallScreen(context))
                          //   Get.back();
                          navigationController.navigateTo(itemName);
                        }
                      }),
                ],
              ) ).toList()
          ),]
        ),

        ExpansionTile(
          title: Text("OTHER", style: TextStyle(color: Colors.grey, fontSize: 16),),
          children: [Column(
              mainAxisSize: MainAxisSize.min,
              children:
              sideItems3
                  .map((itemName) => Column(
                children: [

                  SideMenuItem(
                      itemName: itemName == AuthenticationPageRoute ? "Log Out" :itemName,
                      onTap: () {
                        if(itemName == AuthenticationPageRoute){
                          Get.offAll(() => AuthenticationPage());
                          // menuController.changeActiveItemTo(overviewPageDisplayName);

                        }
                        if (!menuController.isActive(itemName)) {
                          menuController.changeActiveItemTo(itemName);
                          // if(ResponsiveWidget.isSmallScreen(context))
                          //   Get.back();
                          navigationController.navigateTo(itemName);
                        }
                      }),
                ],
              ) ).toList()
          ),]
        ),
        Column(
            mainAxisSize: MainAxisSize.min,
            children:
            sideItems4
                .map((itemName) => Column(
              children: [

                SideMenuItem(
                    itemName: itemName == AuthenticationPageRoute ? "Log Out" :itemName,
                    onTap: () {
                      if(itemName == AuthenticationPageRoute){
                        Get.offAll(() => AuthenticationPage());
                        // menuController.changeActiveItemTo(overviewPageDisplayName);

                      }
                      if (!menuController.isActive(itemName)) {
                        menuController.changeActiveItemTo(itemName);
                        // if(ResponsiveWidget.isSmallScreen(context))
                        //   Get.back();
                        navigationController.navigateTo(itemName);
                      }
                    }),
              ],
            ) ).toList()
        ),
      ],
    ),
      );
  }
}
