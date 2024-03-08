import 'dart:math';

import 'package:flutter/material.dart';
import '../themes/themes.dart';
import '../widgets/text_field.dart';

class CommentsSection extends StatefulWidget {
  const CommentsSection({super.key});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = [];

  void _handleSubmitted(String message) {
    setState(() {
      _messages.add(message);
      _textController.clear();
    });
  }

  //user images
  List images = [
    "assets/avatars/man (1).png",
    "assets/avatars/man (2).png",
    "assets/avatars/man (3).png",
    "assets/avatars/man (4).png",
    "assets/avatars/man (5).png",
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width - 80,
      height: height,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                        foregroundImage:
                            AssetImage(images[Random().nextInt(5)])),
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    focusColor: whiteContainer,
                    hoverColor: whiteContainer,
                    autofocus: true,
                    tileColor: whiteContainer,
                    selectedColor: black,
                    selectedTileColor: whiteContainer,
                    title: Text(_messages[index], softWrap: true),
                  ),
                );
              },
            ),
          ),
          _buildMessageInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageInputField() {
    return InputTextField(
      left: 5,
      right: 5,
      bottom: 10,
      color: whiteContainer,
      hintText: 'Type Something here',
      controller: _textController,
      obscureText: false,
      onSubmitted: (p0) => _handleSubmitted(_textController.text),
      suffixIcon: IconButton(
          onPressed: () => _handleSubmitted(_textController.text),
          icon: const Icon(Icons.send_rounded)),
    );
  }
}
