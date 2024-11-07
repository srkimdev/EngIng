# EngIng - 영어학습 및 일기
> 기존의 읽기 중심 영어 학습에서 벗어나, 영어로 직접 말하고 글을 쓰며 배울 수 있는 앱입니다.
<br/>

## 스크린샷

|![Simulator Screenshot - iPhone 15 Pro - 2024-10-18 at 21 03 28](https://github.com/user-attachments/assets/2225d170-84e8-4238-a71d-c3ae12810510)|![Simulator Screenshot - iPhone 15 Pro - 2024-10-18 at 21 03 36](https://github.com/user-attachments/assets/8e9a571b-119c-4548-aac2-0db09494d656)|![Simulator Screenshot - iPhone 15 Pro - 2024-10-18 at 21 05 26](https://github.com/user-attachments/assets/041054a8-95f2-4ea0-91fa-b77a0f5a365a)|![Simulator Screenshot - iPhone 15 Pro - 2024-10-18 at 21 05 16](https://github.com/user-attachments/assets/6a3488b3-4485-4eec-9d33-783a6ef5a7f9)|
|--|--|--|--|

<br>

## 프로젝트 환경
- 개발 인원:
  - 1명
- 개발 기간:
  - 24.09.12 - 24.10.02 (약 3주)
- 개발 환경:

  | iOS version | <img src="https://img.shields.io/badge/iOS-16.0+-black?logo=apple"/> |
  |:-:|:-:|
  | Framework | SwiftUI |
  | Architecture | MVVM |
  | Reactive | Combine |

<br/>

## 기술 스택 및 라이브러리
- UI: `Shufflelt`, `Lottie`
- Network: `Alamofire`
- Database: `Realm`
- Audio: `AvFoundation`, `Google Text-to-Speech`
  
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

- ### Network
  - Alamofire의 URLRequestConvertible 프로토콜을 채택한 TargetType 프로토콜과 이를 사용한 라우터 패턴을 정의해 다양한 네트워크 통신을 처리
  - NetworkManager를 비동기 함수로 처리하여 번역이나 TTS같이 여러 작업을 비동기적으로 동시에 실행하고, 각 작업이 완료될 때까지 기다린 후 결과를 처리하도록 설계
 
- ### Database
  - 약 400개의 한국어/영어 문장 셋을 저장하고 카테고리-챕터-문장 테이블 간의 1대 다 구조 작업에 용이한 Realm을 사용
  - Realm Repository를 사용하여 여러 테이블에서 사용되는 데이터 처리 로직을 재사용

- ### Google Text-To-Speech

  - iOS에는 AVFoundation 라이브러리를 통해 TTS기능을 제공해주고 있지만 기계음같은 부자연스러운 부분이 있어 사용자들에게 문장의 억양이나 속도등의 요소들을 정확하게 알려줄 수 없다.
  - 영어문장을 사람과 비슷한 자연스러운 음성 오디오 데이터를 제공하는 Google Text-To-Speech API를 이용하였다.

  <p align="center">
  <img width="350" alt="스크린샷 2024-10-16 오후 6 34 16" src="https://github.com/user-attachments/assets/afee93a4-5271-4763-98d1-0bbbb5db31ff">
  <br>
  x축  
  차트 y축 값은 각 음성의 자연스러움의 기준을 1 ∼ 5점을 척도로 Mean Opinion Score를 계산하여 나타낸다. 
  </p>

  - Google TTS에서 지원하는 여러 모델 중 MOS점수가 인간의 소리와 가장 비슷한 WaveNet 모델을 채택하였다.
  - WaveNet모델은 초당 24kHz로 샘플링하여 더 높은 음질을 얻을 수 있다.

<br/>

## 트러블 슈팅
### 1. RoundedRectangle과 border를 같이 쓸 때 모서리 부분에는 테두리가 반영되지 않는 문제
- 상황
  - 모서리가 둥글고 테두리가 있는 뷰를 만들 때, RoundedRectangle로 모서리가 둥근 사각형을 만든 후 border modifier로 테두리를 설정하면 모서리부분은 반영되지 않아 직사각형으로 보여진다.

- 원인 분석
  - border modifier는 특정 모양의 경계에 적용되지 않고 view의 프레임 전체에 적용한다. 따라서 모양의 경계에 적용되는 modifier를 사용해 줄 필요가 있다.

- 해결
  - 모양의 경계선을 그리는 데 사용되는 stroke modifier를 이용하여 테두리를 구성해주었다.

 ```swift
  RoundedRectangle(cornerRadius: 10)
      .stroke(.black, lineWidth: 1)
      .overlay {
          Image(systemName: "folder")
              .foregroundStyle(.black)
      }
  ```

<br>

### 2. ViewModel에서 Realm의 데이터를 수정하였지만 View에서 @ObservedResults로 선언된 변수가 변경사항을 인지하지 못하는 문제
- 상황
  - 각 chapter에는 좋아요 기능이 있고 좋아요 버튼을 누를 때 마다 ChapterTable의 like값이 true, false로 바뀐다.
  - like값이 변경될 때 마다 view에서 변화를 감지하고 렌더링하기 위해 ObservedResults로 선언해 주었지만 업데이트가 되지 않음

- 원인 분석
  - @ObservedResults는 ViewModel에서 Realm에 저장된 데이터가 수정된 것을 관찰하지 못한다. 그렇기 때문에 view에도 렌더링이 일어나지 않음.

- 해결
  - ViewModel에 @Published로 선언되어 있는 Output 구조체를 이용하여 새로운 프로퍼티를 만들어 주었다.
  - ChapterTable의 like값이 바뀔 때 마다 rendering 변수에 트리거를 주어 뷰에 업데이트가 되도록 만들어 주었다.
  <br/>

  ```swift
  struct Output {
      var selectedCategory = CategoryTable()
      var rendering: Void = ()
  }

  input.likeButtonTap
      .sink { [weak self] value in
          guard let self else { return }
          repoChapter.updateItem(primaryKey: value.id) { value in
              value.star.toggle()
              self.output.rendering = ()
          }
      }
      .store(in: &cancellables)
  ```










