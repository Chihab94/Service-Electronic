import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePreview extends StatelessWidget {
  final File image;

  File get imageFile => File(image.path);

  const ImagePreview({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('preivew image ')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              child: Image.file(File(image.path)),
            ),
            SizedBox(height: 20),
            Text(
              imageFile.path.split('/').last,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${(imageFile.lengthSync() / 1024).toStringAsFixed(2)} KB',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
