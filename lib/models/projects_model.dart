class projects {
  int? projectid;
  String? projectName;
  String? projectDes;
  String? dateCreated;

  projects(
      {this.projectid, this.projectName, this.projectDes, this.dateCreated});

  projects.fromJson(Map<String, dynamic> json) {
    projectid = json['projectid'];
    projectName = json['project_name'];
    projectDes = json['project_des'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectid'] = this.projectid;
    data['project_name'] = this.projectName;
    data['project_des'] = this.projectDes;
    data['date_created'] = this.dateCreated;
    return data;
  }
}
