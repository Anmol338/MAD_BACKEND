import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paila_kicks/core/ui.dart';
import 'package:paila_kicks/logic/cubits/user_cubit/user_cubit.dart';
import 'package:paila_kicks/logic/cubits/user_cubit/user_state.dart';
import 'package:paila_kicks/presentation/screens/auth/providers/login_provider.dart';
import 'package:paila_kicks/presentation/screens/auth/signup_screen.dart';
import 'package:paila_kicks/presentation/screens/splash/splash_screen.dart';
import 'package:paila_kicks/presentation/widgets/gap_widget.dart';
import 'package:paila_kicks/presentation/widgets/link_button.dart';
import 'package:paila_kicks/presentation/widgets/primary_button.dart';
import 'package:paila_kicks/presentation/widgets/primary_textfield.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: provider.formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Image(
                  image: AssetImage("assets/img/Applogo.png"),
                  height: 200,
                ),
                Center(child: Text("Log In", style: TextStyles.heading2,)),
                const GapWidget(),
                PrimaryTextField(
                  controller: provider.emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email address filed cannot be null!";
                    }

                    if (!EmailValidator.validate(value.trim())) {
                      return "Please enter your valid email address!";
                    }

                    return null;
                  },
                  labelText: "Email Address",
                ),
                const GapWidget(),
                PrimaryTextField(
                  controller: provider.passwordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password is required!";
                    }

                    return null;
                  },
                  labelText: "Password",
                  obsecureText: true,
                ),
                const GapWidget(
                  size: -10,
                ),
                (provider.error != "")
                    ? Text(
                        provider.error,
                        style: const TextStyle(color: Colors.red),
                      )
                    : const GapWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LinkButton(
                      text: "Forgot Password?",
                      onPressed: () {},
                      color: Colors.blue,
                    ),
                  ],
                ),
                const GapWidget(),
                PrimaryButton(
                  onPressed: provider.logIn,
                  text: (provider.isLoading) ? "..." : "Log In",
                ),
                const GapWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    const GapWidget(),
                    LinkButton(
                      text: "Sign Up",
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.pushNamed(context, SignupScreen.routName);
                      },
                    ),
                  ],
                ),
                const GapWidget(
                  size: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or LogIn with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LOGIN with google
                    SignInButton.mini(
                      buttonType: ButtonType.google,
                      onPressed: () {},
                    ),

                    SignInButton.mini(
                      buttonType: ButtonType.facebook,
                      onPressed: () {},
                    ),

                    SignInButton.mini(
                      buttonType: ButtonType.apple,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
