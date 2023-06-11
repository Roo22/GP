abstract class AppStates{}
class AppInitialState extends AppStates {}
class AppAddMarkerState extends AppStates {}
//class AppAddCustomMarkerState extends AppStates {}
class AppChangeBottomNavBarState extends AppStates {}
class AppChangeMapControllerState extends AppStates {}
class AppChangeSearchAddressState extends AppStates {}
class AppChangeMapViewState extends AppStates {}
class AppSearchSuccessState extends AppStates {}
class AppSearchErrorState extends AppStates {}
class AppChangeModeState extends AppStates {}

class AppPickImageFromGallerySuccessState extends AppStates {}
class AppPickImageFromGalleryErrorState extends AppStates {}
class AppPickImageFromCameraSuccessState extends AppStates {}
class AppPickImageFromCameraErrorState extends AppStates {}

class AppGetUserLoadingState extends AppStates {}
class AppGetUserSuccessState extends AppStates {}
class AppGetUserErrorState extends AppStates {}

class AppGetTrainerLoadingState extends AppStates {}
class AppGetTrainerSuccessState extends AppStates {}
class AppGetTrainerErrorState extends AppStates {}

class AppSignOutSuccessState extends AppStates {}
class AppSignOutErrorState extends AppStates {}

class AppUploadProfileImageSuccessState extends AppStates{}
class AppUploadProfileImageErrorState extends AppStates{}

class AppUploadCoverImageSuccessState extends AppStates{}
class AppUploadCoverImageErrorState extends AppStates{}

class AppUserUpdateSuccessState extends AppStates {}
class AppUserUpdateErrorState extends AppStates {}

class AppTrainerUpdateSuccessState extends AppStates {}
class AppTrainerUpdateErrorState extends AppStates {}

class AppRequestUpdateSuccessState extends AppStates {}
class AppRequestUpdateErrorState extends AppStates {}

class AppUserUpdateProfileLoadingState extends AppStates{}
class AppUserUpdateCoverLoadingState extends AppStates{}

class AppProfileImagePickedSuccessState extends AppStates{}
class AppProfileImagePickedErrorState extends AppStates{}

class AppCoverImagePickedSuccessState extends AppStates{}
class AppCoverImagePickedErrorState extends AppStates{}

class AppGetAllUsersSuccessState extends AppStates{}
class AppGetAllUsersErrorState extends AppStates{}

class AppGetAllTrainersSuccessState extends AppStates{}
class AppGetAllTrainersErrorState extends AppStates{}

class AppGetRequestsLoadingState extends AppStates{}
class AppGetRequestsSuccessState extends AppStates{}
class AppGetRequestsErrorState extends AppStates{}

class AppGetConnectionsSuccessState extends AppStates{}
class AppGetConnectionsErrorState extends AppStates{}


class AppSendRequestLoadingState extends AppStates{}
class AppSendRequestSuccessState extends AppStates{}
class AppSendRequestErrorState extends AppStates{
  late String error;
  AppSendRequestErrorState(this.error);
}

class AppSendHttpRequestSuccessState extends AppStates{}
class AppSendHttpRequestErrorState extends AppStates{}

class AppChangeWidgetVisibilityState extends AppStates{}

class AppGetCurrentLocationSuccessState extends AppStates{}
