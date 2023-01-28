import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/model/product.model.dart';
import '../../link_api.dart';
import 'my_grid.view.dart';

class PostGalleryView extends StatelessWidget {
  final List<String> items;

  const PostGalleryView({Key? key, required this.items}) : super(key: key);

  onItemTap(int index) {
    Get.dialog(
      Material(
        color: Colors.transparent,
        child: FullScreenPreview(
          index: index,
          items: items,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> gridItems = [];

    int gridCount = items.length < 2 ? items.length : 2;
    for (int i = 0; i < gridCount; i++) {
      Widget image = Image.network(
        items[i],
        headers: Applink.imageHeaders,
        fit: BoxFit.fill,
        width: (MediaQuery.of(context).size.width - 24) / 2,
        // ),
      );
      if (i == gridCount - 1 && i != items.length - 1) {
        gridItems.add(
          InkWell(
            onTap: () => onItemTap(i),
            child: Stack(
              children: [
                image,
                Positioned.fill(
                  child: Container(color: Colors.black.withOpacity(0.5)),
                ),
                Positioned.fill(
                  top: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      '+${items.length - gridCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        gridItems.add(
          InkWell(
            onTap: () => onItemTap(i),
            child: image,
          ),
        );
      }
    }
    // }
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: MyGridView(
        items: gridItems,
      ),
    );
  }
}

class FullScreenPreview extends StatefulWidget {
  final int index;
  final List<String> items;

  const FullScreenPreview({
    Key? key,
    required this.index,
    required this.items,
  }) : super(key: key);

  @override
  State<FullScreenPreview> createState() => _FullScreenPreviewState();
}

class _FullScreenPreviewState extends State<FullScreenPreview> {
  late PageController pageController;

  int currentImageIndex = 1;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.index);
    currentImageIndex = widget.index + 1;
    pageController.addListener(() {
      setState(() {
        currentImageIndex = (pageController.page ?? 0).round() + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Flex(
          direction: Axis.vertical,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close,
                          color: Color.fromARGB(255, 15, 13, 13)),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: PageView(
                  controller: pageController,
                  children: widget.items
                      .map((image) => Image.network(
                            image,
                            headers: Applink.imageHeaders,
                          ))
                      .toList(),
                ),
              ),
            ),
            Text(
              'Image $currentImageIndex/${widget.items.length}',
              style: const TextStyle(
                color: Color.fromARGB(255, 14, 13, 13),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
