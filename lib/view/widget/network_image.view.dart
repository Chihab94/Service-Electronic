import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:service_electronic/link_api.dart';
import 'package:shimmer/shimmer.dart';
import 'package:storage_database/storage_explorer/explorer_file.dart';
import 'package:storage_database/storage_explorer/explorer_network_files.dart';

import '../../core/services/main.service.dart';

class NetworkImageView extends StatefulWidget {
  final String url;
  final double? width, height, borderRadius;
  final EdgeInsets? margin, padding;
  final BoxFit fit;
  final Map<String, String> headers;
  final Color baseColor, highlightColor, errorIconColor, backgroundColor;
  final Color? borderColor;
  final bool setItInDecoration, refresh;

  const NetworkImageView({
    Key? key,
    required this.url,
    this.headers = const {},
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.baseColor = const Color.fromARGB(255, 168, 168, 168),
    this.highlightColor = const Color.fromARGB(255, 236, 236, 236),
    this.errorIconColor = const Color.fromARGB(255, 236, 236, 236),
    this.backgroundColor = Colors.transparent,
    this.borderColor,
    this.margin,
    this.padding,
    this.setItInDecoration = true,
    this.refresh = false,
  }) : super(key: key);

  @override
  createState() => _NetworkImageViewState();
}

class _NetworkImageViewState extends State<NetworkImageView> {
  ExplorerNetworkFiles get networkFiles =>
      Get.find<MainService>().storageDatabase.explorer!.networkFiles!;

  // Future<File?> getImage() async => (await networkFiles.file(
  //     widget.url,
  //     headers: widget.headers,
  //     refresh: widget.refresh,
  //   ))
  //       !.ioFile;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExplorerFile?>(
      future: networkFiles.file(
      widget.url,
      headers: widget.headers,
      refresh: widget.refresh,
    ),
      builder: (context, snapshot) => Container(
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        padding: widget.padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? 0,
          ),
          color: widget.backgroundColor,
          border: widget.borderColor != null
              ? Border.all(color: widget.borderColor!)
              : null,
          image: widget.setItInDecoration && snapshot.hasData
              ? DecorationImage(
                  image: FileImage(snapshot.data!.ioFile), fit: widget.fit)
              : null,
        ),
        child: snapshot.connectionState == ConnectionState.waiting
            ? Shimmer.fromColors(
                baseColor: widget.baseColor,
                highlightColor: widget.highlightColor,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? 0,
                    ),
                    color: Colors.grey,
                  ),
                ),
              )
            : !widget.setItInDecoration && snapshot.hasData
                ? Image.file(snapshot.data!.ioFile)
                : widget.setItInDecoration && !snapshot.hasData
                    ? Icon(
                        Icons.broken_image,
                        color: widget.errorIconColor,
                        size: widget.width != null || widget.height != null
                            ? min(widget.width ?? 9e9, widget.height ?? 9e9) *
                                0.6
                            : 50,
                      )
                    : null,
      ),
    );
  }
}

// class NetworkImageView extends ExplorerNetworkImage {
//   NetworkImageView({
//     super.key,
//     required super.url,
//     super.width,
//     super.height,
//     super.borderRadius,
//     super.margin,
//     super.padding,
//     super.fit,
//     super.headers,
//     super.refresh,
//     super.getOldOnError,
//     super.log,
//     super.baseColor,
//     super.highlightColor,
//     super.errorIconColor,
//     super.backgroundColor,
//     super.borderColor,
//     super.setItInDecoration,
//   }) : super(
//           explorerNetworkFiles:
//               Get.find<MainService>().storageDatabase.explorer!.networkFiles!,
//         );
// }
