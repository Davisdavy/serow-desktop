import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/pages/authentication/authentication_page.dart';
import 'package:serow/responsive.dart';
import 'package:serow/routes/routes.dart';
import 'package:serow/widgets/side_menu_item.dart';

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
          title: Text("ENTITIES", style: TextStyle(color: Colors.grey, fontSize: 16),),
          children: [
            Column(
                mainAxisSize: MainAxisSize.min,
                children:
                sideItems6
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
