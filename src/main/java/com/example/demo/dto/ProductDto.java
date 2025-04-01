package com.example.demo.dto;

import lombok.Data;

@Data
public class ProductDto {
   private int id,price,halin,su,baeprice,baeday,juk,pansu,sales,review;
   private String pcode,pimg,dimg,title,writeday,salesDay;
   private double star;
   
   // 배송예정일 필드
   private String baedayStr;
   
   // 별점관련
   private int gstar,hstar,ystar;
   
   // 상품금액, 할인금액, 적립금을 저장할 문자열변수 (Str은 콤마때문에 넣은 변수)
   private String priceStr, halinPriceStr, jukPriceStr, baePriceStr;
   
   // 장바구니 날짜가 오늘날짜와 같은지 여부를 저장
   private int wchk;
}
