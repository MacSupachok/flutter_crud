class API {
  //main path api
  static const hostConnect = "http://192.168.1.9/flutter_crud";
  static const hostConnectUser = "$hostConnect/users/user_service.php";

  //function users path api
  static const insertData = "$hostConnectUser?function=insert";
  static const readData = "$hostConnectUser?function=readData";
  static const deleteData = "$hostConnectUser?function=delete";
  static const updateData = "$hostConnectUser?function=update";
}
