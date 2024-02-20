import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/message/logic/bloc/search_user_bloc.dart';
import 'package:travelling_app/message/presention/widgets/chat_screen.dart';
import 'package:travelling_app/message/presention/widgets/search_user.dart';
import 'package:travelling_app/signup/data/models/user.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat Room",
          style: blackTextW7Style.copyWith(fontSize: 36),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: SvgPicture.asset('$imagePathLdpi/notify_icon.svg'),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 24.w, left: 24.w, top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
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
      height: 45.h,
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
          Expanded(
            child: Builder(builder: (context) {
              return TextField(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<SearchUserBloc>(context),
                          child: SearchUser(searchController: searchController),
                        ),
                      ));
                },
                decoration: InputDecoration(hintText: "Search", hintStyle: grayBlurText.copyWith(fontSize: 15.sp), border: InputBorder.none),
              );
            }),
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

  Widget _buildUserListItem(QueryDocumentSnapshot documentSnapshot, BuildContext context) {
    documentSnapshot as QueryDocumentSnapshot<Map<String, dynamic>>;
    final data = UserModel.fromJson(documentSnapshot.data());
    if (FirebaseAuth.instance.currentUser!.email != data.email) {
      return Card(
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    receiverId: data.uid,
                    receiverName: data.name,
                    receiverAvt: data.urlAvatar,
                  ),
                ));
          },
          title: Text(data.name),
          leading: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: mainColor,
            ),
            clipBehavior: Clip.hardEdge,
            child: data.urlAvatar == ""
                ? const Icon(Icons.person)
                : Image.network(
                    data.urlAvatar!,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
