class users {
  int? userid;
  String? username;
  String? email;
  int? projectid;
  int? teamId;
  String? userDesignation;

  users(
      {this.userid,
      this.username,
      this.email,
      this.projectid,
      this.teamId,
      this.userDesignation});

  users.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['user_name'];
    email = json['email'];
    projectid = json['projectid'];
    teamId = json['team_id'];
    userDesignation = json['user_designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['username'] = this.username;
    data['email'] = this.email;
    data['projectid'] = this.projectid;
    data['team_id'] = this.teamId;
    data['user_designation'] = this.userDesignation;
    return data;
  }
}
