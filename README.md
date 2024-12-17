# 🏃‍➡️ SprinChat

**Sprint + Chat**
스프린챗에서 러닝 크루와 대화하고, 달리기를 분석하고, 최고기록을 경신해보세요.

개발 환경 : `Flutter`  
DB 제공 : `Firebase`

사용 API : `네이버 API`, `브이월드 API`, `카카오 API`

## 💡 프로젝트 소개

### ⏱️ 프로젝트 기간

`2024. 12. 12 - 2024. 12. 17`

### 👥 개발 멤버

- 김혜지 : 회원가입 및 로그인 기능
- 선우진 : 홈 페이지, 페이지 이동
- 홍의정 : 러닝 분석 기능
- 황상진 : 데이터베이스 관리, 채팅 기능

### 🛠️ 기술 스택

| Technologies | Tools                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 언어         | <img src="https://img.shields.io/badge/dart-#0175C2?style=for-the-badge&logo=dart&logoColor=white/">                                                                                                                                                                                                                                                                                                                                                                                                                        |
| 프레임워크   | <img src="https://img.shields.io/badge/flutter-#02569B?style=for-the-badge&logo=flutter&logoColor=white/">                                                                                                                                                                                                                                                                                                                                                                                                                  |
| 에디터       | <img src="https://img.shields.io/badge/VSCode-#199ED9?style=for-the-badge/">                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| 협업         | <img src="https://img.shields.io/badge/Git-#F05032?style=for-the-badge&logo=Git&logoColor=white"> <img src="https://img.shields.io/badge/GitHub-#181717?style=for-the-badge&logo=GitHub&logoColor=white"> <img src="https://img.shields.io/badge/Fork-#00A1E0?style=for-the-badge>                                                                                                                                                                                                                                          |
| 라이브러리   | <img src="https://img.shields.io/badge/Firebase-#DD2C00?style=for-the-badge&logo=Firebase&logoColor=white"> <img src="https://img.shields.io/badge/GeoLocator-#00B274?style=for-the-badge"> <img src="https://img.shields.io/badge/ImagePicker-#ECD53F?style=for-the-badge"> <img src="https://img.shields.io/badge/Riverpod-#00CCBC?style=for-the-badge"> <img src="https://img.shields.io/badge/Lottie-#33FFC1?style=for-the-badge"> <img src="https://img.shields.io/badge/KakaomapWebView-#FFCD00?style=for-the-badge"> |

### 🗂️ 디렉토리 구조

<details>
  <summary> (Click!)디렉토리 구조 </summary>
📦lib

┣ 📂core  
 ┃ ┣ 📂viewmodel  
 ┃ ┃ ┣ 📂chat_viewmodel  
 ┃ ┃ ┃ ┗ 📜chat_viewmodel.dart  
 ┃ ┃ ┣ 📂location_viewmodel  
 ┃ ┃ ┃ ┗ 📜location_viewmodel.dart  
 ┃ ┃ ┗ 📂user_viewmodel  
 ┃ ┃ ┃ ┗ 📜user_viewmodel.dart  
 ┃ ┣ 📜geolocator_helper.dart  
 ┃ ┗ 📜validator_utils.dart  
 ┣ 📂data  
 ┃ ┣ 📂model  
 ┃ ┃ ┣ 📜chatmodel.dart  
 ┃ ┃ ┗ 📜user_model.dart  
 ┃ ┗ 📂repository  
 ┃ ┃ ┣ 📜chatrepository.dart  
 ┃ ┃ ┗ 📜user_repository.dart  
 ┣ 📂ui  
 ┃ ┣ 📂pages  
 ┃ ┃ ┣ 📂chatpage  
 ┃ ┃ ┃ ┣ 📂widgets  
 ┃ ┃ ┃ ┃ ┣ 📜chatswindow.dart  
 ┃ ┃ ┃ ┃ ┗ 📜inputmessage.dart  
 ┃ ┃ ┃ ┗ 📜chatpage.dart  
 ┃ ┃ ┣ 📂join  
 ┃ ┃ ┃ ┣ 📂widgets  
 ┃ ┃ ┃ ┃ ┗ 📜first_profile_image.dart  
 ┃ ┃ ┃ ┣ 📜join_page.dart  
 ┃ ┃ ┃ ┗ 📜join_view_model.dart  
 ┃ ┃ ┣ 📂login  
 ┃ ┃ ┃ ┣ 📜login_page.dart  
 ┃ ┃ ┃ ┗ 📜login_view_model.dart  
 ┃ ┃ ┣ 📂myhome  
 ┃ ┃ ┃ ┣ 📂widgets  
 ┃ ┃ ┃ ┃ ┣ 📜current_chat.dart  
 ┃ ┃ ┃ ┃ ┣ 📜home_location.dart  
 ┃ ┃ ┃ ┃ ┣ 📜nearby_chat.dart  
 ┃ ┃ ┃ ┃ ┣ 📜profile_image.dart  
 ┃ ┃ ┃ ┃ ┣ 📜recent_running.dart  
 ┃ ┃ ┃ ┃ ┗ 📜welcome_header.dart  
 ┃ ┃ ┃ ┣ 📜my_home.dart  
 ┃ ┃ ┃ ┗ 📜profile.dart  
 ┃ ┃ ┣ 📂presenchatpage  
 ┃ ┃ ┃ ┣ 📂widgets  
 ┃ ┃ ┃ ┃ ┣ 📜background.dart  
 ┃ ┃ ┃ ┃ ┣ 📜bottomwindow.dart  
 ┃ ┃ ┃ ┃ ┣ 📜fruit.dart  
 ┃ ┃ ┃ ┃ ┗ 📜hill.dart  
 ┃ ┃ ┃ ┗ 📜presenchatpage.dart  
 ┃ ┃ ┣ 📂result  
 ┃ ┃ ┃ ┣ 📂widgets  
 ┃ ┃ ┃ ┃ ┣ 📜result_box.dart  
 ┃ ┃ ┃ ┃ ┗ 📜update_result.dart  
 ┃ ┃ ┃ ┗ 📜result_page.dart  
 ┃ ┃ ┗ 📂running  
 ┃ ┃ ┃ ┣ 📂widgets  
 ┃ ┃ ┃ ┃ ┣ 📜button_view_model.dart  
 ┃ ┃ ┃ ┃ ┣ 📜running_analysis.dart  
 ┃ ┃ ┃ ┃ ┣ 📜running_button.dart  
 ┃ ┃ ┃ ┃ ┣ 📜running_information.dart  
 ┃ ┃ ┃ ┃ ┣ 📜time_information.dart  
 ┃ ┃ ┃ ┃ ┗ 📜unavailable_navigationbar.dart  
 ┃ ┃ ┃ ┣ 📜running_page.dart  
 ┃ ┃ ┃ ┗ 📜running_view_model.dart  
 ┃ ┗ 📂widgets  
 ┃ ┃ ┣ 📜id_text_form_field.dart  
 ┃ ┃ ┣ 📜navigation_bar.dart  
 ┃ ┃ ┣ 📜nickname_text_form_field.dart  
 ┃ ┃ ┗ 📜pw_text_form_field.dart  
 ┣ 📂widgets  
 ┃ ┗ 📜.gitkeep  
 ┣ 📜firebase_options.dart  
 ┣ 📜main.dart  
 ┗ 📜theme.dart

</details>

## 💡 어떻게 사용하나요?

> 로그인

- 아이디와 비밀번호는 영문과 숫자만 사용하여 구성합니다.
- 사용자 아이디는 중복으로 등록할 수 없습니다.
- 닉네임과 프로필 사진은 추후 변경 가능합니다.
- firebase DB의 `User` Collection에 데이터를 저장하였습니다.

> 홈

- 사용자 위치에서 가장 가까이 위치한 채팅방을 추천합니다.
- **프로필 사진**을 누르면 프로필을 편집하거나 계정에서 로그아웃할 수 있습니다.
- 가장 최근에 세운 달리기 기록을 확인할 수 있습니다.
- 하단의 네비게이션 바를 이용해 다른 페이지에 접근하세요.

> 채팅

- 사용자 위치를 기반으로 해당 행정구역에서 채팅방을 신설하거나 기존 채팅방에 참여합니다.
- 닉네임과 채팅 메시지, 전송 시간을 기록합니다.
- firebase DB의 `Chatroom` Collection에 데이터를 저장하였습니다.
- 내 지역의 러닝 크루와 실시간으로 대화를 나눠보세요.

> 러닝

- **러닝 시작**을 누르면 기록을 시작합니다.
- **러닝 종료**를 누르면 기록을 저장하고 결과 화면으로 이동합니다.
- 얼마나 오래 뛰었는지, 얼마만큼의 칼로리를 불태웠는지 확인하세요.
- 러닝을 마치고 나면 기록을 저장할 수 있습니다.
