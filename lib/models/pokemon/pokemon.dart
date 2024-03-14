class Pokemon {
  String? name;
  String? url;
  String? id;
  Pokemon({this.id, this.name, this.url});

  Pokemon.fromJson(Map<String, dynamic> json) {
    final paths = json['url'].toString().split('/');
    name = json['name'];
    url = json['url'];
    id = paths[paths.length - 2].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['id'] = id;
    return data;
  }
}
