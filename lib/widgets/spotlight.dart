import 'dart:math';

import 'package:clean_flutter/widgets/app_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Spotlight extends StatefulWidget {
  const Spotlight({
    Key? key,
    required this.imageUrl,
    required this.heroTag,
    required this.builder,
    this.placeholderBuilder,
    this.width,
    this.height,
  }) : super(key: key);

  final String imageUrl;
  final String heroTag;
  final WidgetBuilder builder;
  final WidgetBuilder? placeholderBuilder;
  final double? width;
  final double? height;

  @override
  State<Spotlight> createState() => _SpotlightState();
}

class _SpotlightState extends State<Spotlight> {
  String? _rawSvg;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _loadFileFromCache();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (_rawSvg != null) {
      return Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            height: size.height,
            width: size.width,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(48),
                ),
              ),
              child: SizedBox(),
            ),
          ),
          Positioned.fill(
            top: size.width / 1.5,
            child: widget.builder(context),
          ),
          Positioned(
            top: 0,
            height: size.width * 1.2,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Hero(
                  tag: widget.heroTag,
                  child: SvgPicture.string(
                    _rawSvg!,
                    placeholderBuilder: widget.placeholderBuilder,
                    height: widget.height,
                    width: widget.width,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return SizedBox(height: widget.height, width: widget.width);
  }

  Future<void> _loadFileFromCache() async {
    final cacheManager = AppScope.cacheManagerOf(context);
    final file = await cacheManager.getSingleFile(widget.imageUrl);

    _rawSvg = await file.readAsString();
    if (mounted) setState(() {});
  }
}
