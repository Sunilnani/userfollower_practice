import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_userfollowers/models/userdata_model.dart';
import 'package:flutter_userfollowers/network_calls/base_network.dart';
import 'package:flutter_userfollowers/screens/user_profile.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool fetching = true;
  UserData? users;


  void fetch_users() async {
    setState(() {
      fetching = true;
    });
    try {
      //Response response = await Dio().get("https://api.github.com/search/users?q=followers%3A%3E%3D1000&ref=searchresults&s=followers&type=Users");
      Response response = await dioClient.ref.get("/search/users?q=followers%3A>%3D1000&ref=searchresults&s=followers&type=Users",

      );
      setState(() {
        users =userDataFromJson(jsonEncode(response.data));
        // print("items are ${items.length}");
        print("followers are ${users!.items.length}");
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
          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Make Friends for Fun",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.w600,fontSize: 18),),
                SizedBox(height: 20,),
                userdata()
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget userdata (){
    if(fetching){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return   ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: users!.items.length,
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>UserProfile(userimage:users!.items[index].avatarUrl,follower:users!.items[index].login
                            ),
                          ),
                        );
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
                                  text: users!.items[index].login,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.red),
                                ),
                              ],
                            ),),

                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(users!.items[index].avatarUrl),
                          ),
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





