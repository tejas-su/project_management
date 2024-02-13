class bugs {
  int? bugid;
  String? bugTitle;
  String? bugDes;
  int? projectId;
  String? createdDate;
  String? updatedDate;
  String? bugStatus;

  bugs(
      {this.bugid,
      this.bugTitle,
      this.bugDes,
      this.projectId,
      this.createdDate,
      this.updatedDate,
      this.bugStatus});

  bugs.fromJson(Map<String, dynamic> json) {
    bugid = json['bugid'];
    bugTitle = json['bug_title'];
    bugDes = json['bug_des'];
    projectId = json['project_id'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    bugStatus = json['bug_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bugid'] = this.bugid;
    data['bug_title'] = this.bugTitle;
    data['bug_des'] = this.bugDes;
    data['project_id'] = this.projectId;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['bug_status'] = this.bugStatus;
    return data;
  }
}
