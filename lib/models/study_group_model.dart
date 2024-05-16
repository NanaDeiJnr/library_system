class StudyGroup{
  final String name;
  final List<String> members;

  StudyGroup({required this.name, required this.members});

  Map<String, dynamic> toJson(){
    return {
      'name':name,
      'members': members
    };
  }

}