import 'package:api_project1/models/api_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiPages extends StatefulWidget {
  const ApiPages({super.key});

  @override
  State<ApiPages> createState() => _ApiPagesState();
}

class _ApiPagesState extends State<ApiPages> {
  UserModel? userModel;
  Future<void> fetchData() async {
    final dio = Dio();
    final response = await dio.get('https://reqres.in/api/users/2');
    if (response.statusCode == 200) {
      setState(() {
        userModel = UserModel(
            id: response.data['data']['id'],
            email: response.data['data']['email'],
            firstName: response.data['data']['first_name'],
            LastName: response.data['data']['l ast_name'],
            avatar: response.data['data']['avatar']);
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api 1'),
        centerTitle: true,
      ),
      body: userModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Card(
              child: ListTile(
                leading: Text(userModel!.id.toString()),
                title: Text('${userModel!.firstName}${userModel!.LastName}'),
                subtitle: Text(userModel!.email),
                trailing: Image.network(userModel!.avatar),
              ),
            ),
    );
  }
}
