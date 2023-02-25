import 'package:educode/model/course.dart';

class CheckoutArguments {
  final List<Course> _courseList;
  final double _totalPrice;

  get courseList => _courseList;

  get totalPrice => _totalPrice;

  CheckoutArguments(this._courseList, this._totalPrice);
}
