import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_userfollowers/models/followers_model.dart';
import 'package:flutter_userfollowers/network_calls/base_network.dart';
class UserFollower extends StatefulWidget {
UserFollower({
  required this.follower,
});
final String follower;

  @override
  _UserFollowerState createState() => _UserFollowerState();
}

class _UserFollowerState extends State<UserFollower> {
  bool fetching = true;
  Followers? follower;



  void fetch_usersfollower() async {
    setState(() {
      fetching = true;
    });
    try {
      //Response response = await Dio().get("https://api.github.com/search/users?q=followers%3A%3E%3D1000&ref=searchresults&s=followers&type=Users");
      Response response = await dioClient.ref.get("/users/${widget.follower}/followers",
        // Response response=await dioClient.ref.get("/users/login=${widget.follower}/followers");
      );
      setState(() {
        follower =followersFromJson(jsonEncode(response.data)) as Followers?;
        // print("items are ${items.length}");
        // print("followers are ${users!.items.length}");
        fetching=false;
      });
      print(response);
    } catch (e) {
      setState(() {
        fetching=false;
      });
      print(e);
    }
  }
  @override
  void initState() {
    fetch_usersfollower();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
         child: Column(
           children: [
             userfollowersdata()
           ],
         ),
       ),
     );
       //Container(
    //   child: Text(follower!.login),
    // );
  }
  Widget userfollowersdata(){
    if(fetching){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: follower!.login.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context,index){
        return Container(
            child:SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap:(){
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) =>UserProfile(userimage:users!.items[index].avatarUrl,follower:users!.items[index].login
                        //     ),
                        //   ),
                        // );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'user name   ',
                              style: TextStyle(fontSize: 12.0, color: Colors.lightBlue,fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text: follower!.login,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.red),
                                ),
                              ],
                            ),),

                          // CircleAvatar(
                          //   radius: 35,
                          //   backgroundImage: NetworkImage(users!.items[index].avatarUrl),
                          // ),
                        ],
                      )
                  ),
                  SizedBox(height: 20,),

                ],
              ),
            )
        );
      },
    );
  }
}
