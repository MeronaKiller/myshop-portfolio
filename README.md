# 🛒 spring-myshop-project

Spring Boot 기반 쇼핑몰 구현 프로젝트입니다.  
MyBatis와 JSP를 활용한 전통적인 MVC 패턴 구조로, 전자상거래 웹 서비스의 기본 흐름을 학습하고  
회원가입, 상품 목록, 장바구니, 주문 등 전반적인 기능을 직접 구현했습니다.

---

## 📷 화면 미리보기 (일부 예시 이미지)

<table>
  <tr>
    <td><img src="docs/images/aaa1.png" width="300"/></td>
    <td><img src="docs/images/aaa2.png" width="300"/></td>
  </tr>
  <tr>
    <td><img src="docs/images/aaa3.png" width="300"/></td>
    <td><img src="docs/images/aaa4.png" width="300"/></td>
  </tr>
</table>

> 위는 일부 대표 UI 예시입니다.  
> 더 많은 화면은 프로젝트를 직접 실행하거나 코드를 통해 확인하실 수 있습니다.

---

## 🧰 사용 기술

| 구분        | 기술 스택                                                                 |
|-------------|---------------------------------------------------------------------------|
| Language    | Java 17                                                                   |
| Framework   | Spring Boot 3.4.1, Spring MVC                                             |
| View        | JSP, JSTL, SiteMesh                                                      |
| ORM         | MyBatis                                                                  |
| DBMS        | MariaDB                                                                  |
| Mail        | JavaMail (javax.mail), Activation API                                     |
| Build Tool  | Maven                                                                    |
| 기타        | Lombok, Spring DevTools, GitHub                                           |

---

## 🔧 주요 기능 구현

### ✅ 회원 기능
- 회원가입 (중복 체크, 유효성 검사)
- 로그인 / 로그아웃
- 마이페이지 (주문내역 조회)
- 세션 기반 사용자 인증

### ✅ 상품 기능
- 상품 등록 / 수정 / 삭제 (관리자)
- 상품 리스트 (카테고리별, 정렬)
- 상품 상세 페이지

### ✅ 장바구니 기능
- 상품 장바구니에 담기 / 삭제 / 수량 변경
- 장바구니 목록 보기 (로그인 사용자별)

### ✅ 주문 기능
- 주문서 작성 (배송 정보, 적립금 사용)
- 배송비 계산
- 주문 완료 처리

### ✅ 기타 기능
- 이메일 발송 기능 (JavaMail)
- 공통 레이아웃 구성 (SiteMesh)
- JSTL 기반 템플릿 구성
- 마이바티스 매퍼 기반 DAO 구조

---

## 🗄 데이터베이스 SQL

📄 [DB SQL 보기](https://github.com/MeronaKiller/spring-myshop-project/blob/main/sql/myshop.sql)

> 테이블 생성 및 상품/회원 데이터 포함

---

## 📘 학습 노트 (Notion)

국비지원 학원 수강 중 작성한 **학습 정리 노트**입니다.  
개념 요약, 실습 코드, 오류 해결 경험 등을 정리했습니다.  
👉 [Notion 정리 보기](https://www.notion.so/183fec60ac96800a892fe328e0e980ef)

---

## 🛠 개발 환경

- IDE: Spring Tool Suite 4 (STS4)
- 서버: Apache Tomcat 10 (내장형)
- 버전 관리: Git, GitHub
- 데이터베이스 툴: DBeaver, HeidiSQL

---

## 🚀 실행 방법

```bash
# 1. 프로젝트 클론
git clone https://github.com/MeronaKiller/spring-myshop-project.git

# 2. STS4 또는 IntelliJ에서 Import → Maven Project

# 3. DB 연동 정보 설정 (application.properties)
# 예시: jdbc:mysql://localhost:3306/myshop

# 4. 내장형 Tomcat 10으로 서버 실행

---

🙋‍♂️ 개발자
MeronaKiller
🔗 GitHub 프로필 바로가기
