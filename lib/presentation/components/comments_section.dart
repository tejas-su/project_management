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
                    leading: const Icon(Icons.send_rounded),
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





/*

Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                _handleSubmitted(_textController.text);
              }
            },
          ),
        ],
      ),
    );


ListView.builder(
            itemBuilder: (context, index) => const ListTile(
                title: Text('Hey we have a problem here 👀'),
                trailing: Icon(
                  Icons.edit_rounded,
                  size: 20,
                  color: black,
                )),
            itemCount: 1,
          ),


*/
