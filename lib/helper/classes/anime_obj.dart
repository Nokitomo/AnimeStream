import 'package:animestream/helper/models/anime_model.dart';

class AnimeClass {
  String title;
  String imageUrl;
  int id;
  String description;
  List episodes;
  String status;
  List genres;
  int episodesCount;
  String slug;

  DateTime? lastSeen;

  AnimeClass({
    required this.title,
    required this.imageUrl,
    required this.id,
    required this.description,
    required this.episodes,
    required this.status,
    required this.genres,
    required this.episodesCount,
    required this.slug,
    this.lastSeen,
  });

  AnimeModel getModel() {
    AnimeModel obj = AnimeModel();

    obj.title = title;
    obj.imageUrl = imageUrl;
    obj.id = id;
    obj.lastSeenDate = DateTime.now();

    return obj;
  }

  get toModel => getModel();
}

AnimeClass searchToObj(dynamic json) {
  final episodes = json['episodes'];
  final genres = json['genres'];
  return AnimeClass(
      title: json['title'] ?? json['title_eng'] ?? json['title_it'] ?? '',
      imageUrl: json['imageurl'] ?? '',
      id: json['id'] ?? 0,
      description: (json['plot'] ?? '').toString(), //archivio
      episodes: episodes is List ? episodes : [],
      status: json['status'] ?? '',
      genres: genres is List ? genres : [],
      episodesCount: json['episodes_count'] ?? 0,
      slug: json['slug'] ?? '');
}

AnimeClass popularToObj(dynamic json) {
  return AnimeClass(
      title: json['title'] ?? json['title_eng'] ?? json['title_it'] ?? '',
      imageUrl: json['imageurl'] ?? '',
      id: json['id'] ?? 0,
      description: (json['plot'] ?? '').toString(), //popolari
      episodes: [],
      status: json['status'] ?? '',
      genres: [],
      episodesCount: json['episodes_count'] ?? 0,
      slug: json['slug'] ?? '');
}

AnimeClass latestToObj(dynamic json) {
  return AnimeClass(
      title: json["anime"]['title'] ?? json["anime"]['title_eng'] ?? json["anime"]['title_it'] ?? '',
      imageUrl: json["anime"]['imageurl'] ?? '',
      id: json['anime']['id'] ?? 0,
      description: (json["anime"]['plot'] ?? '').toString(), //ultimi usciti
      episodes: [],
      status: json["anime"]['status'] ?? '',
      genres: [],
      episodesCount: json["anime"]['episodes_count'] ?? 0,
      slug: json["anime"]['slug'] ?? '');
}

AnimeClass modelToObj(AnimeModel model) {
  return AnimeClass(
    title: model.title ?? '',
    imageUrl: model.imageUrl ?? '',
    id: model.id ?? 0,
    description: '',
    episodes: [],
    status: '',
    genres: [],
    episodesCount: 0,
    slug: '',
    lastSeen: model.lastSeenDate,
  );
}
