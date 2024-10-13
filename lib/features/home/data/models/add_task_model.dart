class AddTaskModel {
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? dueDate;

  AddTaskModel({
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.dueDate,
  });

  factory AddTaskModel.fromJson(Map<String, dynamic> json) => AddTaskModel(
        image: json['image'] as String?,
        title: json['title'] as String?,
        desc: json['desc'] as String?,
        priority: json['priority'] as String?,
        dueDate: json['dueDate'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'title': title,
        'desc': desc,
        'priority': priority,
        'dueDate': dueDate,
      };
}
