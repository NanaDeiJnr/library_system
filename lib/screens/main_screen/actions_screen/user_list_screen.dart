import 'package:flutter/material.dart';
import 'package:lmsystem_app/components/user_tile.dart';
import 'package:lmsystem_app/screens/main_screen/actions_screen/chat_page.dart';
import 'package:lmsystem_app/services/auth_service/auth_service.dart';
import 'package:lmsystem_app/services/chat_service/chat_service.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _displayUserList()
      ),
    );
  }

  Widget _displayUserList(){
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError){
          return const Center(
            child: Text('No data found')
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator()
          );
        }

        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem (Map<String, dynamic> userData, BuildContext context){
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        requestSent: true,
        username: userData['firstname'] + ' ' + userData['lastname'],
        email: userData['email'],

        onTap: () {
          // String? receiverId = userData['uid'];
          print(userData['uid']);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData['email'],
                receiverId: userData['uid'],
                receiverFirstname: userData['firstname'],
                receiverLastname: userData['lastname'],
              )
            )
          );
        },
      );
    } else {
      return Center(
        child: Text('No user found'),
      );
    }
  }
}