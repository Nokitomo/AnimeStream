import 'package:animestream/helper/api.dart';
import 'package:animestream/ui/widgets/details_content.dart';
import 'package:flutter/material.dart';
import 'package:animestream/ui/widgets/player.dart';
import 'package:get/get.dart';

import 'package:animestream/helper/classes/anime_obj.dart';

import 'package:animestream/services/internal_db.dart';
import 'package:animestream/helper/models/anime_model.dart';

class EpisodePlayer extends StatefulWidget {
  final AnimeClass anime;

  final Widget child;
  final int? index;

  final LoadingThings controller;
  final ResumeController resumeController;

  final int? borderRadius;
  final double height;

  final bool resume;

  const EpisodePlayer({
    super.key,
    required this.child,
    required this.anime,
    this.index,
    required this.controller,
    required this.resumeController,
    this.borderRadius,
    this.height = 63,
    this.resume = false,
  });

  @override
  State<EpisodePlayer> createState() => _EpisodePlayerState();
}

class _EpisodePlayerState extends State<EpisodePlayer> {
  late AnimeClass anime;
  late int index;

  @override
  void initState() {
    anime = widget.anime;
    index = widget.index ?? 0;

    super.initState();
  }

  void setError(bool value) {
    widget.controller.setError(value);
  }

  void setLoading(bool value) {
    widget.controller.setLoading(value);
  }

  void openPlayer(String link) async {
    await Get.to(
      () => PlayerPage(
        url: link,
        colorScheme: Theme.of(Get.context!).colorScheme,
        animeId: anime.id,
        episodeId: anime.episodes[index]['id'],
        anime: anime,
      ),
    );

    widget.controller.updateProgress();
    widget.resumeController.updateIndex();
  }

  void trackProgress() {
    var animeModel = fetchAnimeModel(anime);
    animeModel.lastSeenDate = DateTime.now();
    animeModel.lastSeenEpisodeIndex = index;

    Get.find<ObjectBox>().store.box<AnimeModel>().put(animeModel);
    widget.resumeController.updateIndex();
  }

  Future<void> handleClick() async {
    if (anime.episodes.isEmpty) {
      setError(true);
      return;
    }

    if (widget.resume) {
      index = widget.resumeController.index.value % (anime.episodes.length);
    }

    trackProgress();

    setLoading(true);
    setError(false);

    try {
      final episodeId = anime.episodes[index]['id'];
      final link = await fetchEpisodeStreamUrl(episodeId);
      openPlayer(link);
    } catch (e) {
      setError(true);
    } finally {
      setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.bottomLeft,
      children: [
        InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(
            widget.borderRadius?.toDouble() ?? 0,
          ),
          onTap: () {
            handleClick();
          },
          child: widget.child,
        ),
      ],
    );
  }
}
