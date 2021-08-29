import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_fm_app/src/shared/view/error_view.dart';
import 'package:last_fm_app/src/track/domain/track.dart';
import 'package:last_fm_app/src/track/provider/track_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class TracksPage extends StatelessWidget {
  const TracksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LastFM'),
      ),
      body: const _TracksReactiveView(),
    );
  }
}

class _TracksReactiveView extends ConsumerWidget {
  const _TracksReactiveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final tracksAsync = watch(tracksProvider(''));
    return Center(
      child: tracksAsync.when(
        data: (List<Track> tracks) => _TracksList(tracks),
        loading: () => const CircularProgressIndicator.adaptive(),
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
    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (BuildContext context, int index) {
        return _TrackListItem(tracks[index]);
      },
    );
  }
}

class _TrackListItem extends StatelessWidget {
  final Track track;

  const _TrackListItem(
    this.track, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: track.image.url,
      ),
      title: Text(track.name),
      subtitle: Text(track.artist.toUpperCase()),
    );
  }
}
