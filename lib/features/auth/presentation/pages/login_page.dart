import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jolly_podcast/core/constants/utils.dart';
import 'package:jolly_podcast/core/constants/validators.dart';
import 'package:jolly_podcast/core/widgets/snackbars.dart';
import 'package:jolly_podcast/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:jolly_podcast/features/auth/presentation/bloc/auth_event.dart';
import 'package:jolly_podcast/features/auth/presentation/bloc/auth_state.dart';
import 'package:jolly_podcast/features/auth/presentation/widgets/auth_button.dart';
import 'package:jolly_podcast/features/auth/presentation/widgets/jolly_textfield.dart';
import 'package:video_player/video_player.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  VideoPlayerController? _controller;
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;

  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/videos/intro_video.mp4')
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true)
      ..play();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var viewPassword = GestureDetector(
      onTap: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
      child: obscureText
          ? const Icon(Icons.remove_red_eye_outlined)
          : SvgPicture.asset(
              'assets/svg/crossed_eye.svg',
              fit: BoxFit.scaleDown,
            ),
    );

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocListener<AuthBloc, AuthState>(
          // * LISTENER
          listener: (context, state) {
            if (state is LoginUserLoading) {
              setState(() {
                isLoading = true;
              });
            } else if (state is LoginUserLoaded) {
              setState(() {
                isLoading = false;
              });
              showSuccessfulScaffoldMessage(context, 'Login successful');
              // Navigate to home screen
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is LoginUserError) {
              setState(() {
                isLoading = false;
              });
              showFailureScaffoldMessage(context, state.message);
            }
          },

          // * CHILD WIDGET
          child: Scaffold(
            body: Stack(
              children: [
                if (_controller!.value.isInitialized)
                  Positioned.fill(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller!.value.size.width,
                        height: _controller!.value.size.height,
                        child: VideoPlayer(_controller!),
                      ),
                    ),
                  ),

                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: SizedBox(
                    height: context.screenHeight,
                    child: Form(
                      key: formKeyLogin,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // * App Logo
                          Image.asset('assets/images/app_logo_image.png'),

                          // * Title
                          Text(
                            'PODCAST FOR AFRICA, BY AFRICANS',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 28),

                          // * Phone number textfield
                          JollyTextfield(
                            obscureText: false,
                            hintText: 'Enter Your Phone Number',
                            prefixIcon: Image.asset('assets/images/flag.png'),
                            controller: phoneNumberController,
                            keyboardType: TextInputType.phone,
                            validator: Validators.validatePhone(),
                          ),
                          const SizedBox(height: 20),

                          // * Password textfield
                          JollyTextfield(
                            obscureText: obscureText,
                            hintText: 'Enter Your Password',
                            controller: passwordController,
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: viewPassword,
                          ),
                          const SizedBox(height: 20),

                          // * Sign in button
                          AuthButton(
                            onTap: loginUser,
                            buttonText: 'Sign In',
                            isLoading: isLoading,
                          ),
                        ],
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

  void loginUser() {
    if (formKeyLogin.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginUserEvent(
          phoneNumber: phoneNumberController.text,
          password: passwordController.text,
        ),
      );
    }
  }
}
