class TODOModel {
  String title;
  bool isCompleate;

  TODOModel({
    required this.title,
    required this.isCompleate,
  });

  void toggleCompleted() {
    isCompleate = !isCompleate;
  }
}
