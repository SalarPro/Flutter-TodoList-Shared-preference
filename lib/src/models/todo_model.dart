import 'dart:convert';

class Todo {
  String? id;
  String? title;
  String? body;
  DateTime? addDate;
  DateTime? dueDate;
  String? type;
  Todo({
    this.id,
    this.title,
    this.body,
    this.addDate,
    this.dueDate,
    this.type,
  });
  

  Todo copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? addDate,
    DateTime? dueDate,
    String? type,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      addDate: addDate ?? this.addDate,
      dueDate: dueDate ?? this.dueDate,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'addDate': addDate?.millisecondsSinceEpoch,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'type': type,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      addDate: map['addDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['addDate']) : null,
      dueDate: map['dueDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dueDate']) : null,
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, body: $body, addDate: $addDate, dueDate: $dueDate, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Todo &&
      other.id == id &&
      other.title == title &&
      other.body == body &&
      other.addDate == addDate &&
      other.dueDate == dueDate &&
      other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      body.hashCode ^
      addDate.hashCode ^
      dueDate.hashCode ^
      type.hashCode;
  }
}
