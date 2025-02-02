import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  List<Map<String, dynamic>> personList = [];
  bool isLoading = true;
  Map<String, dynamic>? selectedPerson;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> getData() async {
    try {
      final res = await http.get(
        Uri.parse('https://gokeihub.github.io/bookify_api/person_api.json'),
      );
      if (res.statusCode == 200) {
        final decoded = json.decode(res.body);
        if (mounted) {
          setState(() {
            personList = List<Map<String, dynamic>>.from(decoded['personInfo']);
            isLoading = false;
            selectedPerson = personList.isNotEmpty ? personList[0] : null;
          });
        }
        await saveDataToPreferences();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> saveDataToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('personSave', json.encode(personList));
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('personSave');
    if (savedData != null && mounted) {
      setState(() {
        personList = List<Map<String, dynamic>>.from(json.decode(savedData));
        selectedPerson = personList.isNotEmpty ? personList[0] : null;
        isLoading = false;
      });
    }
    await getData();
  }

  Future<void> refreshData() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    await getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: personList.length,
                    itemBuilder: (context, index) {
                      final person = personList[index];
                      return GestureDetector(
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              selectedPerson = person;
                            });
                          }
                        },
                        child: SizedBox(
                          height: 55,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: AutoSizeText(
                                  person['personName'] ?? '',
                                  minFontSize: 5,
                                  maxLines: 1,
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                VerticalDivider(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                selectedPerson != null
                    ? Expanded(
                        child: PersonInfoPage(
                          personImage: selectedPerson!['personImage'] ?? '',
                          personName: selectedPerson!['personName'] ?? '',
                          personBirth: selectedPerson!['personBirth'] ?? '',
                          personDeath: selectedPerson!['personDeath'] ?? '',
                          personBio: selectedPerson!['personBio'] ?? '',
                          personBook: selectedPerson!['personBook'] ?? '',
                          personWiki: selectedPerson!['personWiki'],
                        ),
                      )
                    : const Expanded(
                        child: Center(
                          child: Text('No person selected'),
                        ),
                      ),
              ],
            ),
    );
  }
}

class PersonInfoPage extends StatelessWidget {
  final String personImage;
  final String personName;
  final String personBirth;
  final String personDeath;
  final String personBio;
  final String personBook;
  final String? personWiki;

  const PersonInfoPage({
    super.key,
    required this.personImage,
    required this.personName,
    required this.personBirth,
    required this.personDeath,
    required this.personBio,
    required this.personBook,
    this.personWiki,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: CachedNetworkImageProvider(personImage),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: AutoSizeText(
                personName,
                minFontSize: 20,
                maxLines: 1,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'জন্ম তারিখ:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(personBirth),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'মৃত্যুর তারিখ:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(personDeath.isEmpty ? 'জীবিত' : personDeath),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'জীবনী:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              personBio,
              style: const TextStyle(height: 1.5),
            ),
            const SizedBox(height: 24),
            const Text(
              'বিখ্যাত বই',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              personBook,
              style: const TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}