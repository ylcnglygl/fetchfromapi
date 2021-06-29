import 'package:flutter/material.dart';
import 'package:guvenfuturetask/model/task_model.dart';

class UserDetail extends StatelessWidget {
  Task? user;
  UserDetail({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                user!.fullName!,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 1 / 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "About",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 1 / 50),
              Text(user!.about!, textAlign: TextAlign.justify),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(user!.jobTitle!),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 1 / 30),
              Image.network(
                user!.cityPicture!,
                height: MediaQuery.of(context).size.height * 1 / 3,
                width: MediaQuery.of(context).size.width,
              ),
              Text(user!.cityName!),
              Text(user!.countryName!),
            ],
          ),
        ),
      ),
    );
  }
}
