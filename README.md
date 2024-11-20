# PIC16F877A 기반 LED 제어 시스템

## 프로젝트 개요
이 프로젝트는 PIC16F877A 마이크로컨트롤러를 사용하여 버튼 입력과 LCD 디스플레이를 통해 LED 상태를 제어하는 간단한 임베디드 시스템입니다. 버튼을 누를 때마다 LED의 상태가 변경되며, LCD에는 "LED ON" 또는 "LED OFF"가 표시됩니다. 이 시스템은 어셈블리 언어로 작성되었습니다.

---

## 주요 기능
- **LED 제어**: 버튼 입력에 따라 LED 상태를 ON/OFF로 제어.
- **LCD 디스플레이**: LED 상태를 실시간으로 표시 ("LED ON" 또는 "LED OFF").
- **버튼 입력 처리**: 버튼의 누름 상태를 감지하고 동작 수행.
- **지연 함수 사용**: 안정적인 출력 및 디스플레이를 위한 딜레이 함수 구현.

---

## 사용된 핀 및 하드웨어 연결

| 핀 번호   | 사용 목적          | 설명                             |
|-----------|--------------------|----------------------------------|
| `PORTA,3` | LCD RS            | LCD 레지스터 선택 핀             |
| `PORTA,2` | LCD RW            | LCD 읽기/쓰기 제어 핀            |
| `PORTA,1` | LCD EN            | LCD Enable 핀                   |
| `PORTC,0` | 버튼 (BTN)        | 입력 버튼                       |
| `PORTD,0` | LED               | LED 출력                        |
| `PORTB`   | LCD 데이터 핀      | LCD에 데이터 전송               |

---

## 코드 설명

### 주요 어셈블리 함수
1. **INIT_LCD**: LCD 초기화 설정.
2. **CLR_LCD**: LCD 클리어 함수.
3. **DSP_DATA1, DSP_DATA2**: "LED ON" 또는 "LED OFF"를 LCD에 표시.
4. **DELAY 함수**: 딜레이를 추가하여 안정적인 동작 보장.
5. **PUT_LCD**: LCD에 데이터를 쓰는 함수.
6. **BUTTON 상태 처리**:
   - 버튼이 눌리면 LED를 켜고 "LED ON" 표시.
   - 버튼이 눌리지 않으면 LED를 끄고 "LED OFF" 표시.

### 동작 흐름
1. 시스템이 초기화되면 LCD가 초기화되고 기본 화면이 표시됩니다.
2. 버튼 입력이 감지되면 LED 상태를 토글하고 LCD에 현재 상태를 출력합니다.
3. 버튼이 눌렸을 때와 눌리지 않았을 때 각각 다른 메시지가 LCD에 표시됩니다.

---

## 설치 및 실행 방법

### 1. 준비물
- **PIC16F877A** 마이크로컨트롤러
- **LCD 디스플레이**
- **버튼 (스위치)**
- **LED**
- **컴파일러**: MPLAB X IDE와 XC8 컴파일러
- **회로 연결**: 위의 핀 연결표를 참고하여 회로를 구성합니다.

### 2. 코드 업로드
1. MPLAB X IDE를 사용하여 프로젝트를 생성합니다.
2. 이 코드를 `.asm` 파일로 저장하고 프로젝트에 추가합니다.
3. 코드를 빌드한 후 HEX 파일을 생성합니다.
4. 프로그래머(예: PICKIT 3)를 사용하여 HEX 파일을 PIC16F877A에 업로드합니다.

### 3. 실행
1. 시스템에 전원을 연결합니다.
2. 버튼을 눌러 LED의 상태를 제어하고, LCD에 표시되는 내용을 확인합니다.

---

## 동영상 시연

아래 링크를 통해 LED 제어 시스템의 동작 시연 영상을 확인할 수 있습니다:  
[![LED 제어 시스템 시연 영상](https://img.youtube.com/vi/VuTth8VdCoc/0.jpg)](https://www.youtube.com/watch?v=VuTth8VdCoc)

---

## 코드 구조

### 주요 레이블
- **MAIN**: 초기화 및 메인 루프
- **BTN_PRESSED**: 버튼이 눌렸을 때 동작
- **BTN_NOT_PRESSED**: 버튼이 눌리지 않았을 때 동작
- **DSP_DATA1**: "LED ON" 데이터 출력
- **DSP_DATA2**: "LED OFF" 데이터 출력
- **DELAY**: 지연 함수

### 주요 메모리 레지스터
| 레지스터 | 용도                     |
|----------|--------------------------|
| `COM_BUF` | LCD 명령어 버퍼          |
| `DATA_PTR`| 데이터 포인터            |
| `COUNT1`  | 딜레이 카운터 1         |
| `COUNT2`  | 딜레이 카운터 2         |
| `COUNT3`  | 딜레이 카운터 3         |

---

## 화면 예시

### LCD 디스플레이 출력
- 버튼 눌림 상태: `LED ON`  
- 버튼 비눌림 상태: `LED OFF`

---

## 개선 사항
1. **다중 버튼 추가**: 추가 버튼을 사용하여 더 많은 LED를 제어하거나 추가 기능 구현.
2. **PWM 제어**: LED 밝기를 조절할 수 있도록 PWM(Pulse Width Modulation) 기능 추가.
3. **유연한 메시지 표시**: LCD에 더 다양한 상태 메시지를 표시하도록 확장.