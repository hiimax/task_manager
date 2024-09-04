class NotificationModel {
  int? id;
  String? date,description,title, type;
  


  // Constructor with optional 'id' parameter
  NotificationModel(this.title, this.description, this.date, this.type,
       this.id);

  // columns in the database.
  NotificationModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    date = map['date'];
    type = map['type'];
   
  }

// Method to convert a 'NotificationModel' to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'type': type,
      
    };
  }
}
