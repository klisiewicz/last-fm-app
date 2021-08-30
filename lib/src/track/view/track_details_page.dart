import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_fm_app/src/shared/domain/image.dart' as img;
import 'package:last_fm_app/src/shared/view/context_ext.dart';
import 'package:last_fm_app/src/shared/view/error_view.dart';
import 'package:last_fm_app/src/shared/view/loading_indicator.dart';
import 'package:last_fm_app/src/track/domain/track_details.dart';
import 'package:last_fm_app/src/track/provider/track_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class TrackDetailsPage extends StatelessWidget {
  final String trackId;

  const TrackDetailsPage({
    @PathParam('id') required this.trackId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 4,
              top: 4,
              child: BackButton(
                onPressed: context.router.pop,
              ),
            ),
            _TrackDetailsReactiveView(trackId: trackId),
          ],
        ),
      ),
    );
  }
}

class _TrackDetailsReactiveView extends ConsumerWidget {
  final String trackId;

  const _TrackDetailsReactiveView({
    required this.trackId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final trackAsync = watch(trackProvider(trackId));
    return trackAsync.when(
      data: (TrackDetails? track) {
        return track != null
            ? _TrackDetailsView(track)
            : _TrackNotFoundView(trackId: trackId);
      },
      loading: () => const LoadingIndicator(),
      error: (error, stackTrace) => ErrorView(error),
    );
  }
}

class _TrackDetailsView extends StatelessWidget {
  final TrackDetails track;

  const _TrackDetailsView(
    this.track, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _AlbumImageView(track.album.image),
          const SizedBox(height: 20),
          Text(track.album.artist, style: context.textTheme.headline4),
          Text(track.name, style: context.textTheme.headline5),
          const SizedBox(height: 20),
          _TagsView(track.tags),
        ],
      ),
    );
  }
}

class _AlbumImageView extends StatelessWidget {
  final img.Image image;

  const _AlbumImageView(
    this.image, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: image.url,
      ),
    );
  }
}

class _TagsView extends StatelessWidget {
  final List<String> tags;

  const _TagsView(this.tags, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) => _TagView(tag)).toList(),
    );
  }
}

class _TagView extends StatelessWidget {
  final String tag;

  const _TagView(
    this.tag, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      label: Text(tag),
    );
  }
}

class _TrackNotFoundView extends StatelessWidget {
  final String trackId;

  const _TrackNotFoundView({
    required this.trackId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorView('The track with id "$trackId" was not found.');
  }
}
