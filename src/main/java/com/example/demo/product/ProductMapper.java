package com.example.demo.product;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.CartDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.ReviewDto;
import com.example.demo.dto.QnaDto;
import com.example.demo.member.MemberDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Mapper
public interface ProductMapper {
	public ArrayList<ProductDto> productList(int index,String pcode,String orderStr,int ck);
    public int getChong(String pcode,int ck);
    public String getDae(String code);
    public String getJung(String dae, String jung);
    public String getSo(String daejung, String so);
	public ProductDto productContent(String pcode);
	public void jjimOk(String pcode, String userid);
	public int isJjim(String pcode, String userid);
	public void jjimDel(String pcode, String userid);
	public void addCart(CartDto cdto);
	public boolean isCart(CartDto cdto);
	public void upCart(CartDto cdto);
	public MemberDto getMember(String userid);
	public BaesongDto getBaesong(String userid);
	public void baesongWriteOk(BaesongDto bdto);
	public ArrayList<BaesongDto> baesongList(String userid);
	public void setZero(String string);
	public int isBaesong(String userid);
	public int getNumber(String jumuncode);
	public void gumaeOk(GumaeDto gdto);
	public void setJuk(int useJuk, String userid);
	public void cartDel(String userid, String pcode);
	public BaesongDto getBaesong2(String id);
	public void baesongUpdateOk(BaesongDto bdto);
	public void baesongDelete(String id);
	public ArrayList<GumaeDto> getGumae(String jumuncode);
	public void qnaWriteOk(QnaDto qdto);
	public ArrayList<ReviewDto> getReview(String pcode);
	public ArrayList<QnaDto> getQna(String pcode);
	public void qnaDel1(String id); //답변 없는걸 삭제
	public void qnaDel2(int ref); // 답변이 있는 글
}
