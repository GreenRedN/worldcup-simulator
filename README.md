# worldcup-simulator  
World Cup simulation project (Spring Boot + Java)

팀별 스탯 기반으로 월드컵 경기를 시뮬레이션하는 프로젝트입니다.  
라운드 로직 기반으로 일정이 자동 생성되며, 경기마다 확률 계산을 통해 결과가 산출됩니다.  
Spring MVC + Thymeleaf 기반으로 구현되었습니다.

---

## 🚩 Features

### ✔ 팀 스탯 기반 경기 시뮬레이션
- 공격력, 수비력 등 팀 능력치를 기반으로 경기 결과 확률 계산  
- 확률적 이벤트 반영으로 매 경기 다른 결과 발생  

### ✔ 라운드 로직 적용
- 라운드별 매칭 자동 생성  
- 각 경기 결과에 따라 순위 갱신  

### ✔ Spring MVC + Thymeleaf 구조
- Controller / Service / Model 계층 분리  
- HTML 템플릿을 통한 UI 구현  

---

## 🚀 How to Run

1. Clone or download this repository  
2. Unzip **worldcup-simulator.zip**  
3. Run the application using:

### macOS / Linux
```bash
./mvnw spring-boot:run
```
### Windows
```bash
mvnw.cmd spring-boot:run
```
### Open your browser and visit:
```text
http://localhost:8083/home.html
```

## Project Structure
```text
worldcup-simulator/
 ├─ src/
 │   ├─ main/java/... (Controller, Service, Model)
 │   ├─ main/resources/templates (HTML)
 │   └─ main/resources/static (CSS/JS)
 ├─ pom.xml
 ├─ mvnw / mvnw.cmd
 └─ README.md
```

## Tech Stack
Language: Java  
Framework: Spring Boot, Spring MVC  
Template Engine: Thymeleaf  
Build Tool: Maven
