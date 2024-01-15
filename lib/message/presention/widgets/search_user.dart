import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/message/logic/bloc/search_user_bloc.dart';
import 'package:travelling_app/message/presention/widgets/chat_screen.dart';

class SearchUser extends StatelessWidget {
  const SearchUser({super.key, required this.searchController});
  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(color: whiteColor, border: Border.all(color: const Color(0xffE9E9E9)), borderRadius: BorderRadius.circular(20)),
                child: Row(children: [
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Builder(builder: (context) {
                      return TextField(
                        onChanged: (value) {
                          context.read<SearchUserBloc>().add(StartSearchUserEvent(input: searchController.text));
                        },
                        controller: searchController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                        ),
                      );
                    }),
                  )
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<SearchUserBloc, SearchUserState>(
                builder: (context, state) {
                  if (state is SearchUserLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is SearchUserLoaded) {
                    final users = state.listUser;
                    if (users.isEmpty) {
                      return const SizedBox(
                        child: Text("There's no user matched!!"),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Card(
                        child: users[index].email == FirebaseAuth.instance.currentUser!.email
                            ? const SizedBox()
                            : ListTile(
                                leading: CircleAvatar(radius: 10.r, child: Text(users[index].email)),
                                title: Text(users[index].name),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(receiverId: users[index].uid, receiverName: users[index].name)));
                                },
                              ),
                      ),
                      itemCount: users.length,
                    );
                  }
                  return const SizedBox(
                      // child: Text("There's no trip matched!!"),
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
