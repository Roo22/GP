abstract class RegisterStates {}
class RegisterInitialState extends RegisterStates {}
class RegisterLoadingState extends RegisterStates {}
class RegisterSuccessState extends RegisterStates {}
class RegisterErrorState extends RegisterStates {
  late String error;
  RegisterErrorState(this.error);
}
class CreateUserSuccessState extends RegisterStates {}
class CreateUserErrorState extends RegisterStates {
  late String error;
  CreateUserErrorState(this.error);
}
class ChangeRegisterPasswordVisibilityState extends RegisterStates {}
class changeUserTypeState extends RegisterStates {}