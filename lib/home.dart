import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Gemini gemini = Gemini.instance;

  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: 'User');
  ChatUser geminiUser = ChatUser(id: "1", firstName: "Gemini",profileImage: "https://media.aidigitalx.com/2023/12/Googles-Gemini-AI-1200x675.webp");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)) ,
        title: const Text("Gemini AI",
          style: TextStyle(
              fontWeight: FontWeight.bold,
          color: Colors.blue),),
        centerTitle: true,
      ),
      body: buildUi(),
    );
  }

  Widget buildUi() {
    return DashChat(
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      String question = chatMessage.text;

      gemini.streamGenerateContent(question).listen((event) {

        String response = event.content?.parts?.fold<String>("", (previous, current) {
          if (current is TextPart) {
            return "$previous ${current.text}";
          }
          if (current is String) {
            return "$previous $current";
          }
          return previous;
        }) ??
            "";

        ChatMessage? lastMessage = messages.firstOrNull;

        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          lastMessage.text = response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      }, onError: (error) {
        print(" Gemini error: $error");
      });
    } catch (e) {
      print(" Caught error: $e");
    }
  }
}
