package com.example.demo.member;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.ReviewDto;

@Mapper
public interface MemberMapper {
    public Integer useridCheck(String userid);
    public void memberOk(MemberDto mdto);
    public ArrayList<ProductDto> cartView(String userid);
    public void cartDel(String id);
    public void chgSu(String id, String num);
    public ProductDto getProduct(String pcode);
    public ArrayList<ProductDto>  jjimList(String userid);
    public void jjimDel(String id);
    public void addCart(String userid,String pcode);
    public String getCartSu(String userid);
    public boolean isCart(String userid,String pcode);
    public void upCart(String userid,String pcode);
    public ArrayList<HashMap> jumunList(String userid,String start,String end,int month);
    public void chgState(GumaeDto gdto);
    public void reviewOk(ReviewDto rdto);
    public void chgReview(int id);
    public double avgStar(String pcode);
    public void chgStar(double avg,String pcode);
    public void upReview(String pcode);
    public void reviewDelete(String id);
    public void chgStar2(double avg,String pcode);
    public void setReview(String id);
    public ReviewDto getReview(String id);
    public void reviewUpdateOk(ReviewDto rdto);
    public MemberDto memberInfo(String userid);
    public void chgEmail(String email,String userid);
    public void chgPhone(String phone,String userid);
    public boolean isPwd(String userid,String pwd);
    public void chgPwd(String userid,String pwd);
    public ArrayList<BaesongDto> baesongList(String userid);
    public ArrayList<HashMap> reviewList(String userid);
	public ArrayList<HashMap> qnaList(String userid);
}
