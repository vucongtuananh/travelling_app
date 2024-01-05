import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/message/presention/widgets/chat_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: SvgPicture.asset("$imagePathLdpi/back_arrow.svg"),
      //   actions: [SvgPicture.asset("$imagePathLdpi/take_note_icon.svg")],
      // ),
      body: Padding(
        padding: EdgeInsets.only(right: 24.w, left: 24.w, top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            header(),
            SizedBox(
              height: 20.h,
            ),
            searchBar(),
            SizedBox(
              height: 20.h,
            ),
            listUser(context)
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset("$imagePathLdpi/back_arrow.svg"),
        Text(
          "Chat Room",
          style: blackTextW6Style.copyWith(fontSize: 16.sp),
        ),
        SvgPicture.asset("$imagePathLdpi/take_note_icon.svg"),
      ],
    );
  }

  Widget searchBar() {
    return Container(
      padding: EdgeInsets.only(
        left: 17.w,
      ),
      decoration: BoxDecoration(
          border: Border.all(
            color: grayColor,
          ),
          borderRadius: BorderRadius.circular(30.r)),
      child: Row(
        children: [
          const Icon(Icons.search),
          SizedBox(
            width: 5.w,
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: "Search", border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget listUser(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong!!");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return SizedBox(
          height: 300.h,
          child: ListView(
            padding: EdgeInsets.zero,
            children: snapshot.data!.docs.map((e) => _buildUserListItem(e, context)).toList(),
          ),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot documentSnapshot, BuildContext context) {
    Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
    if (FirebaseAuth.instance.currentUser!.email != data['email']) {
      return Card(
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    receiverEmail: data['email'],
                  ),
                ));
          },
          title: Text(data['email']),
          leading: CircleAvatar(
            backgroundColor: mainColor,
            child: FittedBox(child: Text(data['user-name'])),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
