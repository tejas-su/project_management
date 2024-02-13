class comments {
  int? commentid;
  int? bugid;
  int? userid;
  String? comment;
  String? createdDate;

  comments(
      {this.commentid,
      this.bugid,
      this.userid,
      this.comment,
      this.createdDate});

  comments.fromJson(Map<String, dynamic> json) {
    commentid = json['commentid'];
    bugid = json['bugid'];
    userid = json['userid'];
    comment = json['comment'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentid'] = this.commentid;
    data['bugid'] = this.bugid;
    data['userid'] = this.userid;
    data['comment'] = this.comment;
    data['created_date'] = this.createdDate;
    return data;
  }
}
