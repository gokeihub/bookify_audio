import 'package:flutter/material.dart';
import '../../../firebase/database.dart';
import '../widgets/setting_field_button_widget.dart';
import '../widgets/setting_field_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class MissingStory extends StatefulWidget {
  const MissingStory({super.key});

  @override
  State<MissingStory> createState() => _MissingStoryState();
}

class _MissingStoryState extends State<MissingStory> {
  final TextEditingController appsAdd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'প্রিয় ব্যবহারকারী,আমাদের অ্যাপটি নতুন, তাই আপনার পছন্দের গল্পগুলো এখনো নাও থাকতে পারে। অনুগ্রহ করে আপনার প্রিয় গল্পগুলোর নাম জানিয়ে আমাদের সহযোগিতা করুন।',
              style: GoogleFonts.acme(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SettingFieldWidget(
              hintText: 'Adds Missing App Name only',
              textEditingController: appsAdd,
            ),
            const SizedBox(height: 15),
            SettingFieldButtonWidget(
              buttonText: 'Add',
              onTap: () async {
                Map<String, dynamic> addQuiz = {
                  'Story': appsAdd.text,
                };
                await DataBaseMethods()
                    .addQuizCategory(addQuiz, 'Missing')
                    .then(
                  (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Upload Complate'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                );
                setState(() {
                  appsAdd.text = '';
                });
              },
            )
          ],
        ),
      ),
    );
  }
}