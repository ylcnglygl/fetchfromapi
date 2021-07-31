import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guvenfuturetask/model/task_model.dart';
import 'package:guvenfuturetask/service/api_service.dart';

enum TaskState { IDLE, BUSY, ERROR }

class TaskViewModel with ChangeNotifier {
  TaskState? _state;
  List<Task>? _taskList;
  List<Task> _showSearchUserByText = [];
  List<Task> _showSearchUserByComboBox = [];
  String? _holdCountry;
  String? _selectedCountry;
  String? _holdCity;
  String? _selectedCity;
  String? _selectedName;
  List<Task> _dropDownItems = [];
  TaskViewModel() {
    _taskList = [];
    _state = TaskState.IDLE;
    fetchTasks();
  }

  List<Task> get tasks => _taskList!;
  List<Task> get showSearchUserByText => _showSearchUserByText;
  List<Task> get showSearchUserByComboBox => _showSearchUserByComboBox;
  String? get holdCountry => _holdCountry;
  String? get selectedCountry => _selectedCountry;
  String? get holdCity => _holdCity;
  String? get selectedCity => _selectedCity;
  String? get selectedName => _selectedName;
  List<Task> get dropDownItems => _dropDownItems;

  Future<List<Task>> fetchTasks() async {
    try {
      state = TaskState.BUSY;
      _taskList = await ApiService().fetchUsers();
      state = TaskState.IDLE;
      return _taskList!;
    } catch (e) {
      state = TaskState.ERROR;
      return [];
    }
  }

  void getHoldCountry(String newValue) {
    _holdCountry = tasks[int.parse(newValue)].countryName!.toLowerCase();
    _showSearchUserByComboBox = tasks.where((task) {
      var taskTitle = task.countryName!.toLowerCase();
      return taskTitle.contains(_holdCountry!);
    }).toList();
    notifyListeners();
  }

  void getHoldCity(String newValue) {
    _holdCity = tasks[int.parse(newValue)].cityName!.toLowerCase();
    _showSearchUserByComboBox = tasks.where((task) {
      var taskTitle = task.cityName!.toLowerCase();
      return taskTitle.contains(_holdCity!);
    }).toList();
    notifyListeners();
  }

  void getHoldName(String newValue) {
    _showSearchUserByText = tasks.where((task) {
      var taskTitle = task.fullName!.toLowerCase();
      return taskTitle.contains(newValue);
    }).toList();
    notifyListeners();
  }

  void setSelectedCountry(String s) {
    _selectedCountry = s;
    notifyListeners();
  }

  void setSelectedName(String s) {
    _selectedName = s;
    notifyListeners();
  }

  void setSelectedCity(String s) {
    _selectedCity = s;
    _selectedCountry = s;
    notifyListeners();
  }

  void clearAll() {
    _selectedCity = null;
    _selectedCountry = null;
    _holdCity = null;
    _holdCountry = null;
    _showSearchUserByComboBox = [];
    notifyListeners();
  }

  void clearText() {
    _showSearchUserByText = [];
    notifyListeners();
  }

  TaskState get state => _state!;
  set state(TaskState state) {
    _state = state;
    notifyListeners();
  }
}
