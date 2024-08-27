import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_mmf/model/home_model.dart';
import 'package:test_mmf/model/login_model.dart';

class ApiService{
  Future<LoginModel?> sendData(String email , String password) async{
    try{
      var url = Uri.parse('https://mmfinfotech.co/machine_test/api/userLogin');
      var response = await http.post(url,
          body: {
            "email": email, "password": password
          });
      if(response.statusCode == 200){

        print(response.body);
        return LoginModel.fromJson(jsonDecode(response.body));
      }
      else{
        throw Exception('faild to login');
      }

    }catch(e){
      print(e);
    }
  }
  Future<HomeModel?> getData(String Token, int currentPage) async {
    try{
      //String Token =  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvSmVhbm5lLnBuZz9zZXQ9c2V0NCIsImlhdCI6MTcxMzUzMDc4NywiZXhwIjoxNzEzNTM0Mzg3fQ.ntOCoYa1tlhiIV8khMtJkeVHWMmZD3ie0oD-jxVrCqc";
      var url = Uri.parse('https://mmfinfotech.co/machine_test/api/userList?page=1');
      // var response =  http.get(url,headers: {});
      http.Response response =  await http.get(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $Token',
          }

      );

      if(response.statusCode == 200){
        print(response.body);
        return  HomeModel.fromJson(jsonDecode(response.body));
      }else{
        throw Exception('Failed to load data');
      }
    }
    catch(e){
      print(e);
    }
  }
  Future<HomeModel?> getData2(String token, int page) async {
    try {
      var url = Uri.parse('https://mmfinfotech.co/machine_test/api/userList?page=$page');
      http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return HomeModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }


}