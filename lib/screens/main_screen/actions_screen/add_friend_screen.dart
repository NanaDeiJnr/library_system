// ignore_for_file: unused_element, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lmsystem_app/components/accept_request_container.dart';
import 'package:lmsystem_app/components/round_icon_button.dart';
import 'package:lmsystem_app/components/user_tile.dart';
import 'package:lmsystem_app/models/friends_model.dart';
import 'package:lmsystem_app/screens/main_screen/actions_screen/chat_page.dart';
import 'package:lmsystem_app/services/auth_service/auth_service.dart';
import 'package:lmsystem_app/services/chat_service/chat_service.dart';

class FriendRequestScreen extends StatefulWidget {
  const FriendRequestScreen({super.key});

  @override
  State<FriendRequestScreen> createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();

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
                    icon: const Icon(Icons.arrow_back),
                    backgroundColor: Colors.grey.shade200,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Add Friends',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  RoundIconButton(
                    icon: const Icon(Icons.search),
                    backgroundColor: Colors.grey.shade200,
                    onTap: () {
                      print(_chatService.getUserStream());
                    },
                  ),
                  const SizedBox(width: 10),
                  RoundIconButton(
                      icon: const Icon(Icons.more_vert),
                      backgroundColor: Colors.grey.shade200,
                      onTap: () {})
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    'Added me',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        spreadRadius: 1.0,
                        blurRadius: 1.0
                      )
                    ],
                    borderRadius: BorderRadius.circular(12)),
                child: _buildReceivedRequests()),
            ),
            const SizedBox(height: 20,),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    'Add New Friends',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        spreadRadius: 1.0,
                        blurRadius: 1.0
                      )
                    ],
                    borderRadius: BorderRadius.circular(12)),
                child: ListView(
                    children: [
                      _displayUserList(),
                    ],
                  )),
              ),
            ),

            // Expanded(
            //   child: _displayUserList()
            // ),
          ],
        ),
      ),
    );
  }

  // Check if the request has been sent or not
  Future<bool> _isRequestSent(String receiverId) async {
    final sentRequestsSnapshot = await FirebaseFirestore.instance
        .collection('friendRequests')
        .where('senderId', isEqualTo: _authService.getCurrentUser()?.uid)
        .where('receiverId', isEqualTo: receiverId)
        .get();

    return sentRequestsSnapshot.docs.isNotEmpty;
  }

  // Send friend request to receiver
  Future<void> _sendFriendRequest(
      String receiverId, String receiverEmail, BuildContext context) async {
    try {
      final currentUser = _authService.getCurrentUser();
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      // Check if the current user has already sent a request to the receiver
      if (await _isRequestSent(receiverId)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Friend request already sent')),
        );
        return;
      }

      // Store the friend request in Firestore
      await FirebaseFirestore.instance.collection('friendRequests').add({
        'senderId': currentUser.uid,
        'receiverId': receiverId,
        'status': FriendRequestStatus
            .pending.index, // Initial status of the friend request
        'timestamp':
            FieldValue.serverTimestamp(), // Timestamp when the request was sent
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Friend request sent')),
      );
    } catch (error) {
      // Show an error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send friend request: $error')),
      );
    }
  }

  Widget _displayUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Hello World'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        print('Data: ${snapshot.data}');
        return ListView(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    final currentUserUid = _authService.getCurrentUser()?.uid;
    final receiverUid = userData['uid'];

    if (receiverUid != currentUserUid) {
      return StatefulBuilder(builder: (context, setstate) {
        return FutureBuilder<List<String>>(
          future: _chatService.getSentFriendRequests(currentUserUid!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return RoundIconButton(
                icon: const Icon(Icons.refresh),
                onTap: () {
                  setState(() {});
                },
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              List sentRequests = snapshot.data ?? [];
              print('sentRequests: $sentRequests');
              bool requestSent = sentRequests.contains(receiverUid);

              return UserTile(
                username: '${userData['firstname']} ${userData['lastname']}',
                email: userData['email'],
                requestSent: requestSent,
                onIconTap: () async {
                  if (!requestSent) {
                    print(sentRequests);
                    await _sendFriendRequest(
                        receiverUid, userData['email'], context);
                    setState(() {});
                  }
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        receiverEmail: userData['email'],
                        receiverId: receiverUid,
                        receiverFirstname: userData['firstname'],
                        receiverLastname: userData['lastname'],
                      ),
                    ),
                  );
                },
              );
            }

            return const CircularProgressIndicator();
          },
        );
      });
    } else {
      return const SizedBox();
    }
  }

  Widget _buildReceivedRequests() {
    return StreamBuilder(
      stream: _chatService.getReceivedRequests(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final requestData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            final requestId = snapshot.data!.docs[index].id;
            final senderId = requestData['senderId'];
            
            return FutureBuilder(
                future: getUserById((snapshot.data!.docs[index].data()!
                    as Map<String, dynamic>)['senderId']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {

                    final bool requestAccepted = snapshot.data!['status'] == FriendRequestStatus.accepted.index;

                    return RequestTile(
                      acceptRequest: requestAccepted,
                      username: snapshot.data!['firstname'] +
                          ' ' + snapshot.data!['lastname'],
                      email: snapshot.data!['email'],
                      onAccept: () {
                        print(senderId);

                        _acceptFriendRequest(
                          requestId,
                          senderId, // Pass senderId
                        );
                      },
                    );
                  }

                  return const SizedBox();
                });
          },
        );
      },
    );
  }

  Future<Map<String, dynamic>?> getUserById(String userId) async {
    return (await FirebaseFirestore.instance
            .collection('students')
            .doc(userId)
            .get())
        .data();
  }



  // Accept friend request
  Future<void> _acceptFriendRequest(String requestId, String senderId) async {
    try {
      // Update the friend request status to accepted in Firestore
      await FirebaseFirestore.instance
          .collection('friendRequests')
          .doc(requestId)
          .update({'status': FriendRequestStatus.accepted.index});

      // Add both users as friends in their respective friend lists
      await _addFriendToCurrentUser(senderId);
      await _addCurrentUserToFriend(senderId);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Friend request accepted')),
      );
    } catch (error) {
      // Show an error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to accept friend request: $error')),
      );
    }
  }

  // Add the sender of the friend request to the current user's friend list
  Future<void> _addFriendToCurrentUser(String senderId) async {
    final currentUser = _authService.getCurrentUser();
    if (currentUser == null) {
      throw Exception('User not authenticated');
    }

    await FirebaseFirestore.instance
        .collection('students')
        .doc(currentUser.uid)
        .collection('friends')
        .doc(senderId)
        .set({
          'userId': currentUser.uid, // Current user's ID
          'friendId': senderId, // Friend's ID
          'status': FriendRequestStatus.accepted.index
        });
  }

  // Add the current user to the sender's friend list
  Future<void> _addCurrentUserToFriend(String senderId) async {
    final currentUser = _authService.getCurrentUser();
    if (currentUser == null) {
      throw Exception('User not authenticated');
    }

    await FirebaseFirestore.instance
        .collection('students')
        .doc(senderId)
        .collection('friends')
        .doc(currentUser.uid)
        .set({
          'userId': senderId, // Friend's ID
          'friendId': currentUser.uid, // Current user's ID
          'status': FriendRequestStatus.accepted.index
        });
  }
}
