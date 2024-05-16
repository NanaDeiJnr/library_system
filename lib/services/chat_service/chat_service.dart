// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lmsystem_app/models/message.dart';

class ChatService{
  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('students').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String receiverId, message) async{
    final String currentUserId = _auth.currentUser!.uid;
    final String curentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: curentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    try {
      await _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
    } catch (error) {
      print('Error sending message: $error');
    }
  }

  // get message
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();

    String chatRoomId = ids.join('_');

    return _firestore
      .collection('chat_room')
      .doc(chatRoomId)
      .collection('messages')
      .orderBy('timestamp', descending: false)
      .snapshots();
  }

  Future<bool> hasSentFriendRequest(String currentUserUid, String receiverUid) async {
    try {
      final snapshot = await _firestore
          .collection('friendRequests')
          .where('senderId', isEqualTo: currentUserUid)
          .where('receiverId', isEqualTo: receiverUid)
          .get();
      
      return snapshot.docs.isNotEmpty;
    } catch (error) {
      // Handle error
      print('Error checking friend request: $error');
      return false;
    }
  }

  Future<List<String>> getSentFriendRequests(String currentUserUid) async {
    try {
      final snapshot = await _firestore
          .collection('friendRequests')
          .where('senderId', isEqualTo: currentUserUid)
          .get();

      return snapshot.docs.map((doc) => doc['receiverId'] as String).toList();
    } catch (error) {
      // Handle error
      print('Error getting sent friend requests: $error');
      return [];
    }
  }

  Stream<QuerySnapshot> getReceivedRequests (){
    return _firestore
      .collection('friendRequests')
      .where('receiverId', isEqualTo: _auth.currentUser?.uid)
      .snapshots();
  }

  Stream<QuerySnapshot> getSentRequests (){
    return _firestore
      .collection('friendRequests')
      .where('senderId', isEqualTo: _auth.currentUser?.uid)
      .snapshots();
  }

  Future<String> getLastMessage(String currentUserId, String friendId) async {
    try {
      final messagesRef = _firestore
          .collection('chat_room')
          .doc(_generateChatRoomId(currentUserId, friendId))
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(1);

      final snapshot = await messagesRef.get();

      if (snapshot.docs.isNotEmpty) {
        final lastMessage = snapshot.docs.first.data();
        return lastMessage['message'] ?? '';
      } else {
        return '';
      }
    } catch (error) {
      print('Error getting last message: $error');
      return '';
    }
  }

  String _generateChatRoomId(String userId1, String userId2) {
    List<String> ids = [userId1, userId2];
    ids.sort();
    return ids.join('_');
  }
  

  // Step 1: Create a method to fetch the list of friends from Firestore
  Future<List<String>> fetchUserFriends() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return []; // Return empty list if user is not logged in
    }

    final userDoc = await _firestore.collection('students').doc(currentUser.uid).get();
    final List<dynamic>? friends = userDoc['friends'];

    if (friends == null || friends.isEmpty) {
      return []; // Return empty list if user has no friends
    }

    // Convert dynamic list to list of strings
    return friends.map((friend) => friend.toString()).toList();
  }

}