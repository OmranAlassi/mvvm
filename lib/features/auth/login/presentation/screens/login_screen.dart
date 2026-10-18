import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm/core/const/colors_const.dart';

import '../../../../../common/widgets/app_container.dart';
import '../../../../../common/widgets/app_snack_bar.dart';
import '../../../../../common/widgets/app_text_formfield.dart';
import '../widgets/custom_elevated_button.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(resizeToAvoidBottomInset: true, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          AppSnackBar.showSuccess(context, "success");
          context.push(AppRouteConst.home);
        } else if (state is LoginError) {
          AppSnackBar.showError(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                  key: loginKey,
                  child: Column(
                    spacing: 8,
                    children: [
                      AppContainer(text1: 'Hello.', text2: 'Welcome Back.'),
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
                              color: ColorsConst.appColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 14),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: state is LoginLoading
                            ? CircularProgressIndicator(
                                color: ColorsConst.appColor,
                              )
                            : CustomElevatedButton(
                                onPressed: () {
                                  if (loginKey.currentState!.validate()) {
                                    context.read<LoginCubit>().login(
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'Sign In',
                              ),
                      ),
                      Spacer(flex: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorsConst.appColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
