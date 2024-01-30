class TODO {
    String? id;
    String? todoText;
    bool isDone;

  TODO({
    required this.id,
    required this.todoText,
    this.isDone = false
  });

  static List<TODO> todoList() {
    return [];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todoText': todoText,
      'isDone': isDone,
    };
  }

  factory TODO.fromMap(Map<String, dynamic> map) {
    return TODO(
      id: map['id'],
      todoText: map['todoText'],
      isDone: map['isDone'] ?? false,
    );
  }
}

