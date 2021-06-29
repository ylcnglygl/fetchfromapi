import 'package:flutter/material.dart';
import 'package:guvenfuturetask/model/task_model.dart';
import 'package:guvenfuturetask/service/api_service.dart';
import 'package:guvenfuturetask/view/search_page.dart';
import 'package:guvenfuturetask/view/user_detail.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  List<Task> tasks = [];
  List<Task> showSearchUser = [];
  String? _selectedCountry;
  String? _selectedCity;
  String? holdCountry;
  String? holdCity;
  bool loading = false;

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
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                })),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: loading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                        isDense: true,
                        hint: new Text("Choose Country"),
                        value: _selectedCountry,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCountry = newValue;
                            holdCountry = tasks[int.parse(newValue!)]
                                .countryName!
                                .toLowerCase();
                            showSearchUser = tasks.where((task) {
                              var taskTitle = task.countryName!.toLowerCase();
                              return taskTitle.contains(holdCountry!);
                            }).toList();
                          });

                          print(holdCountry);
                        },
                        items: tasks.map((item) {
                          return new DropdownMenuItem<String>(
                              child: Text(item.countryName!),
                              value: item.id.toString());
                        }).toList()),
                    DropdownButton<String>(
                        isDense: true,
                        hint: new Text("Choose City"),
                        value: _selectedCity,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCountry = newValue;
                            _selectedCity = newValue;
                            holdCity = tasks[int.parse(newValue!)]
                                .cityName!
                                .toLowerCase();
                            showSearchUser = tasks.where((task) {
                              var taskTitle = task.cityName!.toLowerCase();
                              return taskTitle.contains(holdCity!);
                            }).toList();
                          });

                          print(_selectedCity);
                        },
                        items: tasks.map((item) {
                          return new DropdownMenuItem<String>(
                              child: Text(item.cityName!),
                              value: item.id.toString());
                        }).toList()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedCountry = null;
                                _selectedCity = null;
                                holdCountry = null;
                                holdCity = null;
                              });
                            },
                            child: Text("Clear")),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _selectedCountry == null && _selectedCity == null
                          ? Container()
                          : Container(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 3,
                              child: AnimationLimiter(
                                child: ListView.builder(
                                    itemCount: showSearchUser.length,
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
                                                                user: showSearchUser[
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    showSearchUser[index]
                                                        .fullName!,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                    }),
                              )),
                    ),
                  ],
                ),
        ));
  }
}
