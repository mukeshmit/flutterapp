
class LoginModel {
  dynamic status;
  dynamic message;
  SignInDataModel data;

  LoginModel(this.status, this.message, this.data);

  factory LoginModel.fromJson(dynamic json) {
    if(json['data']!=null){
      SignInDataModel dd = SignInDataModel.fromJson(json['data']);
      return LoginModel(json['status'], json['message'], dd);
    }else{
      return LoginModel(json['status'], json['message'], null);
    }
  }
}

class SignInModel {
  dynamic status;
  dynamic message;
  SignInDataModel data;
  dynamic token;

  SignInModel({this.status, this.message, this.data, this.token});

  SignInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new SignInDataModel.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class SignInDataModel {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic password;
  dynamic rememberToken;
  dynamic userPhone;
  dynamic deviceId;
  dynamic userImage;
  dynamic userCity;
  dynamic userArea;
  dynamic otpValue;
  dynamic status;
  dynamic wallet;
  dynamic rewards;
  dynamic isVerified;
  dynamic block;
  dynamic regDate;
  dynamic appUpdate;
  dynamic facebookId;
  dynamic referralCode;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic cityName;
  dynamic societyName;

  SignInDataModel(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.password,
        this.rememberToken,
        this.userPhone,
        this.deviceId,
        this.userImage,
        this.userCity,
        this.userArea,
        this.otpValue,
        this.status,
        this.wallet,
        this.rewards,
        this.isVerified,
        this.block,
        this.regDate,
        this.appUpdate,
        this.facebookId,
        this.referralCode,
        this.createdAt,
        this.updatedAt,
        this.cityName,
        this.societyName});

  SignInDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    rememberToken = json['remember_token'];
    userPhone = json['user_phone'];
    deviceId = json['device_id'];
    userImage = json['user_image'];
    userCity = json['user_city'];
    userArea = json['user_area'];
    otpValue = json['otp_value'];
    status = json['status'];
    wallet = json['wallet'];
    rewards = json['rewards'];
    isVerified = json['is_verified'];
    block = json['block'];
    regDate = json['reg_date'];
    appUpdate = json['app_update'];
    facebookId = json['facebook_id'];
    referralCode = json['referral_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cityName = json['city_name'];
    societyName = json['society_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['remember_token'] = this.rememberToken;
    data['user_phone'] = this.userPhone;
    data['device_id'] = this.deviceId;
    data['user_image'] = this.userImage;
    data['user_city'] = this.userCity;
    data['user_area'] = this.userArea;
    data['otp_value'] = this.otpValue;
    data['status'] = this.status;
    data['wallet'] = this.wallet;
    data['rewards'] = this.rewards;
    data['is_verified'] = this.isVerified;
    data['block'] = this.block;
    data['reg_date'] = this.regDate;
    data['app_update'] = this.appUpdate;
    data['facebook_id'] = this.facebookId;
    data['referral_code'] = this.referralCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['city_name'] = this.cityName;
    data['society_name'] = this.societyName ;
    return data;
  }
}
