import 'package:chatterbro/pages/settingpage.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 27, 22, 74),
      child: Column(
        children: [
          SizedBox(height: 90),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListTile(
              title: Text("Home",style: TextStyle(color: Color(0xFFFFFFFF))),
              leading: Icon(Icons.home,color:Colors.white),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListTile(
              title: Text("settings",style: TextStyle(color: Color(0xFFFFFFFF))),
              leading: Icon(Icons.settings,color:Colors.white),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Settingpage(),));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListTile(
              title: Text("log out",style: TextStyle(color: Color(0xFFFFFFFF))),
              leading: Icon(Icons.logout,color:Colors.white),
            ),
          )
        ],
      ),
    );
  }
}