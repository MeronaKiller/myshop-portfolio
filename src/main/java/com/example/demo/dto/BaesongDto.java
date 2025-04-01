package com.example.demo.dto;

import lombok.Data;

@Data
public class BaesongDto {
	private int id,gibon,req;
	private String userid,zip,juso,jusoEtc,phone,name;
	
	//배송요구사항
	private String reqStr;
	
	//member에서 수정이 올경우 저장할 변수
	private int ck;
}
