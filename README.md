## EngIng - 영어학습 및 일기
기존의 읽기 중심 영어 학습에서 벗어나, 영어로 직접 말하고 글을 쓰며 배울 수 있는 앱입니다.
<br/>

## 프로젝트 환경
- 개발 인원:
  - 1명
- 개발 기간:
  - 24.09.12 - 24.10.02 (약 3주)
- 최소 버전:
  - iOS 16.0
<br/>

## 기술 스택 및 라이브러리
- UI:
  - SwiftUI, Shufflelt, Lottie
- Architecture:
  - MVVM / InOut
- Reactive:
  - Combine
- Network:
  - Alamofire
- Database:
  - Realm
- Audio:
  - AvFoundation, Google Text-to-Speech  
<br/>

## 핵심 기능
- 주간 학습량 및 출석 체크
- 전체 달성률 확인
- 각 카테고리 별 문장 학습
- 문장 저장 / 음성 듣기
- 영어 일기 작성 / 저장 기능
- 문장 번역 및 음성 듣기
<br/>
 
## 핵심 기술 구현 사항
- Network
  - Alamofire의 URLRequestConvertible 프로토콜을 채택한 TargetType 프로토콜과 이를 사용한 라우터 패턴을 정의해 다양한 네트워크 통신을 처리
  - Google TTS와 같이 시간이 오래 걸릴 수 있는 통신에 대응하기 위해 NetworkManager를 비동기로 구현
 
- Database
  - 약 400개의 한국어/영어 문장 셋을 저장하고 카테고리-챕터-문장 테이블 간의 1대 다 구조 작업에 용이한 Realm을 사용
  - Realm Repository를 사용하여 여러 테이블에서 사용되는 데이터 처리 로직을 재사용

- Charts
  - ㅇㅇㅇ

- Google Text-To-Speech
  - 텍스트의 문맥을 고려하고 억양, 속도 등을 조절하여 자연스럽게 구현한 WaveNet 음성 모델을 채택
  - 2.4kHz의 샘플링 주파수를 사용하여 높은 음질을 제공
  
<br/>

## 트러블 슈팅
### 1. borderWidth와 c
- 상황
  - 캘린더에서 날짜를 눌렀을 때 캘린더뷰에서는 눌린 날짜에 색을 다르게 하고 다이어리뷰에서는 해당 날짜의 일기를 Realm으로 부터 가져와서 보여주는 역할을 한다.

- 원인 분석
  - 캘린더뷰와 다이어리뷰는 동일한 Input

- 해결

### 2. ViewModel에서 Realm의 데이터를 수정하였지만 View에서 @ObservedResults로 선언된 변수가 변경사항을 인지하지 못하는 문제
- 상황
  - 각 chapter에는 좋아요 기능이 있고 좋아요 버튼을 누를 때 마다 ChapterTable의 like값이 true, false로 바뀐다.
  - like값이 변경될 때 마다 view에서 변화를 감지하고 렌더링하기 위해 ObservedResults로 선언해 주었지만 업데이트가 되지 않는다.

- 원인 분석
  - @ObservedResults는 ViewModel에서 Realm에 저장된 데이터가 수정된 것을 관찰하지 못한다. 그렇기 때문에 view에도 렌더링이 일어나지 않는다.

- 해결
  - ViewModel에 @Published로 선언되어 있는 Output 구조체를 이용하여 새로운 프로퍼티를 만들어 주었다.
  - ChapterTable의 like값이 바뀔 때 마다 rendering 변수에 트리거를 주어 뷰에 업데이트가 되도록 만들어 주었다.
  <br/>

  ```swift
  struct Output {
      var selectedCategory = CategoryTable()
      var rendering: Void = ()
  }

  input.starButtonTap
      .sink { [weak self] value in
          guard let self else { return }
          repoChapter.updateItem(primaryKey: value.id) { value in
              value.star.toggle()
              self.output.rendering = ()
          }
      }
      .store(in: &cancellables)
  ```










