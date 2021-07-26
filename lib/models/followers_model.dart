// // To parse this JSON data, do
// //
// //     final followers = followersFromJson(jsonString);
//
// import 'dart:convert';
//
// List<Followers> followersFromJson(String str) => List<Followers>.from(json.decode(str).map((x) => Followers.fromJson(x)));
//
// String followersToJson(List<Followers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Followers {
//   Followers({
//     required this.login,
//     required this.id,
//     required this.nodeId,
//     required this.avatarUrl,
//     required this.gravatarId,
//     required this.url,
//     required this.htmlUrl,
//     required this.followersUrl,
//     required this.followingUrl,
//     required this.gistsUrl,
//     required this.starredUrl,
//     required this.subscriptionsUrl,
//     required this.organizationsUrl,
//     required this.reposUrl,
//     required this.eventsUrl,
//     required this.receivedEventsUrl,
//     required this.type,
//     required this.siteAdmin,
//   });
//
//   String login;
//   int id;
//   String nodeId;
//   String avatarUrl;
//   String gravatarId;
//   String url;
//   String htmlUrl;
//   String followersUrl;
//   String followingUrl;
//   String gistsUrl;
//   String starredUrl;
//   String subscriptionsUrl;
//   String organizationsUrl;
//   String reposUrl;
//   String eventsUrl;
//   String receivedEventsUrl;
//   String type;
//   bool siteAdmin;
//
//   factory Followers.fromJson(Map<String, dynamic> json) => Followers(
//     login: json["login"],
//     id: json["id"],
//     nodeId: json["node_id"],
//     avatarUrl: json["avatar_url"],
//     gravatarId: json["gravatar_id"],
//     url: json["url"],
//     htmlUrl: json["html_url"],
//     followersUrl: json["followers_url"],
//     followingUrl: json["following_url"],
//     gistsUrl: json["gists_url"],
//     starredUrl: json["starred_url"],
//     subscriptionsUrl: json["subscriptions_url"],
//     organizationsUrl: json["organizations_url"],
//     reposUrl: json["repos_url"],
//     eventsUrl: json["events_url"],
//     receivedEventsUrl: json["received_events_url"],
//     type: json["type"],
//     siteAdmin: json["site_admin"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "login": login,
//     "id": id,
//     "node_id": nodeId,
//     "avatar_url": avatarUrl,
//     "gravatar_id": gravatarId,
//     "url": url,
//     "html_url": htmlUrl,
//     "followers_url": followersUrl,
//     "following_url": followingUrl,
//     "gists_url": gistsUrl,
//     "starred_url": starredUrl,
//     "subscriptions_url": subscriptionsUrl,
//     "organizations_url": organizationsUrl,
//     "repos_url": reposUrl,
//     "events_url": eventsUrl,
//     "received_events_url": receivedEventsUrl,
//     "type": type,
//     "site_admin": siteAdmin,
//   };
// }
// To parse this JSON data, do
//
//     final followers = followersFromJson(jsonString);

import 'dart:convert';

List<Followers> followersFromJson(String str) => List<Followers>.from(json.decode(str).map((x) => Followers.fromJson(x)));

String followersToJson(List<Followers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Followers {
  Followers({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.eventsUrl,
    required this.receivedEventsUrl,
    required this.type,
    required this.siteAdmin,
  });

  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;

  factory Followers.fromJson(Map<String, dynamic> json) => Followers(
    login: json["login"],
    id: json["id"],
    nodeId: json["node_id"],
    avatarUrl: json["avatar_url"],
    gravatarId: json["gravatar_id"],
    url: json["url"],
    htmlUrl: json["html_url"],
    followersUrl: json["followers_url"],
    followingUrl: json["following_url"],
    gistsUrl: json["gists_url"],
    starredUrl: json["starred_url"],
    subscriptionsUrl: json["subscriptions_url"],
    organizationsUrl: json["organizations_url"],
    reposUrl: json["repos_url"],
    eventsUrl: json["events_url"],
    receivedEventsUrl: json["received_events_url"],
    type: json["type"],
    siteAdmin: json["site_admin"],
  );

  Map<String, dynamic> toJson() => {
    "login": login,
    "id": id,
    "node_id": nodeId,
    "avatar_url": avatarUrl,
    "gravatar_id": gravatarId,
    "url": url,
    "html_url": htmlUrl,
    "followers_url": followersUrl,
    "following_url": followingUrl,
    "gists_url": gistsUrl,
    "starred_url": starredUrl,
    "subscriptions_url": subscriptionsUrl,
    "organizations_url": organizationsUrl,
    "repos_url": reposUrl,
    "events_url": eventsUrl,
    "received_events_url": receivedEventsUrl,
    "type": type,
    "site_admin": siteAdmin,
  };
}
