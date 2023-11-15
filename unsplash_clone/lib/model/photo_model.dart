class PhotoModel {
  String? id;
  String? created_at;
  String? color;
  Map<String, dynamic>? urls;
  Map<String, dynamic>? links;

  /*

  Map<String, dynamic>? get links => this._links == null ? null : this._links;

  Map<String, dynamic>? get urls => this._urls == null ? null : this._urls;

  String? get id => this._id == null ? null : this._id;
  String? get color => this._color == null ? null : this._color;
  String? get createdAt => this._createdAt == null ? null : this._createdAt;
  */

  PhotoModel.fromJson(Map<String, dynamic> map) {
    this.id = map['id'];
    this.created_at = map['created_at'];
    this.color = map['color'];
    this.urls = map['urls'];
    this.links = map['links'];
  }
}
