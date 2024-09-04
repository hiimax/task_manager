import '../../../res/import/import.dart' hide context;

class WelcomeBackScreen extends StatefulWidget {
  const WelcomeBackScreen({super.key});

  @override
  State<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends State<WelcomeBackScreen> with Validators {
  bool password = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late final AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = context.read<AuthenticationBloc>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void login() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (_formKey.currentState!.validate()) {
      _authenticationBloc.add(
        LoginEvent(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is LoginError) {
            showErrorToast(message: state.error, context: context);
          }
          if (state is LoginSuccess) {
            showSuccessToast(
                message:
                    FlutterI18n.translate(context, "logged_in_successfully"),
                context: context);

            context.goNamed(
              RouteNames.dashboard,
              extra: state.userModel,
            );
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('welcome_back_bg'.mobilepng),
            fit: BoxFit.fill,
          )),
          child: Column(
            children: [
              Padding(
                padding: REdgeInsets.fromLTRB(25, 133, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FlutterI18n.translate(context, "welcome_back"),
                      style: TaskManagerTextStyle.size30.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 28.sp,
                        color: taskManagerSplashColor,
                      ),
                    ),
                    const YMargin(14),
                    Text(
                      FlutterI18n.translate(
                          context, "we_are_glad_to_have_you_back"),
                      style: TaskManagerTextStyle.size16.copyWith(
                        fontWeight: FontWeight.w400,
                        color: taskManagerSplashColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: REdgeInsets.only(top: 47),
                  child: Container(
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        color: taskManagerSubColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child: Padding(
                          padding: REdgeInsets.fromLTRB(24, 46, 24, 40),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  obscureText: false,
                                  readonly: false,
                                  hintText:
                                      FlutterI18n.translate(context, "email"),
                                  // maxLength: 10,

                                  textInputType: TextInputType.number,

                                  controller: emailController,
                                  validator: (val) => validateEmail(val),
                                ),
                                const YMargin(20),
                                CustomTextFormField(
                                  obscureText: password,
                                  readonly: false,
                                  hintText: FlutterI18n.translate(
                                      context, "create_password"),
                                  textInputType: TextInputType.text,
                                  controller: passwordController,
                                  validator: (val) => validatePassword(val),
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          password = !password;
                                        });
                                      },
                                      child: password
                                          ? Image.asset(
                                              'eyes_off'.mobilepng,
                                              fit: BoxFit.none,
                                              width: 18.sp,
                                              height: 18.sp,
                                            )
                                          : const Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: taskManagerCountryColor,
                                            )),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        StatefulBuilder(
                                            builder: (context, setter) {
                                          return Checkbox(
                                              value: false,
                                              checkColor: taskManagerWhite,
                                              activeColor: taskManagerColor11,
                                              onChanged: (val) {
                                                setState(() {
                                                  // _checked = val!;
                                                });
                                              });
                                        }),
                                        Text(
                                          FlutterI18n.translate(
                                              context, "remember_me"),
                                          style: TaskManagerTextStyle.size12
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: taskManagerColor11),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .goNamed(RouteNames.forgetPassword);
                                      },
                                      child: Text(
                                        FlutterI18n.translate(
                                            context, "forgot_password"),
                                        style: TaskManagerTextStyle.size12
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: taskManagerColor11),
                                      ),
                                    ),
                                  ],
                                ),
                                const YMargin(72),
                                BlocBuilder<AuthenticationBloc,
                                    AuthenticationState>(
                                  builder: (context, state) {
                                    return CustomButton(
                                      loadingState: state is Loading,
                                      title: FlutterI18n.translate(
                                          context, "login"),
                                      onPressed: () => login(),
                                    );
                                  },
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'or',
                                    style: TaskManagerTextStyle.size16
                                        .copyWith(fontWeight: FontWeight.w400),
                                  ),
                                ),
                                const YMargin(32),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: FlutterI18n.translate(
                                            context, "dont_have_an_account"),
                                        style: TaskManagerTextStyle.size12
                                            .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: taskManagerBlack,
                                        ),
                                      ),
                                      TextSpan(
                                        text: FlutterI18n.translate(
                                            context, "sign_up"),
                                        style: TaskManagerTextStyle.size12
                                            .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: taskManagerPrimaryColor,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            context.goNamed(RouteNames.signup);
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
