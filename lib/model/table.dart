class TableModel {
  String? tableUID;
  String? tableName;
  String? tableAvatarUrl;
  String? tableEmail;
  TableModel(
      {this.tableUID, this.tableName, this.tableAvatarUrl, this.tableEmail});
  TableModel.fromJson(Map<String, dynamic> json) {
    tableUID = json['tableUID'];
    tableName = json['tableName'];
    tableAvatarUrl = json['tableAvatarUrl'];
    tableEmail = json['tableEmail'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tableUID'] = this.tableUID;
    data['tableName'] = this.tableName;
    data['tableAvatarUrl'] = this.tableAvatarUrl;
    data['tableEmail'] = this.tableEmail;
    return data;
  }
}
