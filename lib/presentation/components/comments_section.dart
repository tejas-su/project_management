import 'package:flutter/material.dart';
import '../themes/themes.dart';
import '../widgets/text_field.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const InputTextField(
        hintText: 'Write your message here.....',
        left: 5,
        right: 5,
        bottom: 5,
        color: whiteContainer,
        suffixIcon: IconButton(onPressed: null, icon: Icon(Icons.send_rounded)),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => const ListTile(
            title: Text('Hey we have a problem here 👀'),
            trailing: Icon(
              Icons.edit_rounded,
              size: 20,
              color: black,
            )),
        itemCount: 1,
      ),
    );
  }
}
