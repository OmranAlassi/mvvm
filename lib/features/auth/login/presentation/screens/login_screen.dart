import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm/common/widgets/app_text_formfield.dart';

import '../../../../../core/routes/app_route_const.dart';
import '../../../../../core/utils/validators.dart';
import '../../manger/cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = .new();
  final GlobalKey<FormState> loginKey = .new();
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("success")));
          context.push(AppRouteConst.home);
        } else if (state is LoginError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context)
                  .copyWith(overscroll: false),
              child: CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Form(
                      key: loginKey,
                      child: Column(
                        spacing: 8,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 260,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(70),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 14),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hello.',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Welcome Back.',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(14),
                            //! The AppTextFormfield is Componet 
                            child: AppTextFormfield(
                              validator: (value) => Validators.phone(value),
                              controller: phoneController,
                              hintText: 'Phone Number',
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Forget Password?',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 14),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: state is LoginLoading
                                ? CircularProgressIndicator(color: Colors.blue)
                                : ElevatedButton(
                                    onPressed: () {
                                      if (loginKey.currentState!.validate()) {
                                        context.read<LoginCubit>().login(
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      minimumSize: const Size(
                                        double.infinity,
                                        50,
                                      ),
                                      shape: const StadiumBorder(),
                                      elevation: 4,
                                      // ignore: deprecated_member_use
                                      shadowColor: Colors.grey.withOpacity(0.5),
                                    ),
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
