import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderMenu extends StatelessWidget {
  const HeaderMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.grey,
      child: Container(
        color: Colors.white,
        height: 64.0,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  width: 280,
                  margin: EdgeInsets.only(top:1, bottom: 5.0, right:14.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300.withOpacity(0.6)),
                    color: Colors.grey.shade300.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: false,
                      prefixIconConstraints: BoxConstraints(maxHeight: 18,),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 5.0),
                        child: Image.asset("assets/icons/search.png", ),
                      ),
                      border: InputBorder.none,
                      hintText: "Search products, clients or anything",
                      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 11.0, fontWeight: FontWeight.w400),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 6.0,
                      )
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //POS Button
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        width: 100.0,
                        height: 42,
                        decoration: BoxDecoration(
                            color: Theme.of(context).iconTheme.color,
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset("assets/icons/pos.png", height: 26,),
                            Text("POS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 50.0,),
                    //User Avatar
                    Expanded(
                      child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              image: DecorationImage(
                                image: AssetImage('assets/images/profile_pic.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all( Radius.circular(50.0)),
                              border: Border.all(
                                color: Color(0xFF2fb0b2),
                                width: 4.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top:10.0, left: 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //User name
                                  Text("Emmanuel Kiyai",overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w700),),
                                  SizedBox(height:5.0),
                                  //user role
                                  Text("Administrator",overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w200, fontSize: 10),),
                                ],
                              ),
                            ),
                          )
                        ],

                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
