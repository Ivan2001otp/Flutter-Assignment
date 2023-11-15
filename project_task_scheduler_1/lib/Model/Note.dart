class Note {
  int _id = 0;
  String _title = "";
  String _description = "";
  String _date = "";
  int _priority = 0;
  /*optional*/
  Note(this._title, this._date, this._priority, [this._description = ""]);

  Note.withId(this._id, this._title, this._date, this._priority,
      [this._description = ""]);

  //getters;
  int get id => _id;
  String get title => _title;
  int get priority => _priority;
  String get description => _description;
  String get date => _date;

  //setters
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length < 100) {
      this._description = newDescription;
    }
  }

  set date(String new_date) {
    this._date = new_date;
  }

  set priority(int newPriority) {
    this._priority = newPriority;
  }

  //note object to map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  //map to object of note
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }
}
