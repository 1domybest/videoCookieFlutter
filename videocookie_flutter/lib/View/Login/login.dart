import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:videocookie_flutter/helper/login_background.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: size,
          painter: LoginBackground(),
        ),
        // Container(color: Color.fromRGBO(130, 66, 34, 1)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _logoImage(),
            // Container(width: 200, height: 200, color: Color.fromRGBO(130, 66, 34, 1),),
            Stack(
              children: [
                _inputForm(size),
                _authButton(size),
                // Positioned(child: Container(width: 100, height: 50,color: Colors.black)),
              ],
            ),
            Container(
              height: size.height * 0.1,
            ),
            Text("계정이 없으신가요? 회원가입"),
            Container(
              height: size.height * 0.05,
            ),
          ],
        ),
      ],
    ));
  }

  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6.0,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 32),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.account_circle), labelText: "이메일"),
                    validator: (value) {
                      if (value == '') {
                        return '이메일을 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key), labelText: "비밀번호"),
                    validator: (value) {
                      if (value == '') {
                        return '비밀번호를 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 8,
                  ),
                  Text('비밀번호 찾기'),
                ],
              )),
        ),
      ),
    );
  }

  Widget _authButton(Size size) {
    return Positioned(
      bottom: 0,
      left: size.width * 0.15,
      right: size.width * 0.15,
      child: SizedBox(
        height: 50,
        child: MaterialButton(
          elevation: 8,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // print('이메일  :  ' + _emailController.text.toString());
              // print('비밀번호  :  ' + _passwordController.text.toString());
              // var path = '/api/user/localLogin';
              // var url = Uri.parse('http://localhost:8080/api/user/localLogin');
              var formMap = {'email': _emailController.text.toString(), 'password': _passwordController.text.toString()};

              String url = 'http://10.0.2.2:8080/api/user/flutter/login';
              http.Response response = await http.post(Uri.parse(url),
                headers: <String, String> {
                  'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
                },
                body: formMap,
              );
              final decodeData = utf8.decode(response.bodyBytes);
              final data = jsonDecode(decodeData);
              print(data['code']);
              print(data['message']);
              print(data['data']);
            } else {
            }
          },
          color: Color.fromRGBO(130, 66, 34, 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Text(
            '로그인',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}


Widget _logoImage () {
  return Expanded( // 알아서 크기조절
    child: Padding(
      padding: EdgeInsets.only(top: 40, left: 24, right: 24),
      child: FittedBox(
        fit: BoxFit.contain,
        child: CircleAvatar(
          backgroundImage: NetworkImage('https://video-cookie-sample.s3.ap-northeast-2.amazonaws.com/cookies.gif'),
        ),
      ),
    ),
  );
}
