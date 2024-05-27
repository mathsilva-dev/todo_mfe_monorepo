class ToDoEntity {
  final String title;
  final String description;
  final bool isCompleted;

  ToDoEntity({
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory ToDoEntity.fromMap(Map map) {
    return ToDoEntity(
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'],
    );
  }

  Map toMap() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  ToDoEntity copyWith({
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return ToDoEntity(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static ToDoEntity empty() {
    return ToDoEntity(
      title: '',
      description: '',
      isCompleted: false,
    );
  }

  bool isValidToDo() => (title.isNotEmpty && description.isNotEmpty);
}
