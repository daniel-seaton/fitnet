class Exercise {
  String name;
  List<String> tags;

  Exercise.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    List<String> mappedTags = [];
    map['tags'].forEach((tag) => mappedTags.add(tag.toString()));
    tags = mappedTags;
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'tags': tags};
  }
}
