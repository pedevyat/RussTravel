import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget{

	ProfilePage createState()=> ProfilePage();
}

class SignIn extends StatefulWidget{
	final void Function(int) onPageChanged;
	SignIn(this.onPageChanged);
	SignInPage createState()=> SignInPage();
}

class SignUp extends StatefulWidget{
	final void Function(int) onPageChanged;
	SignUp(this.onPageChanged);
	SignUpPage createState()=> SignUpPage();
}

class SignInPage extends State<SignIn>
{
	bool _isPasswordHidden = true;
	
	Widget build(BuildContext context)
	{
		return new Center
		(
			child: new Align
			(
				alignment: Alignment.center,
				child : new Column
				(
					mainAxisAlignment: MainAxisAlignment.center,
					children:
					[
						new Container(
  							width: 320,
  							height: 150,
  							child: Image.asset('assets/splash1.png'),
							),
						new Container
						(
							width : 350,
							child: new TextField(decoration: InputDecoration
									(
									enabledBorder: OutlineInputBorder(borderSide: BorderSide(
            								color: Colors.black,
            								width : 1.0,
          								),
          							),
									focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            								color: Color.fromRGBO(0, 108, 167, 1),
            								width : 2.0,
          								),
          							),
									hintText : 'Введите ваш логин...',
									contentPadding: EdgeInsets.symmetric(horizontal: 20),
									),
									cursorColor: Color.fromRGBO(0, 108, 167, 1),
								),
						),
						new SizedBox(height: 16),
						new Container
						(
							width : 350,
							child: new TextField(
								obscureText: _isPasswordHidden,
								decoration: InputDecoration
								(
									enabledBorder: OutlineInputBorder(borderSide: BorderSide(
            								color: Colors.black,
            								width : 1.0,
          								),
          							),
									focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            								color: Color.fromRGBO(0, 108, 167, 1),
            								width : 2.0,
          								),
          							),
									hintText : 'Введите ваш пароль...',
									contentPadding: EdgeInsets.symmetric(horizontal: 20),
									suffixIcon: IconButton(
                    					icon: Icon(
                        					_isPasswordHidden ? Icons.visibility : Icons.visibility_off),
                    					onPressed: () {
                    						setState(() { _isPasswordHidden = !_isPasswordHidden; });
                      					}),
								),
								cursorColor: Color.fromRGBO(0, 108, 167, 1),
							),
						),
						new SizedBox(height: 8),
						new Container
						(
							width : 350, 
							height : 40,
							child: new TextButton(
								style: TextButton.styleFrom
								(
									primary: Color.fromRGBO(255, 255, 255, 1),
									onSurface: Colors.red,
									backgroundColor: Color.fromRGBO(0, 108, 167, 1), // фон кнопки
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () {},
								child: Text('Вход'),
								)
						),
						new SizedBox(height: 8),
						new Container
						(
							width : 350, 
							child: new TextButton(
								style: TextButton.styleFrom
								(
									primary: Color.fromRGBO(0, 108, 167, 1),
									onSurface: Colors.red,
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () { widget.onPageChanged(1);},
								child: Text('Регистрация'),
								)
						),
						new SizedBox(height: 4),
						new Container
						(
							width : 350, 
							child: new TextButton(
								style: TextButton.styleFrom
								(
									primary: Color.fromRGBO(0, 108, 167, 1),
									onSurface: Colors.red,
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () {},
								child: Text('Политика конфиденциальности'),
								)
						),
					]
				)
			)
		);
	}
}

class SignUpPage extends State<SignUp>
{
	bool _isPasswordHidden = true;
	bool _isRepeatPasswordHidden = true;
	
	final TextEditingController usernameController = TextEditingController();
	final TextEditingController emailController = TextEditingController();
	final TextEditingController passwordController = TextEditingController();
	
	Future<void> makePostRequest() async {
    	String name = usernameController.text;
    	String email = emailController.text;
    	String password = passwordController.text;

    	if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      		String url = 'http://127.0.0.1:8000/users?username=$name&email_addr=$email&password=$password';
      	
      		try 
      		{
        		final response = await http.post(Uri.parse(url));
        	}
        	catch (e) {
        		;
      		}
      	}
	}

	Widget build(BuildContext context) {
		return new Center
		(
			child: new Align
			(
				alignment: Alignment.center,
				child : new Column
				(
					mainAxisAlignment: MainAxisAlignment.center,
					children:
					[
						new Container(
  							width: 320,
  							height: 150,
  							child: Image.asset('assets/splash1.png'),
							),
						new Container
						(
							width : 350,
							child: new TextField(
								controller : usernameController,
								decoration: InputDecoration
								(
								enabledBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Colors.black,
            							width : 1.0,
          							),
          						),
								focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Color.fromRGBO(0, 108, 167, 1),
            							width : 2.0,
          							),
          						),
								hintText : 'Введите ваш логин...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),),
								cursorColor: Color.fromRGBO(0, 108, 167, 1),
								),
						),
						new SizedBox(height: 16),
						new Container
						(
							width : 350,
							child: new TextField(
								controller : emailController,
								decoration: InputDecoration
								(
								enabledBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Colors.black,
            							width : 1.0,
          							),
          						),
								focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Color.fromRGBO(0, 108, 167, 1),
            							width : 2.0,
          							),
          						),
								hintText : 'Введите ваш email...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),),
								cursorColor: Color.fromRGBO(0, 108, 167, 1),
								),
						),
						new SizedBox(height: 16),
						new Container
						(
							width : 350,
							child: new TextField(
								obscureText: _isPasswordHidden,
								controller : passwordController,
								decoration: InputDecoration
								(
								enabledBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Colors.black,
            							width : 1.0,
          							),
          						),
								focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Color.fromRGBO(0, 108, 167, 1),
            							width : 2.0,
          							),
          						),
								hintText : 'Придумайте пароль...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),
								suffixIcon: IconButton(
                    				icon: Icon(
                        				_isPasswordHidden ? Icons.visibility : Icons.visibility_off),
                    				onPressed: () {
                    					setState(() { _isPasswordHidden = !_isPasswordHidden; });
                      				}),
								),
								cursorColor: Color.fromRGBO(0, 108, 167, 1),
							),
						),
						new SizedBox(height: 16),
						new Container
						(
							width : 350,
							child: new TextField(
								obscureText: _isRepeatPasswordHidden,
								decoration: InputDecoration
								(
								enabledBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Colors.black,
            							width : 1.0,
          							),
          						),
								focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            							color: Color.fromRGBO(0, 108, 167, 1),
            							width : 2.0,
          							),
          						),
								hintText : 'Повторите ваш пароль...',
								contentPadding: EdgeInsets.symmetric(horizontal: 20),
								suffixIcon: IconButton(
                    				icon: Icon(
                        				_isRepeatPasswordHidden ? Icons.visibility : Icons.visibility_off),
                    				onPressed: () {
                    					setState(() { _isRepeatPasswordHidden = !_isRepeatPasswordHidden; });
                      				}),
								),
								cursorColor: Color.fromRGBO(0, 108, 167, 1),
							),
						),
						new SizedBox(height: 8),
						new Container
						(
							width : 350,
							height : 40,
							child: new TextButton(
								style: TextButton.styleFrom
								(
									primary: Color.fromRGBO(255, 255, 255, 1),
									onSurface: Colors.red,
									backgroundColor: Color.fromRGBO(0, 108, 167, 1), // фон кнопки
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () {makePostRequest();},
								child: Text('Регистрация'),
								)
						),
						new SizedBox(height: 8),
						new Container
						(
							width : 350, 
							child: new TextButton(
								style: TextButton.styleFrom
								(
									primary: Color.fromRGBO(0, 108, 167, 1),
									onSurface: Colors.red,
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () { widget.onPageChanged(0); },
								child: Text('Авторизация'),
								)
						),
						new SizedBox(height: 4),
						new Container
						(
							width : 350, 
							child: new TextButton(
								style: TextButton.styleFrom
								(
									primary: Color.fromRGBO(0, 108, 167, 1),
									onSurface: Colors.red,
									minimumSize: Size(double.infinity, 0.5), 
								),
								onPressed: () {},
								child: Text('Политика конфиденциальности'),
								)
						),
					]
				)
			)
		);
	}
}

class ProfilePage extends State<Profile>
{
	int _currentIndex = 0;
	
	void changePage(int page) {
    	setState(() {
      	_currentIndex = page;
    	});
  	}
	
	Widget build(BuildContext context) {
		final List<Widget> _pages = [
    	SignIn(changePage),
    	SignUp(changePage),
		];	
		return _pages[_currentIndex];
	}
}
