import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_fm_app/src/shared/domain/image.dart' as img;
import 'package:last_fm_app/src/shared/provider/url_launcher_provider.dart';
import 'package:last_fm_app/src/shared/view/context_ext.dart';
import 'package:last_fm_app/src/shared/view/error_view.dart';
import 'package:last_fm_app/src/shared/view/loading_indicator.dart';
import 'package:last_fm_app/src/track/domain/track_details.dart';
import 'package:last_fm_app/src/track/provider/track_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class TrackDetailsPage extends ConsumerWidget {
  final String trackId;

  const TrackDetailsPage({
    @PathParam('id') required this.trackId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackAsync = ref.watch(trackProvider(trackId));
    return Scaffold(
      appBar: trackAsync.maybeWhen(
        error: (error, stackTrace) => AppBar(),
        orElse: () => null,
      ),
      body: trackAsync.when(
        data: (TrackDetails? track) {
          return track != null
              ? _TrackDetailsView(track)
              : _TrackNotFoundView(trackId: trackId);
        },
        loading: () => const Center(child: LoadingIndicator()),
        error: (error, stackTrace) => ErrorView(error),
      ),
    );
  }
}

class _TrackDetailsView extends ConsumerWidget {
  final TrackDetails track;

  const _TrackDetailsView(
    this.track, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          expandedHeight: 400.0,
          flexibleSpace: FlexibleSpaceBar(
            background: _AlbumImageView(track.album.image),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed([
              Text(
                track.album.artist,
                style: context.textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              Text(
                track.name,
                style: context.textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _TagsView(track.tags),
              const SizedBox(height: 20),
              Html(
                data: track.summary,
                onLinkTap: (url, context, att, _) => _openUrl(ref, url),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  void _openUrl(WidgetRef ref, String? url) {
    if (url == null) return;
    ref.read(urlLauncherProvider(url)).call();
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
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: image.url,
      fit: BoxFit.cover,
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
