class EditTaskModel {
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? status;
  String? user;

  EditTaskModel({
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.status,
    this.user,
  });

  factory EditTaskModel.fromJson(Map<String, dynamic> json) => EditTaskModel(
        image: json['image'] as String?,
        title: json['title'] as String?,
        desc: json['desc'] as String?,
        priority: json['priority'] as String?,
        status: json['status'] as String?,
        user: json['user'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'title': title,
        'desc': desc,
        'priority': priority,
        'status': status,
        'user': user,
      };
}
