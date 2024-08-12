import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WriterDetailsPage extends StatefulWidget {
  final String api;
  final String saveKey;
  final String writerImage;

  const WriterDetailsPage(
      {super.key,
      required this.api,
      required this.saveKey,
      required this.writerImage});

  @override
  State<WriterDetailsPage> createState() => _WriterDetailsPageState();
}

class _WriterDetailsPageState extends State<WriterDetailsPage> {
  List<dynamic> writerData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> getData() async {
    final res = await http.get(Uri.parse(widget.api));
    if (res.statusCode == 200) {
      final decoded = json.decode(res.body);
      writerData = decoded['audiobooks'];
      await saveDataToPreferences();
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveDataToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(widget.saveKey, json.encode(writerData));
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString(widget.saveKey);
    if (savedData != null) {
      writerData = json.decode(savedData);
      setState(() {
        isLoading = false;
      });
    }
    await getData();
  }

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    await getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 331,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(widget.writerImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    if (writerData.isNotEmpty)
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Text(
                          writerData[0]['bookCreatorName'],
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.play_circle_fill,
                          color: Colors.amber,
                          size: 50,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 20),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '23 songs',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '58 minutes',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: writerData.length,
                    itemBuilder: (context, index) {
                      final writer = writerData[index];
                      return SizedBox(
                        height: 70,
                        child: ListTile(
                          leading: CachedNetworkImage(
                            width: 50,
                            height: 50,
                            imageUrl: writer['image'],
                          ),
                          title: Text(
                            writer['title'],
                            style: const TextStyle(),
                          ),
                          trailing: const Icon(
                            Icons.navigate_next,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
