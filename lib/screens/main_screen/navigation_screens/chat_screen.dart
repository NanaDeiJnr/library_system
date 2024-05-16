// ignore_for_file: unused_local_variable, avoid_print, unused_field, unused_import, unused_element, library_private_types_in_public_api, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lmsystem_app/components/primary_chat_container.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';
import 'package:lmsystem_app/components/study_group_container.dart';
import 'package:lmsystem_app/components/user_tile.dart';
import 'package:lmsystem_app/screens/main_screen/actions_screen/add_friend_screen.dart';
import 'package:lmsystem_app/screens/main_screen/actions_screen/chat_page.dart';
import 'package:lmsystem_app/screens/main_screen/actions_screen/user_list_screen.dart';
import 'package:lmsystem_app/services/auth_service/auth_service.dart';
import 'package:lmsystem_app/services/chat_service/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Header Section
              Row(
                children: [
                  const Text(
                    'Friends',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  RoundIconButton(
                    icon: const Icon(Icons.add),
                    backgroundColor: Colors.grey.shade200,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const FriendRequestScreen()));
                    },
                  ),
                  const SizedBox(width: 10),
                  RoundIconButton(
                    icon: const Icon(Icons.more_vert),
                    backgroundColor: Colors.grey.shade200,
                    onTap: () {
                      String userId = 'user1';
                      String otherUserId = 'user2';

                      List<String> ids = [userId, otherUserId];
                      ids.sort();

                      FirebaseFirestore.instance
                        .collection('chat_room')
                        .get()
                        .then((QuerySnapshot querySnapshot) {
                          print('Number of documents in the collection: ${querySnapshot.docs.length}');
                          querySnapshot.docs.forEach((DocumentSnapshot doc) {
                            // print(doc.id); // Document ID
                            // print(doc.data()); // Document data
                          });
                        });
                    }
                  )
                ],
              ),
              const Divider(),
              // Recent Chats Section
              const Row(
                children: [
                  Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),

              Container(
                color: Colors.white,
                child: _displayFriends()
              ),

              const SizedBox(height: 20,),

              const Row(
                children: [
                  Text(
                    'Sent Requests',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),

              _buildSentRequests(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayFriends() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('students')
        .doc(auth.currentUser?.uid)
        .collection('friends')
        .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final friends = snapshot.data!.docs;

        if (friends.isEmpty) {
          return const Center(child: Text('You have no friends yet.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final friend = friends[index];
            final friendId = friend.id;
            return FutureBuilder<Map<String, dynamic>?>(
              future: getUserById(friendId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(); // Show nothing while loading
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final friendData = snapshot.data!;
                final String username = friendData['firstname'] + ' ' + friendData['lastname'];

                return FutureBuilder<String?>(
                  future: _getLastMessage(auth.currentUser!.uid, friendId),
                  builder: (context, messageSnapshot) {
                    if (messageSnapshot.connectionState == ConnectionState.waiting) {
                      // Return a loading indicator while waiting for the last message to load
                      return const CircularProgressIndicator();
                    }

                    if (messageSnapshot.hasError) {
                      // Handle error state
                      return Text('Error: ${messageSnapshot.error}');
                    }

                    String? lastMessage = messageSnapshot.data;

                    // Check if there are unread messages
                    bool hasUnreadMessages = lastMessage != null && lastMessage.isNotEmpty;

                    return PrimaryChatContainer(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              receiverEmail: friendData['email'],
                              receiverId: friendData['uid'],
                              receiverFirstname: friendData['firstname'],
                              receiverLastname: friendData['lastname'],
                            )
                          )
                        );
                      },
                      chatName: friendData['firstname'] + ' ' + friendData['lastname'],
                      message: hasUnreadMessages ? 'New message' : lastMessage ?? 'Say hello to $username',
                      status: hasUnreadMessages ? 'unread' : '',
                    );
                  }
                );
              },
            );
          },
        );
      },
    );
  }


  Widget _buildSentRequests() {
    return StreamBuilder(
      stream: _chatService.getSentRequests(),
      builder: (context, snapshot) {
        if (snapshot.hasError){
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: getUserById((snapshot.data!.docs[index].data()! as Map<String, dynamic>)['receiverId']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return ListTile(
                    leading: const CircleAvatar(backgroundImage: AssetImage('assets/images/user.png')),
                    title: Text(snapshot.data!['firstname'] + ' ' + snapshot.data!['lastname']),
                    subtitle: Text(snapshot.data!['email']),
                    trailing: const RoundIconButton(
                      icon: Icon(Icons.chat_bubble_outline),
                    ),
                  );
                }

                return const SizedBox();
              }
            );
          },
        );
      },
    );
  }

  Future<Map<String, dynamic>?> getUserById (String userId) async{
    return(
      await FirebaseFirestore.instance.collection('students')
      .doc(userId)
      .get()
    ).data();
  }

  Future<String?> _getLastMessage(String currentUserId, String friendId) async {
    try {
      // Query the messages collection to get the last message between the current user and the friend
      // Assuming you have a 'messages' collection with documents containing fields like 'senderId', 'receiverId', 'message', 'timestamp'
      final messagesRef = FirebaseFirestore.instance.collection('messages');
      final query = messagesRef
        .where('senderId', whereIn: [currentUserId, friendId])
        // .where('receiverId', whereIn: [currentUserId, friendId])
        .orderBy('timestamp', descending: true)
        .limit(1);

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        final lastMessage = snapshot.docs.first.data();
        return lastMessage['message'] as String?;
      } else {
        return null;
      }
    } catch (error) {
      print('Error getting last message: $error');
      return null;
    }
  }

}
