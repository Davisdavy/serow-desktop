import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.grey,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border(
          //     right: BorderSide(
          //         color: Colors.grey,
          //         width: 1.0
          //     )
          // )
        ),
        width: 280.0,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/logo-main.png",
              height: 70.0,
              filterQuality: FilterQuality.high,
            ),
            _SideMenuIconTab(
              iconData: "assets/icons/dashboard.png",
              title: ' Overview',
              onTap: () {},
            ),
            _SideMenuIconTab(
              iconData: "assets/icons/notification.png",
              title: 'Notifications',
              onTap: () {},
            ),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.only(left:22.0),
              child: Text("SALES",style: Theme.of(context).textTheme.bodyText2,),
            ),
            _SideMenuIconTab(
              iconData: "assets/icons/notification.png",
              title: 'Products',
              onTap: () {},
            ),
            _SideMenuIconTab(
              iconData: "assets/icons/notification.png",
              title: 'Customers',
              onTap: () {},
            ),
            _SideMenuIconTab(
              iconData: "assets/icons/notification.png",
              title: 'Suppliers',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
class _SideMenuIconTab extends StatelessWidget {
  final String iconData;
  final String title;
  final VoidCallback onTap;

  const _SideMenuIconTab({
    Key? key,
    required this.iconData,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:4.8),
      child: ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        leading: Image.asset(
          iconData.toString(),
          color: Theme.of(context).primaryColorDark,
          height: 24.0,
        ),
        title: Align(
          alignment: Alignment(-1.3, 0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
