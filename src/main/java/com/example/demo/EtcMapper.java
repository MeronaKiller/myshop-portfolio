package com.example.demo;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EtcMapper {
	public ArrayList<HolDto> getHoliday(String day);
}
