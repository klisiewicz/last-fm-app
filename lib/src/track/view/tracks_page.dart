import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_fm_app/src/app/app_router.dart';
import 'package:last_fm_app/src/shared/view/context_ext.dart';
import 'package:last_fm_app/src/shared/view/error_view.dart';
import 'package:last_fm_app/src/shared/view/loading_indicator.dart';
import 'package:last_fm_app/src/track/domain/track.dart';
import 'package:last_fm_app/src/track/provider/track_provider.dart';
import 'package:last_fm_app/src/track/view/tracks_search_bar.dart';
import 'package:transparent_image/transparent_image.dart';

class TracksPage extends StatelessWidget {
  const TracksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TracksSearchBar(),
      body: _TracksReactiveView(),
    );
  }
}

class _TracksReactiveView extends ConsumerWidget {
  const _TracksReactiveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final tracksAsync = watch(tracksProvider);
    return Center(
      child: tracksAsync.when(
        data: (List<Track> tracks) {
          return tracks.isNotEmpty ? _TracksList(tracks) : const _TracksEmpty();
        },
        loading: () {
          return const LoadingIndicator();
        },
        error: (error, stackTrace) => ErrorView(error),
      ),
    );
  }
}

class _TracksList extends StatelessWidget {
  final List<Track> tracks;

  const _TracksList(
    this.tracks, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tracks.length,
      itemBuilder: (BuildContext context, int index) {
        return _TrackListItem(
          tracks[index],
          onTrackSelected: (Track track) {
            context.router.push(
              TrackDetailsRoute(trackId: '${track.id}'),
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return tracks.isNotLast(index)
            ? const _TrackDivider()
            : const SizedBox();
      },
    );
  }
}

class _TrackDivider extends StatelessWidget {
  const _TrackDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 80),
      child: Divider(height: 1),
    );
  }
}

class _TracksEmpty extends StatelessWidget {
  const _TracksEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No tracks found',
            style: context.textTheme.headline5,
          ),
          const SizedBox(height: 20),
          Icon(
            Icons.my_library_music_outlined,
            size: 64,
            color: context.theme.accentColor,
          ),
          const SizedBox(height: 20),
          Text(
            'Try using a different search query',
            style: context.textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}

extension on List<Track> {
  bool isNotLast(int index) => index != length - 1;
}

typedef TrackSelection = Function(Track track);

class _TrackListItem extends StatelessWidget {
  final Track track;
  final TrackSelection? onTrackSelected;

  const _TrackListItem(
    this.track, {
    required this.onTrackSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTrackSelected?.call(track);
      },
      child: ListTile(
        leading: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: track.image.url,
          width: 48,
        ),
        title: Text(track.name),
        subtitle: Text(track.artist.toUpperCase()),
      ),
    );
  }
}
