import 'package:cloud_firestore/cloud_firestore.dart';

class Menus {
  String? menuID;
  String? sellerUID;
  String? menuTitle;
  String? menuInfo;
  Timestamp? pushlisedDate;
  String? thumbnailUrl;
  String? status;
  Menus({
    this.menuID,
    this.menuInfo,
    this.menuTitle,
    this.pushlisedDate,
    this.sellerUID,
    this.status,
    this.thumbnailUrl,
  });
  Menus.fromJson(Map<String, dynamic> json) {
    menuID = json['menuID'];
    sellerUID = json['sellerUID'];
    menuTitle = json['menuTitle'];
    menuInfo = json['menuInfo'];
    pushlisedDate = json['pushlisedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuID'] = this.menuID;
    data['sellerUID'] = this.sellerUID;
    data['menuTitle'] = this.menuTitle;
    data['menuInfo'] = this.menuInfo;
    data['pushlisedDate'] = this.pushlisedDate;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['status'] = this.status;
    return data;
  }
}
