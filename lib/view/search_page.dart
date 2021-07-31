import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:guvenfuturetask/model/task_model.dart';
import 'package:guvenfuturetask/view/user_detail.dart';
import 'package:guvenfuturetask/viewmodel/task_state_model.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchView extends StatelessWidget {
  List<Task> tasks = [];
  List<Task> showSearchUserByText = [];
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    tasks = context.watch<TaskViewModel>().tasks;
    showSearchUserByText = context.watch<TaskViewModel>().showSearchUserByText;
    return Scaffold(
      body: SafeArea(
        child: context.watch<TaskViewModel>().state == TaskState.BUSY
            ? CircularProgressIndicator()
            : context.watch<TaskViewModel>().state == TaskState.ERROR
                ? Text("Error")
                : Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Consumer<TaskViewModel>(
                              builder: (_, provider, __) {
                                return TextFormField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText: "Search User",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _controller.clear();
                                        provider.clearText();
                                      },
                                      icon: Icon(Icons.clear),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    value = value.toLowerCase();
                                    provider.getHoldName(value);
                                  },
                                );
                              },
                            ),
                            Expanded(
                                flex: 6,
                                child: ListView.builder(
                                    itemCount: showSearchUserByText.length,
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
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
                                                                user: showSearchUserByText[
                                                                    index])));
                                              },
                                              leading: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage: NetworkImage(
                                                      showSearchUserByText[
                                                              index]
                                                          .avatar!)),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    showSearchUserByText[index]
                                                        .fullName!,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      showSearchUserByText[
                                                              index]
                                                          .countryName!,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(showSearchUserByText[
                                                          index]
                                                      .jobTitle!),
                                                  Text(showSearchUserByText[
                                                          index]
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
