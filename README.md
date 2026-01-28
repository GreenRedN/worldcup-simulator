# WORLD CUP SIMULATION SYSTEM (64 Teams) ⚽🏆

브라우저에서 동작하는 **월드컵 시뮬레이션 시스템**입니다.  
**대륙별 예선 → 본선 64강 → 1·2차 조별리그 → 토너먼트(16강~결승)**까지 전 과정을 제공합니다.

- 사용자는 경기 결과(스코어)만 **수기 입력**
- 시스템은 **순위/진출/대진표**를 규칙에 따라 **자동 계산**
- 개최국 여부에 따른 예선 티켓 조정(-1 처리) 및 와일드카드 규칙 포함
- 진행 상태는 브라우저 **LocalStorage**에 저장되어 페이지 이동/새로고침 후에도 유지

✅ **규칙 최종 기준:** `docs/규칙.txt` (임의 변경 없이 해당 명세를 기준으로 설계/구현)  
✅ Spring Boot는 **정적 리소스 제공(웹서버)** 역할이며, 실제 화면/로직은 `static` 내 HTML/JS로 구성됩니다.

---

## Documentation 📄

- `docs/WORLD CUP SIMULATION SYSTEM.pdf` : 시스템 개요/구성/흐름/설계 의도 문서
- `docs/규칙.txt` : 개최국 선정, 대륙별 예선 티켓/와일드카드, 본선 시드/조추첨/대진 매핑 등 **규칙 명세서(스펙)**

> “규칙이 무엇인지”의 최종 기준은 `docs/규칙.txt`입니다.

---

## Requirements 🧩

- Java 21
- Spring Boot 3.x
- Maven Wrapper 포함 (`mvnw`, `mvnw.cmd`)

---

## Quick Start 🚀

### 1) Run

**Mac / Linux**
```bash
./mvnw spring-boot:run
```

**Windows**
```bat
mvnw.cmd spring-boot:run
```

### 2) Open

기본 포트는 `8083`입니다.

- Home: `http://localhost:8083/home.html`

> 포트 변경: `src/main/resources/application.properties`의 `server.port` 수정

---

## Recommended Flow 🧭

아래 순서대로 진행하는 것을 권장합니다.

1. `home.html`에서 시작
2. `host.html`에서 **대회 번호 입력 → 개최국 확정/저장**
3. 대륙별 예선 페이지에서  
   - 조추첨 → 경기 결과 입력 → 순위 자동 계산 → **진출팀 저장**
4. `worldcup.html`에서 **본선 64팀 로드**  
   - 시드 배정/조추첨 → 1차 조별 → 2차 조별 → 토너먼트 진행

---

## Features ✨

### 1) Host Selection (개최국 선정)
- 대회 번호 기반 개최 대륙 로테이션 및 개최국 선정
- 선정 결과를 저장하여 예선/본선에 반영

### 2) Qualifiers (대륙별 예선)
- AFC / UEFA / CAF / CONCACAF / CONMEBOL / OFC 예선 페이지 제공
- 조추첨, 경기표 생성, 결과 입력, 자동 순위 계산
- 개최국이 해당 대륙인 경우 **규칙에 따른 예외 처리(티켓 조정 등)** 적용
- 예선 결과를 본선 진출 팀 목록으로 저장

### 3) Finals (본선 64강)
- `data/fifa_ranking.json` 기반 팀 정보/랭킹 매핑
- 규칙에 따른 시드 배정 및 조추첨
- **대륙 중복 제한** 규칙 적용 (세부 조건은 `docs/규칙.txt` 기준)
- 1차 조별리그 → 2차 조별리그 → 토너먼트 자동 생성
- 무승부 시 PK 입력 지원

### 4) Auto Calculation (자동 계산)
- 승점/득실/순위/진출 여부 자동 반영
- 다음 라운드 진출팀 자동 편성
- 토너먼트 대진 자동 구성(규칙 기반 매핑)

### 5) Persistence (상태 저장)
- 진행 상태는 브라우저 **LocalStorage**에 저장되어 새로고침/이동 후에도 유지됩니다.

---

## Project Structure 🗂️

정적 리소스는 아래 경로에 위치합니다.

```
src/main/resources/static/
  home.html
  host.html
  afc.html
  uefa.html
  caf.html
  concacaf.html
  concacaf.html
  conmebol.html
  ofc.html
  worldcup.html
  data/
    fifa_ranking.json
  flags/
    (국기 SVG 리소스)
```

- `host.html` : 개최국 선정 및 저장
- `afc.html / uefa.html / ...` : 대륙별 예선 진행(조/경기/순위/진출 저장)
- `worldcup.html` : 본선 64강 진행(시드/조추첨/조별/토너먼트)

---

## Data 🧾

- `src/main/resources/static/data/fifa_ranking.json`  
  - 팀 코드(code), 대륙(confed), 랭킹/포인트 등 시드/본선 정보 매핑에 사용

---

## LocalStorage 🔑

페이지 이동/새로고침 후에도 진행 상황이 유지되도록 브라우저 LocalStorage를 사용합니다.

- 개최국 정보
- 예선 진출팀 목록(본선 슬롯)
- 본선 64팀 목록
- 라운드 진행 상태 등

초기화가 필요하면 브라우저 개발자도구에서  
`localhost:8083`의 LocalStorage 항목을 삭제(또는 전체 사이트 데이터 삭제)하세요.

---

## Build 🛠️

```bash
./mvnw clean package
```

실행(JAR):
```bash
java -jar target/*.jar
```

---

## Troubleshooting 🧯

### 1) HTML을 더블클릭으로 열면 동작이 이상해요
JSON 로드(fetch) 등이 포함되어 있으므로 **반드시 Spring Boot로 실행**해  
`http://localhost:8083/home.html`로 접속해야 정상 동작합니다.

### 2) 64팀이 안 채워졌다고 나와요
- 각 예선 페이지에서 **진출팀 저장**을 완료했는지 확인하세요.
- 본선은 **정확히 64팀**이 준비되어야 시작됩니다(규칙 기반).

### 3) 조추첨 실패(배치 불가) 메시지가 떠요
본선 조추첨은 **대륙 중복 제한** 조건을 만족해야 합니다.  
팀 구성이 제한을 만족하지 못하면 배치가 실패할 수 있으며, 제한 조건/예외는 `docs/규칙.txt` 기준입니다.

---

## License / Usage 📌

- 개인 포트폴리오 및 학습 목적으로 제작되었습니다.
- 상업적 사용 또는 2차 배포가 필요할 경우 작성자와 협의가 필요합니다.
