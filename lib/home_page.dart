import 'package:chatterbro/components/background_color.dart';
import 'package:chatterbro/components/my_drawer.dart';
import 'package:chatterbro/components/user_tile.dart';
import 'package:chatterbro/pages/chatpage.dart';
import 'package:chatterbro/pages/login_page.dart';
import 'package:chatterbro/services/auth_services.dart';
import 'package:chatterbro/services/chat_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    Future<void> logout() async {
      await FirebaseAuth.instance.signOut();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ChatterBro.....",
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        backgroundColor: Color(0xFF0F0C29),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),
      drawer: MyDrawer(),
      body: BackgroundColor(
        color1: Color(0xFF0F0C29),
        color2: Color(0xFF302B63),
        mychild: buildUserList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleAddChat(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text("Error");
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Text("Loading...");
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) =>
                  _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authServices.getCurrentuser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chatpage(
                    receiverEmail: userData["email"],
                        receiverID: userData["uid"],
                      )));
        },
      );
    } else {
      return Container();
    }
  }

  // 🔥 Add Chat Logic
  void _handleAddChat(BuildContext context) async {
    TextEditingController emailController = TextEditingController();

    final email = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Enter user's email"),
        content: TextField(
          controller: emailController,
          decoration: InputDecoration(hintText: "example@gmail.com"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // cancel
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, emailController.text.trim()), // submit
            child: Text("Create Chat"),
          ),
        ],
      ),
    );

    if (email == null || email.isEmpty) return;

    try {
      await _authServices.addChatByEmail(context,email);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
