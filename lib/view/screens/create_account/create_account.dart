import '../../../res/import/import.dart' hide context;

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with Validators {
  bool password = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
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
    phoneController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  void register() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (_formKey.currentState!.validate()) {
      _authenticationBloc.add(
        SignupEvent(
          email: emailController.text,
          password: passwordController.text,
          fullName: fullNameController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is SignupError) {
            showErrorToast(message: state.error, context: context);
          }
          if (state is SignupSuccess) {
            showSuccessToast(
                message: FlutterI18n.translate(
                    context, 'account_created_successfully'),
                context: context);
            context.goNamed(RouteNames.login);
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('Onboarding_bg1'.mobilepng),
            fit: BoxFit.fill,
          )),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
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
                      child: SvgPicture.asset('arrow_back'.mobilesvg),
                    ),
                  ),
                ),
                Padding(
                  padding: REdgeInsets.only(top: 44),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: taskManagerSubColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                          key: _formKey,
                          child: Center(
                            child: Padding(
                              padding: REdgeInsets.fromLTRB(24, 18, 24, 18),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      FlutterI18n.translate(
                                          context, 'create_account'),
                                      style:
                                          TaskManagerTextStyle.size30.copyWith(
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
                                          'kindly_fill_up_this_form_and_let'),
                                      style:
                                          TaskManagerTextStyle.size12.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: taskManagerGrey,
                                      ),
                                    ),
                                  ),
                                  const YMargin(46),
                                  CustomTextFormField(
                                    obscureText: false,
                                    readonly: false,
                                    hintText: FlutterI18n.translate(
                                        context, 'full_name'),
                                    textInputType: TextInputType.name,
                                    fillColor: taskManagerTransparent,
                                    controller: fullNameController,
                                    validator: (val) => validateName(val),
                                  ),
                                  const YMargin(20),
                                  CustomTextFormField(
                                    obscureText: false,
                                    readonly: false,
                                    hintText: FlutterI18n.translate(
                                        context, 'email_address'),
                                    textInputType: TextInputType.emailAddress,
                                    controller: emailController,
                                    validator: (val) => validateEmail(val),
                                  ),
                                  const YMargin(20),
                                  CustomTextFormField(
                                    obscureText: password,
                                    readonly: false,
                                    hintText: FlutterI18n.translate(
                                        context, 'create_password'),
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
                                  const YMargin(72),
                                  BlocBuilder<AuthenticationBloc,
                                      AuthenticationState>(
                                    builder: (context, state) {
                                      return CustomButton(
                                        title: FlutterI18n.translate(
                                            context, 'create_account'),
                                        loadingState: state is Loading,
                                        onPressed: () => register(),
                                      );
                                    },
                                  ),
                                  const YMargin(32),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: FlutterI18n.translate(context,
                                              'already_have_an_account'),
                                          style: TaskManagerTextStyle.size12
                                              .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: taskManagerBlack,
                                          ),
                                        ),
                                        TextSpan(
                                          text: FlutterI18n.translate(
                                              context, 'sign_in'),
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
                                ],
                              ),
                            ),
                          )),
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
