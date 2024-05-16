import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lmsystem_app/components/chat_bubble.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';
import 'package:lmsystem_app/services/auth_service/auth_service.dart';
import 'package:lmsystem_app/services/chat_service/chat_service.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class ChatPage extends StatefulWidget {
  final String receiverId;
  final String? receiverEmail;
  final String? receiverFirstname;
  final String? receiverLastname;
  const ChatPage({super.key, required this.receiverId, this.receiverEmail, this.receiverFirstname, this.receiverLastname});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  final TextEditingController _messageController = TextEditingController();

  void sendMessage() async {
    if(_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverId, _messageController.text);

      _messageController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  RoundIconButton(
                    icon: const Icon(Ionicons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  const CircleAvatar(
                    backgroundColor: MainColors.primaryColor,
                  ),

                  const SizedBox(width: 6,),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.receiverFirstname} ${widget.receiverLastname}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                      ),

                      Text(
                        widget.receiverEmail ?? 'user@email.com'
                      )
                    ],
                  ),

                  const Spacer(),

                  RoundIconButton(
                    icon: const  Icon(Icons.more_vert),
                    backgroundColor: Colors.grey.shade200,
                    onTap: () {
                      
                    },
                  )
                ],
              ),
            ),

            // const Divider(),

            // Message body
            Expanded(
              child: _buildMessageList()
            ),

            // Input field
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Icons.emoji_emotions, color: MainColors.primaryColor, size: 30,),
                  const SizedBox(width: 7,),
                  Expanded(
                    child: TextFormField(
                      maxLines: 10,
                      minLines: 1,
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type message...',
                        contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: MainColors.primaryColor
                          ),
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 2)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: MainColors.primaryColor
                          ),
                          borderRadius: BorderRadius.circular(30)
                        ) 
                      ),
                    ),
                  ),

                  const SizedBox(width: 7,),

                  GestureDetector(
                    onTap: (){
                      print('message: ${_messageController.text}');
                      sendMessage();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: MainColors.primaryColor
                      ),
                      child:const  Icon(
                        Ionicons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  Widget _buildMessageList(){
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverId, senderId),
      builder: (context, snapshot) {
         if (snapshot.hasError){
          return Center(
            child: Text('Error: ${snapshot.error}')
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator()
          );
        }

        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/chat_bg.jpg'),
              fit: BoxFit.cover
            )
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          ),
        );
      },
    );
  }


  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderid'] == _authService.getCurrentUser()!.uid;

    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    // if (data == null) {
    //   return SizedBox(); // Return an empty SizedBox or any other placeholder widget
    // }    

    try {
      print(data['message']);
      print(data);
      // return Text(data['message']);

      // Timestamp timestamp = Timestamp();
      // String formattedTime = formatTimestamp(timestamp);
      String formattedTime = formatTimestamp(data['timestamp']);

      return Container(
        alignment: alignment,
        // color: Colors.green,
        child: Column(
          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(
              message: data['message'] ?? 'Message Loading...', 
              isCurrentUser: isCurrentUser,
              time: formattedTime,
            ),
          ],
        )
      );
    } catch (error) {
      print('Error: $error');
      return Text('Error');
    }
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return formattedTime;
  }
}