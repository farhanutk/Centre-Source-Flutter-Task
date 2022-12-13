import 'package:centre_source_flutter_task/providers/images_provider.dart';
import 'package:centre_source_flutter_task/screens/image_fullscreen.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController _searchInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            LazyLoadScrollView(
              onEndOfPage: () {
                context.read<ImagesProvider>().fetchImages(
                    _searchInputController.text,
                    isNewSearch: false);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  context.watch<ImagesProvider>().images.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount:
                                context.watch<ImagesProvider>().images.length,
                            itemBuilder: (context, index) {
                              final String imageUrl = context
                                  .watch<ImagesProvider>()
                                  .images[index]["largeImageURL"];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 3),
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => ImageFullscreen(
                                      imageUrl: imageUrl,
                                      tag: 'image$index',
                                    ),
                                  )),
                                  child: Hero(
                                    tag: 'image$index',
                                    child: Image.network(
                                      imageUrl,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Container(
                                          color: Colors.grey[400],
                                          height: 300,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : context.watch<ImagesProvider>().isLoading
                          ? const SizedBox.shrink()
                          : const Center(
                              child: Text(
                                'Search any image you want above...',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                  context.watch<ImagesProvider>().isLoading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              color: const Color.fromRGBO(255, 255, 255, 0.95),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchInputController,
                      decoration: const InputDecoration(
                          labelText: 'Search',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 7)),
                      onSubmitted: (searchQuery) {
                        context
                            .read<ImagesProvider>()
                            .fetchImages(searchQuery, isNewSearch: true);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        if (_searchInputController.text.isNotEmpty) {
                          FocusScope.of(context).unfocus();
                          context.read<ImagesProvider>().fetchImages(
                              _searchInputController.text,
                              isNewSearch: true);
                        }
                      },
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.blue,
                        size: 30,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
