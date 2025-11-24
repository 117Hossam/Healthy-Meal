class Meal {
  String _name;
  String _description;
  List<String> _ingredients;
  List<String> _steps;

  Meal(this._name, this._description, this._ingredients, this._steps);

  String get name => _name;
  String get description => _description;
  List<String> get ingredients => _ingredients;
  List<String> get steps => _steps;


  @override
  String toString() {
    return _name;
  }
}
