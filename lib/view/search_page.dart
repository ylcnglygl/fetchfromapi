import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:guvenfuturetask/model/task_model.dart';
import 'package:guvenfuturetask/service/api_service.dart';
import 'package:guvenfuturetask/view/user_detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? searchTerm;
  ApiService apiService = ApiService();

  late Future<List<Task>>? users;
  List<Task> tasks = [];
  List<Task> showSearchUser = [];
  bool loading = false;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    loading = true;
    apiService.fetchUsers().then((value) {
      setState(() {
        tasks.addAll(value);
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: "Search User",
                            suffixIcon: IconButton(
                              onPressed: () => _controller.clear(),
                              icon: Icon(Icons.clear),
                            ),
                          ),
                          onChanged: (value) {
                            value = value.toLowerCase();
                            setState(() {
                              showSearchUser = tasks.where((task) {
                                var taskTitle = task.fullName!.toLowerCase();
                                return taskTitle.contains(value);
                              }).toList();
                            });
                          },
                        ),
                        Expanded(
                            flex: 6,
                            child: ListView.builder(
                                itemCount: showSearchUser.length,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserDetail(
                                                            user:
                                                                showSearchUser[
                                                                    index])));
                                          },
                                          leading: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: NetworkImage(
                                                  showSearchUser[index]
                                                      .avatar!)),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                showSearchUser[index].fullName!,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  showSearchUser[index]
                                                      .countryName!,
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(showSearchUser[index]
                                                  .jobTitle!),
                                              Text(showSearchUser[index]
                                                  .cityName!),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
