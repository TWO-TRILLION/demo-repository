# 🏃‍➡️ SprinChat

**Sprint + Chat**
스프린챗에서 러닝 크루와 대화하고, 달리기를 분석하고, 최고기록을 경신해보세요.

개발 환경 : `Flutter`  
DB 제공 : `Firebase`

사용 API : `네이버 API`, `브이월드 API`, `카카오 API`

## 💡 프로젝트 소개

### ⏱️ 프로젝트 기간

`2024. 12. 06 - 2024. 12. 09`

### 👥 개발 멤버

- 김혜지 : 회원가입 및 로그인 기능
- 선우진 : 홈 페이지, 페이지 이동
- 홍의정 : 러닝 분석 기능
- 황상진 : 데이터베이스 관리, 채팅 기능

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

> 홈

> 채팅

> 러닝
