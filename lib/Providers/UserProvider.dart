import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Modals/UserClass.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    address: '',
    currentLocation: const LatLng(0, 0),
  );

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setId(String id) {
    _user.id = id;
    notifyListeners();
  }

  void setName(String name) {
    _user.name = name;
    notifyListeners();
  }

  void setAddress(String address) {
    _user.address = address;
    notifyListeners();
  }

  void setCurrentLocation(LatLng currentLocation) {
    _user.currentLocation = currentLocation;
    notifyListeners();
  }
}