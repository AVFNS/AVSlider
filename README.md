# **AVSlider 사용 방법**

`AVSlider`는애플 스타일의 커스텀 UISlider를 UISlider를 상속받지 않고 개발한 것입니다.

https://github.com/AVFNS/AVSlider/assets/102890390/ace7900a-d8bc-4ff7-962a-ab0d019f356c


## **초기화**

`AVSlider`를 초기화하기

```swift
let slider = AVSlider(frame: CGRect(x: 0, y: 0, width: 330, height: 12))
```

이 코드는 너비가 330 포인트이고 높이가 12 포인트인 `AVSlider`를 생성합니다. 이후 필요에 따라 frame을 조정할 수 있습니다.

## **설정**

### **배경색 설정**

`AVSlider`의 배경색을 설정할 수 있습니다.:

```swift
slider.backgroundColor = UIColor.lightGray
```

### **프로그레스 바 색상 설정**

`AVSlider`의 프로그레스 바 색상을 설정합니다.:

```swift
slider.tintColor = UIColor.red
```

## **이벤트 처리**

`AVSlider`의 값을 변경하는 경우를 처리하려면 `valueChanged` 이벤트를 감지합니다:

```swift
slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)

@objc func sliderValueChanged(_ slider: AVSlider) {
    // 값 변경 시 처리할 작업 수행
}
```

## **사용자 정의 설정**

### **트래킹 모드 설정**

`AVSlider`의 트래킹 모드를 설정합니다. 가능한 옵션은 `.offset` 및 `.absolute`입니다:

```swift
slider.trackingMode = .absolute

```

### **확장 모드 설정**

`AVSlider`의 확장 모드를 설정합니다. 가능한 옵션은 `.onTouch` 및 `.onDrag`입니다:

```swift
slider.expansionMode = .onDrag

```

### **라벨 위치 추가**

`AVSlider`의 라벨 위치를 설정합니다. `top`과 `bottom`이 있습니다.

```swift
slider.setValueLabelPosition(.top)
```

## expansionMode의 관하여

`AVSlider`에서는 `onTouch`와 `onDrag`를 제공합니다.
`onTouch`는 터치를 해서 Slider를 제어할 수 있고 `onDrag`는 무조건 드레그를 해서만 사용할 수 있습니다.

```swift
$0.expansionMode = .onDrag
```

