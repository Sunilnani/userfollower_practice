import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_userfollowers/models/user_follower_model.dart';
import 'package:flutter_userfollowers/network_calls/base_network.dart';
import 'package:flutter_userfollowers/screens/userfollower.dart';

class UserProfile extends StatefulWidget {
  UserProfile({
    required this.userimage,
    required this.follower,
  });
  final String userimage;
  final String follower;
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool fetching = true;
  UserFollowers? users;



  void fetch_users() async {
    setState(() {
      fetching = true;
    });
    try {
      //Response response = await Dio().get("https://api.github.com/search/users?q=followers%3A%3E%3D1000&ref=searchresults&s=followers&type=Users");
      Response response = await dioClient.ref.get("/users/${widget.follower}",
     // Response response=await dioClient.ref.get("/users/login=${widget.follower}/followers");
      );
      setState(() {
        users =userFollowersFromJson(jsonEncode(response.data));
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

  // void fetch_users() async {
  //   setState(() {
  //     fetching = true;
  //   });
  //   try {
  //     Response response = await Dio().get("https://api.github.com/users/${widget.follower}/followers");
  //     //Response response = await dioClient.ref.get("/users/torvalds?login=${widget.follower}",
  //       // Response response=await dioClient.ref.get("/users/${widget.follower}/followers");
  //    // );
  //     setState(() {
  //       users =userFollowersFromJson(jsonEncode(response.data)) as UserFollowers?;
  //       // print("items are ${items.length}");
  //       // print("followers are ${users!.items.length}");
  //       fetching=false;
  //     });
  //     print(response);
  //   } catch (e) {
  //     setState(() {
  //       fetching=false;
  //     });
  //     print(e);
  //   }
  // }
  @override
  void initState() {
    fetch_users();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Profile ",style: TextStyle(color: Colors.pinkAccent,fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(height: 55,),
                CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(widget.userimage),
                ),
                SizedBox(height: 20,),
                Text(widget.follower),
                SizedBox(height: 20,),
                body()

              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget body(){
  if(fetching){
  return Center(
  child: CircularProgressIndicator(),
  );
  }
  return Column(
    children: [
      //Text("location: ${users!.location}"),
      SizedBox(height: 20,),
      RichText(
        text: TextSpan(
          text: 'Location : ',
          style: TextStyle(fontSize: 14.0, color: Colors.lightBlue,fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text: users!.location,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.red),
            ),
          ],
        ),),
      SizedBox(height: 20,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(

            children: [
              Text("Followers",style: TextStyle(color: Colors.lightBlueAccent,fontSize: 16,fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>UserFollower(follower:users!.login
                      ),
                    ),
                  );
                },
                child: Text("${users!.followers}"),
              )

            ],
          ),
          SizedBox(width: 30,),
          Column(

            children: [
              Text("Following",style: TextStyle(color: Colors.lightBlueAccent,fontSize: 16,fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              Text("${users!.following}")

            ],
          )
        ],
      )
    ],
  );
}
}
