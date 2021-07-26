import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_userfollowers/models/user_follower.dart';
import 'package:flutter_userfollowers/network_calls/base_network.dart';

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
      Response response = await dioClient.ref.get("/users/torvalds?login=${widget.follower}",

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
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
  return Text(users!.name);
}
}
