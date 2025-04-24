import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spender_tracker/core/failure/failure.dart';
import 'package:spender_tracker/core/model/either.dart';
import 'package:spender_tracker/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:spender_tracker/features/auth/domain/model/user_model.dart';
import 'package:spender_tracker/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, UserModel>> loginWithGoogle() async{
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return Either.left(AuthFailure(message: "Sign-in cancelled by user."));
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      final firebaseCredentials = await FirebaseAuth.instance.signInWithCredential(credential);

      final firebaseToken = await firebaseCredentials.user?.getIdToken();

      final request = await authRemoteDatasource.loginWithGoogle(firebaseToken!);
      return Either.right(request);
    }
    on DioException catch (e) {
      return Either.left(AuthFailure(message: e.response?.data['error']));
    }
    on Exception {
      return Either.left(AuthFailure(message: "Auth failure"));
    }
  }

}