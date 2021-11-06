import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serow/constants.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/user_provider.dart';

AppBar topNavigationBar(
    BuildContext context, GlobalKey<ScaffoldState> key) =>

    AppBar(
      automaticallyImplyLeading: false,
      elevation: 1,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
              child: Container(
                width: 250,
                height: 44,
                margin: EdgeInsets.only(top:15, bottom: 15.0, right:100.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300.withOpacity(0.6)),
                  color: Colors.grey.shade300.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      isDense: false,
                      prefixIconConstraints: BoxConstraints(maxHeight: 16,),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 5.0),
                        child: Image.asset("assets/icons/search.png", ),
                      ),
                      border: InputBorder.none,
                      hintText: "Search products, clients or anything",
                      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 11.0, fontWeight: FontWeight.w400),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0.0,
                      )
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 100.0),
              child: SizedBox(width: 200.0,),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //POS Button
                  InkWell(
                    onTap: (){

                    },
                    child: Container(
                      width: 100.0,
                      height: 38,
                      decoration: BoxDecoration(
                          color: Theme.of(context).iconTheme.color,
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset("assets/icons/pos.png", height: 24,),
                          Text("POS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 30.0,),
                  //User Avatar
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            image: DecorationImage(
                              image: AssetImage('assets/images/profile_pic.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all( Radius.circular(40.0)),
                            border: Border.all(
                              color: Color(0xFF2fb0b2),
                              width: 4.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0,),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              Auth user = Provider.of<AuthProvider>(context).auth;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:

                                [
                                  //User name
                                      Text("${user.user.fullName}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle( color: secondaryColor,fontWeight: FontWeight.w500),),

                                  SizedBox(height:2.0),
                                  //user role
                                  Text("${user.user.role}",overflow: TextOverflow.ellipsis, style: TextStyle(color: secondaryColor,fontWeight: FontWeight.w200, fontSize: 10),),
                                ],
                              );
                            }
                          ),
                        )
                      ],

                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );