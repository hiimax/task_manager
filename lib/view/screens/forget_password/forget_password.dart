import '../../../res/import/import.dart' hide context;

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with Validators {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  late final AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = context.read<AuthenticationBloc>();
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  void reset() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (_formKey.currentState!.validate()) {
      _authenticationBloc.add(
        ResetPasswordEvent(
          email: emailController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is ResetPassowrdError) {
            showErrorToast(message: state.error, context: context);
            print(state.error);
          }
          if (state is ResetPassowrdSuccess) {
            showSuccessToast(message: state.message, context: context);

            context.goNamed(RouteNames.login);
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/mobile/Onboarding_bg1.png'),
            fit: BoxFit.fill,
          )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: REdgeInsets.fromLTRB(24, 75, 0, 0),
                      child: SvgPicture.asset('assets/svg/arrow_back.svg'),
                    ),
                  ),
                ),
                Padding(
                  padding: REdgeInsets.only(top: 47),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        color: taskManagerSubColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child: Padding(
                          padding: REdgeInsets.fromLTRB(24, 46, 24, 18),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  FlutterI18n.translate(
                                      context, "forgot_password"),
                                  style: TaskManagerTextStyle.size30.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 28.sp,
                                    color: taskManagerColor2,
                                  ),
                                ),
                              ),
                              const YMargin(16),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  FlutterI18n.translate(context,
                                      "kindly_enter_your_email_phone_number_to_receive_password_reset_option"),
                                  style: TaskManagerTextStyle.size12.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: taskManagerGrey,
                                  ),
                                ),
                              ),
                              const YMargin(41),
                              CustomTextFormField(
                                obscureText: false,
                                readonly: false,
                                hintText: FlutterI18n.translate(
                                    context, "email_phone_number"),
                                textInputType: TextInputType.emailAddress,
                                controller: emailController,
                                validator: (val) => validateEmail(val),
                              ),
                              const YMargin(30),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: FlutterI18n.translate(
                                            context, "remember_your_password"),
                                        style: TaskManagerTextStyle.size12
                                            .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: taskManagerBlack,
                                        ),
                                      ),
                                      TextSpan(
                                        text: FlutterI18n.translate(
                                            context, "sign_in"),
                                        style: TaskManagerTextStyle.size12
                                            .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: taskManagerPrimaryColor,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            context.goNamed(RouteNames.login);
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const YMargin(299),
                              BlocBuilder<AuthenticationBloc,
                                  AuthenticationState>(
                                builder: (context, state) {
                                  return CustomButton(
                                    loadingState: state is Loading,
                                    title: FlutterI18n.translate(
                                        context, "continue"),
                                    onPressed: () => reset(),
                                  );
                                },
                              ),
                            ],
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
      ),
    );
  }
}
