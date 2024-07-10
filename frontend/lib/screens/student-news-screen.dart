import 'package:flutter/material.dart';
import 'package:frontend/objects/News.dart';

class StudentNewsScreen extends StatefulWidget {
  final List<News> list;

  StudentNewsScreen({super.key, required this.list});

  @override
  State<StudentNewsScreen> createState() => _StudentNewsScreenState();
}

class _StudentNewsScreenState extends State<StudentNewsScreen> {
  String? selectedTag;
  late List<String> tags = [];

  @override
  void initState() {
    super.initState();
    // Extract unique tags from the news list
    tags = widget.list.map((news) => news.tag).toSet().toList();
    // Optional: Set the initial selected tag to the first tag
    if (tags.isNotEmpty) {
      selectedTag = tags[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter news list based on the selected tag
    List<News> filteredNews = selectedTag == null
        ? widget.list
        : widget.list.where((news) => news.tag == selectedTag).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 70,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tags.map((tag) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedTag = tag;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedTag == tag
                          ? Colors.blue
                          : Colors.indigo,
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredNews.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade200,
                      Colors.indigo.shade200,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filteredNews[index].title,
                        style: TextStyle(
                          fontSize:23,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        filteredNews[index].context,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
