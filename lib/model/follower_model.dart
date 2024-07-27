class FollowModel {
  String? userId;
  String? follow;
  bool? enableCall;

  FollowModel({this.userId, this.follow, this.enableCall});

  FollowModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    follow = json['follow'];
    enableCall = json['enableCall'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['follow'] = this.follow;
    data['enableCall'] = this.enableCall;
    return data;
  }
}
