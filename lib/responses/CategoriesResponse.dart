/// genres : [{"id":28,"name":"Action"},{"id":12,"name":"Adventure"},{"id":16,"name":"Animation"},{"id":35,"name":"Comedy"},{"id":80,"name":"Crime"},{"id":99,"name":"Documentary"},{"id":18,"name":"Drama"},{"id":10751,"name":"Family"},{"id":14,"name":"Fantasy"},{"id":36,"name":"History"},{"id":27,"name":"Horror"},{"id":10402,"name":"Music"},{"id":9648,"name":"Mystery"},{"id":10749,"name":"Romance"},{"id":878,"name":"Science Fiction"},{"id":10770,"name":"TV Movie"},{"id":53,"name":"Thriller"},{"id":10752,"name":"War"},{"id":37,"name":"Western"}]

class CategoriesResponse {
  CategoriesResponse({
    this.genres,
    this.status_code,
    this.status_message,
    this.success,
  });

  CategoriesResponse.fromJson(dynamic json) {
    status_code = json['status_code'];
    status_message = json['status_message'];
    success = json['success'];

    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres?.add(Genres.fromJson(v));
      });
    }
  }

  List<Genres>? genres;
  int? status_code;
  String? status_message;
  bool? success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (genres != null) {
      map['genres'] = genres?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 28
/// name : "Action"

class Genres {
  Genres({
    this.id,
    this.name,
    // this.status_code,
    // this.status_message,
    //   this.success,
  });

  Genres.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    // status_code = json['status_code'] ;
    // status_message = json['status_message'] ;
    // success = json['success'] ;
  }

  int? id;
  String? name;

  // int? status_code;
  // String? status_message;
  // bool? success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;

    return map;
  }
}

///"status_code": 7,
//     "status_message": "Invalid API key: You must be granted a valid key.",
//     "success": false
