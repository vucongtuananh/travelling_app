import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/home/logic/search_bloc/search_bloc.dart';
import 'package:travelling_app/home/presentation/widgets/trip_details.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.searchController});
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
                          context.read<SearchBloc>().add(SearchStartEvent(input: searchController.text));
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
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is SearchSuccessState) {
                    final trips = state.listTripSearch;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          leading: CircleAvatar(radius: 10.r, backgroundImage: NetworkImage(trips[index].imgPath)),
                          title: Text(trips[index].title),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(value: BlocProvider.of<SearchBloc>(context), child: TripDetails(trip: trips[index])),
                                ));
                          },
                        ),
                      ),
                      itemCount: trips.length,
                    );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
