class ValidatorUtils {
  static String? validatorId(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "아이디를 입력해 주세요";
    }
    return null;
  }

  static String? validatorNickname(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "닉네임을 입력해 주세요";
    }
    return null;
  }

  static String? validatorPassword(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "비밀번호를 입력해 주세요";
    }
    return null;
  }
}
