class comment {
  int? id;
  String? bugName;
  String? userName;
  String? projectName;
  String? commentDescription;
  String? createdDate;

  comment(
      {this.id,
      this.bugName,
      this.userName,
      this.projectName,
      this.commentDescription,
      this.createdDate});

  comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bugName = json['bug_name'];
    userName = json['user_name'];
    projectName = json['project_name'];
    commentDescription = json['comment_description'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bug_name'] = this.bugName;
    data['user_name'] = this.userName;
    data['project_name'] = this.projectName;
    data['comment_description'] = this.commentDescription;
    data['created_date'] = this.createdDate;
    return data;
  }
}
