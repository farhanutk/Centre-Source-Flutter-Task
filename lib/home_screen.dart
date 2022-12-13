import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController _searchInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Image.network(
                  'https://cdn.pixabay.com/photo/2022/11/14/13/39/brown-bear-7591629_960_720.jpg'),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
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
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {},
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
