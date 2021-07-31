import 'package:flutter/material.dart';
import 'package:guvenfuturetask/model/task_model.dart';
import 'package:guvenfuturetask/view/search_page.dart';
import 'package:guvenfuturetask/view/user_detail.dart';
import 'package:guvenfuturetask/viewmodel/task_state_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// ignore: must_be_immutable
class Homepage extends StatelessWidget {
  List<Task> tasks = [];
  List<Task> showSearchUserByComboBox = [];

  @override
  Widget build(BuildContext context) {
    tasks = context.watch<TaskViewModel>().tasks;
    showSearchUserByComboBox =
        context.watch<TaskViewModel>().showSearchUserByComboBox;
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchView()));
                })),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: context.watch<TaskViewModel>().state == TaskState.BUSY
              ? CircularProgressIndicator()
              : context.watch<TaskViewModel>().state == TaskState.ERROR
                  ? Text("Error")
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<TaskViewModel>(builder: (_, provider, __) {
                          return DropdownButton<String>(
                              isDense: true,
                              hint: new Text("Choose Country"),
                              value: provider.selectedCountry,
                              onChanged: (String? newValue) {
                                provider.setSelectedCountry(newValue!);
                                provider.getHoldCountry(newValue);
                              },
                              items: tasks.map((item) {
                                return new DropdownMenuItem<String>(
                                    child: Text(item.countryName!),
                                    value: item.id.toString());
                              }).toList());
                        }),
                        Consumer<TaskViewModel>(builder: (_, provider, __) {
                          return DropdownButton<String>(
                              isDense: true,
                              hint: new Text("Choose City"),
                              value: provider.selectedCity,
                              onChanged: (String? newValue) {
                                provider.setSelectedCity(newValue!);
                                provider.getHoldCity(newValue);
                              },
                              items: tasks.map((item) {
                                return new DropdownMenuItem<String>(
                                    child: Text(item.cityName!),
                                    value: item.id.toString());
                              }).toList());
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Provider.of<TaskViewModel>(context,
                                          listen: false)
                                      .clearAll();
                                },
                                child: Text("Clear")),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 3,
                              child: AnimationLimiter(
                                  child: Consumer<TaskViewModel>(
                                builder: (_, provider, __) {
                                  return (provider.selectedCity == null &&
                                              provider.holdCity == null) &&
                                          (provider.selectedCountry == null &&
                                              provider.holdCountry == null)
                                      ? Container()
                                      : ListView.builder(
                                          itemCount:
                                              showSearchUserByComboBox.length,
                                          itemBuilder: (context, index) {
                                            return AnimationConfiguration
                                                .staggeredList(
                                              position: index,
                                              duration: const Duration(
                                                  milliseconds: 375),
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
                                                                      user: showSearchUserByComboBox[
                                                                          index])));
                                                    },
                                                    leading: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                showSearchUserByComboBox[
                                                                        index]
                                                                    .avatar!)),
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          showSearchUserByComboBox[
                                                                  index]
                                                              .fullName!,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            showSearchUserByComboBox[
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
                                                        Text(
                                                            showSearchUserByComboBox[
                                                                    index]
                                                                .jobTitle!),
                                                        Text(
                                                            showSearchUserByComboBox[
                                                                    index]
                                                                .cityName!),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                },
                              ))),
                        ),
                      ],
                    ),
        ));
  }
}
