class Task {
  int? id;
  String? avatar;
  int? age;
  String? eyeColor;
  String? fullName;
  String? gender;
  String? jobTitle;
  String? email;
  String? phone;
  String? address;
  String? about;
  String? countryName;
  String? cityName;
  String? cityPicture;

  Task(
      {this.id,
      this.avatar,
      this.age,
      this.eyeColor,
      this.fullName,
      this.gender,
      this.jobTitle,
      this.email,
      this.phone,
      this.address,
      this.about,
      this.countryName,
      this.cityName,
      this.cityPicture});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      avatar: json['avatar'],
      age: json['age'],
      eyeColor: json['eyeColor'],
      fullName: json['full_name'],
      gender: json['gender'],
      jobTitle: json['job_title'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      about: json['about'],
      countryName: json['country_name'],
      cityName: json['city_name'],
      cityPicture: json['city_picture'],
    );
  }
}
