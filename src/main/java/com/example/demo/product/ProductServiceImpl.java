package com.example.demo.product;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.MyUtil;
import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.CartDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.QnaDto;
import com.example.demo.dto.ReviewDto;
import com.example.demo.member.MemberDto;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ps")
public class ProductServiceImpl implements ProductService{
    @Autowired
    private ProductMapper mapper;

	@Override
	public String productList(HttpServletRequest request, Model model) 
	{
		// 대,중,소 코드에 해당되는 상품을 읽어서 전달하기
		String pcode=request.getParameter("pcode");
		String sword=request.getParameter("sword");
		
		// 요청페이지를 이용하여 시작되는 페이지의 인덱스를 구하기
		int page=1;
		if(request.getParameter("page")!=null)
		{
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		int index=(page-1)*20;
		
		// 페이지 관련 값 처리하기
		int pstart,pend,chong;
		
		pstart=page/10;
		if(page%10 == 0)
			pstart--;
		
		pstart=pstart*10+1;
		pend=pstart+9;
		
		if(pcode==null || pcode.length()==0) // 총페이지
		{
			chong=mapper.getChong(sword,0);
			//System.out.println("검색");
		}
		else
		{
		    chong=mapper.getChong(pcode,1);
		   // System.out.println("pcode");
		}
		
		if(pend>chong)
			pend=chong;
		
		model.addAttribute("pstart",pstart);
		model.addAttribute("pend",pend);
		model.addAttribute("chong",chong);
		model.addAttribute("page",page);
		model.addAttribute("pcode",pcode);
		
		// 정렬형태를 처리하기
		// 판매량순, 가격높은순, 가격낮은순,  최신순
		String orderStr="";
		int order=1;
		if(request.getParameter("order")!=null)
		{
			order=Integer.parseInt(request.getParameter("order"));
		}
		
		switch(order)
		{
		    case 1: orderStr="pansu desc"; break;
		    case 2: orderStr="price desc"; break;
		    case 3: orderStr="price asc"; break;
		    case 4: orderStr="star desc"; break;
		    case 5: orderStr="writeday desc"; break;
		    default: orderStr="pansu desc";
		}
		// 뷰에 현재의 정렬상태의 값을 전달
		model.addAttribute("order",order);
		
		// pcode를 이용하여   Home - 대분류 - 중분류 - 소분류 를 뷰에 전달
		String menuList="";
	    if(pcode==null || pcode.equals("")) // 검색으로 온 경우
	    {
	    	menuList="검색어 : "+sword;
	    }
	    else // 상품코드로 온경우
	    {
	    	if(pcode.length()==3)
			{
			// Home - 대분류
			String dae=pcode.substring(1);  // p01
			String daeName=mapper.getDae(dae);
			menuList="Home - "+daeName;
		}
		else if(pcode.length()==5)
		     {
			     // Home - 대분류 - 중분류   
			     String dae=pcode.substring(1,3);  // p0102
			     String jung=pcode.substring(3);
			     
			     String daeName=mapper.getDae(dae);
			     String jungName=mapper.getJung(dae,jung);
			     menuList="Home - "+daeName+" - "+jungName;
	   	     }
		     else
		     {
		    	 // Home - 대분류 - 중분류 - 소분류
		    	 String dae=pcode.substring(1,3);  // p010201
			     String jung=pcode.substring(3,5);
			     String so=pcode.substring(5);
			     
			     String daeName=mapper.getDae(dae);
			     String jungName=mapper.getJung(dae,jung);
			     String daejung=dae+jung;
			     String soName=mapper.getSo(daejung,so);
			     
			     menuList="Home - "+daeName+" - "+jungName+" - "+soName;
		     }
	    }
	    model.addAttribute("sword",sword);
	    model.addAttribute("menuList",menuList);
			 
	    ArrayList<ProductDto> plist;
	    if(pcode==null || pcode.length()==0) // 검색단어
	    {
	    	plist=mapper.productList(index,sword,orderStr,0);
	    }
	    else
	    {
	    	plist=mapper.productList(index,pcode,orderStr,1);
	    }
		
		// 배송일 => 월/일(요일) 도착예정 
		for(int i=0;i<plist.size();i++) // ArrayList의 처음부터 끝까지 요소를 읽어서 작업을 하기
		{
			ProductDto pdto=plist.get(i);			
			
			// 배송일자구하기
			//String baedayStr=MyUtil.getBaesong(pdto.getBaeday());
			//pdto.setBaedayStr(baedayStr);
			MyUtil.getBaesong(pdto);
			
			// 별점을 getStar()메소드에 보내고 
			// 노란별, 반별, 회색별을 배열로 받어서 처리
			/*
			int[] stars=MyUtil.getStar(pdto.getStar());
			pdto.setYstar(stars[0]);
			pdto.setHstar(stars[1]);
			pdto.setGstar(stars[2]);
		    */
			MyUtil.getStar(pdto.getStar(),pdto);
			
			
			// 상품금액, 할인금액, 적립금을 계산 후 => 소수점X , 3자리마다 ,처리
			int price=pdto.getPrice();
			int halin=pdto.getHalin();
			int juk=pdto.getJuk();
			
			double halinPrice=price-(price*halin/100.0);		
			System.out.println(halinPrice);
			
			double jukPrice= price*juk/100.0;
			System.out.println(jukPrice);
			
			DecimalFormat df=new DecimalFormat("#,###");
			String priceStr=df.format(price);
			
			pdto.setPriceStr(priceStr);
			pdto.setHalinPriceStr(df.format(halinPrice));
			pdto.setJukPriceStr(df.format(jukPrice));
			
			//그림이 여러개 일 경우 하나의 그림만 dto에 저장한다.
			String[] pimgs=pdto.getPimg().split("/");
			pdto.setPimg(pimgs[0]);
		}
		
		model.addAttribute("plist",plist);
		
		return "/product/productList";
	}

	@Override
	public String productContent(HttpServletRequest request, Model model,
			HttpSession session) 
	{
		String pcode=request.getParameter("pcode");
		
		int ok=0;
		if(session.getAttribute("userid")!=null)
		{
			String userid=session.getAttribute("userid").toString();
			ok=mapper.isJjim(pcode, userid);
		}
		model.addAttribute("ok",ok);
		
		ProductDto pdto=mapper.productContent(pcode);
		
		MyUtil.getStar(pdto.getStar(),pdto);
		
		int price=pdto.getPrice();
		int halin=pdto.getHalin();
		int juk=pdto.getJuk();
		
		double halinPrice=price-(price*halin/100.0);		
		double jukPrice= price*juk/100.0;
		
		DecimalFormat df=new DecimalFormat("#,###");
		String priceStr=df.format(price);
		
		pdto.setPriceStr(priceStr);
		pdto.setHalinPriceStr(df.format(halinPrice));
		pdto.setJukPriceStr(df.format(jukPrice));
		
		MyUtil.getBaesong(pdto); //배송일자
		model.addAttribute("pdto",pdto);
		
	    // 그림파일이 1개 이상 등록이 가능한 경우
		String[] pimgs=pdto.getPimg().split("/");
		model.addAttribute("pimgs",pimgs);
		
		ArrayList<ReviewDto> rlist = mapper.getReview(pcode);
		for(int i=0;i<rlist.size();i++)
		{
		    rlist.get(i).setContent(rlist.get(i).getContent().replace("\r\n", "<br>"));
		}
		model.addAttribute("rlist",rlist);
		
		//상품문의를 가져와 뷰에 전달
		ArrayList<QnaDto> qlist=mapper.getQna(pcode);
		for(int i=0;i<qlist.size();i++)
		{
			//QnaDto qdto=qlist.get(i);
			//String content=qdto.getContent();
			//content=content.replace("\r\n", "<br>");
			//qdto.setContent(content);
			
			qlist.get(i).setContent(qlist.get(i).getContent().replace("\r\n", "<br>"));
		}
		
		model.addAttribute("qlist",qlist);

		
		return "/product/productContent";
	}
	@Override
	public String jjimOk(HttpServletRequest request,HttpSession session)
	{
		//회원전용문서
		if(session.getAttribute("userid")==null)
		{
			return "0";
		}
		else
		{
		String pcode=request.getParameter("pcode");
		String userid=session.getAttribute("userid").toString();
		
		mapper.jjimOk(pcode,userid);
		return "1";
		}
	}
	@Override
	public String jjimDel(HttpServletRequest request, HttpSession session)
	{
		if(session.getAttribute("userid")==null)
		{
			return "0";
		}
		else
		{
			String pcode=request.getParameter("pcode");
			String userid=session.getAttribute("userid").toString();
			
			
			mapper.jjimDel(pcode,userid);
			
			return "1";
		}
		
	}
	@Override
	public String addCart(CartDto cdto, HttpSession session,HttpServletRequest request,HttpServletResponse response) 
	{
		if(session.getAttribute("userid")==null)
		{
			//return "0";
			// 쿠키변수에 상품코드와 수량을 저장한다. => cart라는 쿠키변수
			
			// 새로 추가되는 상품코드
			String newCode=cdto.getPcode()+"-"+cdto.getSu()+"/";  // 상품코드3-수량/
			
			// 클라이언트에서 쿠키변수를 읽어온다
			Cookie cookie=WebUtils.getCookie(request, "cart"); // 쿠키변수cart
			
			if(cookie==null || cookie.getValue().equals(""))  // 쿠키를 새로 생성
			{
				cookie=new Cookie("cart",newCode);
				cookie.setMaxAge(60*60*24);
				cookie.setPath("/");
				
				System.out.println("새로 생성 : "+cookie.getValue());
				
				response.addCookie(cookie);
			}
			else              // 기존의 값에다가 새로운 상품을 추가
			{
				String cart=cookie.getValue(); // 자바의 cart변수  상품코드1-수량/상품코드2-수량/
				
				// 중복체크
				String[] carts=cart.split("/");  // 상품코드1-수량/상품코드2-수량/
				
				int chk=0;
				for(int i=0;i<carts.length;i++) // 모든 배열에 있는 상품을 꺼내서 비교하기
				{
					if( carts[i].indexOf(cdto.getPcode()) != -1 ) //  "상품코드1-수량".indexOf("상품코드")
					{
						// 기존 상품이 수량과 새로 추가되는 상품의 수량을 더해서 수정
						int hap=Integer.parseInt(carts[i].substring(13))+cdto.getSu();  // 상품코드1-수량
						
						carts[i]=carts[i].substring(0,13)+hap; // p01030209003-4; 
						
						chk=1;
					}
				}
				
				// 배열에 있는 상품을 String으로 변경 "/"를 구분자
				String cartNew="";
				for(int i=0;i<carts.length;i++)
				{
					cartNew=cartNew+carts[i]+"/";
				}
				
				if(chk==1) 
				{
					// 중복이 되었을 경우
					cart=cartNew;
				}
				else
				{
					// 중복되지 않았을 경우
					cart=cartNew+newCode;   
				}
				 
				cookie=new Cookie("cart",cart);
				cookie.setMaxAge(60*60*24);
				cookie.setPath("/");
				
				System.out.println("추가 생성 : "+cookie.getValue());
				response.addCookie(cookie);
			}
			
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			cdto.setUserid(userid);
			
			if(mapper.isCart(cdto))
			{
				mapper.upCart(cdto);
			}
			else
			{
				mapper.addCart(cdto);
			}			
			
			
		}
		
		return "1";
		
		
	}
	@Override
	public String productGumae(HttpServletRequest request
			, HttpSession session
			, Model model)
	{
		String pcode=request.getParameter("pcode");
		String su=request.getParameter("su");
		
		if(session.getAttribute("userid")==null)
		{
			// 바로구매를 클릭하여 productGumae에 왔을때 로그인을 하지 않아서
			// 로그인으로 이동 => 로그인 후 =>  main/main문서로 이동 => 물건을 사지 않을 확률이 생긴다
			// 어떻게 처리할 까? 
			// 1. 로그인 후에 선택했던 상품을 보여주는 productContent로 이동 : pcode값만 전달
			// 2. 로그인 후에 productGumae로 이동 : pcode, su을 전달
			return "redirect:/login/login?pcode="+pcode+"&su="+su;
		}
		else
		{
		String userid=session.getAttribute("userid").toString();
		
		//구매자 정보
		MemberDto mdto=mapper.getMember(userid);
		model.addAttribute("mdto",mdto);
		//배송지 정보
		BaesongDto bdto=mapper.getBaesong(userid);
		
	    /*if (bdto == null) {
	        bdto = new BaesongDto();
	        bdto.setReq(0);
	    }*/
		
		if(bdto != null)
		{
		String reqStr=null;
		switch(bdto.getReq())
		{
			case 0: reqStr="문 앞"; break;
			case 1: reqStr="직접 받고 부재시 문 앞"; break;
			case 2: reqStr="경비실"; break;
			case 3: reqStr="택배함"; break;
			case 4: reqStr="기타"; break;
			case 5: reqStr=""; 
		}
	bdto.setReqStr(reqStr);
		}
	model.addAttribute("bdto",bdto);
	
	// 하나 이상의 상품정보
	// cartView에서는 ,를 가지고 있고  => 1개 이상이 존재
	// productContent에서는,가 없다  => 1개
	String[] pcodes=pcode.split(",");
	String[] sus=su.split(",");
	System.out.println(pcode+" "+su);
	ArrayList<ProductDto> plist=new ArrayList<ProductDto>();
	for(int i=0;i<pcodes.length;i++)
	{
		ProductDto pdto=mapper.productContent(pcodes[i]);
		MyUtil.getBaesong(pdto);
		//pdto의 su변수에는 재고수량의 개념
		pdto.setSu(Integer.parseInt(sus[i])); // 구매수량으로 set
		
		DecimalFormat df=new DecimalFormat("#,###");
		// 총상품금액, 적립금
		int price=pdto.getPrice(); //할인전 상품금액
		int halin=pdto.getHalin(); //할인율
		price=price-(price*halin/100); //할인 적용된 상품금액
		pdto.setPriceStr(df.format(price));
		pdto.setPrice(price);
		
		// 보유하고 있는 적립금은 MemberDto에 있음
		// 총결제금액 => 할인금액을 계산된 값을 pdto.price에 재지정
		//int cPrice=price+pdto.getBaeprice();
		
		plist.add(pdto);
	}
	
	
	
	model.addAttribute("plist",plist);

	
	return "/product/productGumae";
		}
	}
	@Override
	public String baesongWrite()
	{
		return "/product/baesongWrite";
	}
	@Override
	public String baesongWriteOk(BaesongDto bdto, HttpSession session) 
		{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/etc/baesongOut";
		}
		else
		{
		// 배송지 주소를 baesong테이블에 저장
		// String userid=session.getAttribute("userid").toString();
		// bdto.setUserid(userid);
		bdto.setUserid( session.getAttribute("userid").toString() );
		
		// 현재 입력된 주소를 기본주소로 한다면 기존이 기본주소를 0으로 변경
		if(bdto.getGibon()==1)
				{
			mapper.setZero(session.getAttribute("userid").toString());
				}
		if(bdto.getGibon()==0 && mapper.isBaesong(session.getAttribute("userid").toString())==0)
			{
			bdto.setGibon(1);
			}
		mapper.baesongWriteOk(bdto);
		
		if(bdto.getCk()==0)
		{
			return "redirect:/product/baesongList";
		}
		else
		{
			return "/member/baesongWriteOk";
		}
		}
	}
	@Override
	public String baesongList(HttpSession session, Model model) 
	{
		String userid=session.getAttribute("userid").toString();
		ArrayList<BaesongDto> blist=mapper.baesongList(userid);
		
		for(int i=0;i<blist.size();i++)
		{
			BaesongDto bdto=blist.get(i);
			String reqStr=null;
			switch(bdto.getReq())
			{
			    case 0: reqStr="문 앞"; break;
			    case 1: reqStr="직접 받고 부재시 문 앞"; break;
			    case 2: reqStr="경비실"; break;
			    case 3: reqStr="택배함"; break;
			    case 4: reqStr="기타"; break;
			    default: reqStr="";
			}
			bdto.setReqStr(reqStr);
		 
		}
		
		
		model.addAttribute("blist",blist);
		
		return "/product/baesongList";
	}
	@Override
	public String gumaeOk(GumaeDto gdto, HttpSession session)
	{
			if(session.getAttribute("userid")==null)
			{
				return "redirect:/login/login";
			}
			else
			{
				String userid=session.getAttribute("userid").toString();
				gdto.setUserid(userid);
				
				//주문코드 만들기 => j20250211 + 001
				String today=LocalDate.now().toString();
				today=today.replace("-", "");
				String jumuncode="j"+today;
				
				int num=mapper.getNumber(jumuncode);
				jumuncode=jumuncode+String.format("%03d", num);
				gdto.setJumuncode(jumuncode);
				
				//pcode,su의 값을 배열로 만든뒤 저장
				String[] pcodes=gdto.getPcode().split("/");
				String[] sus=gdto.getSus().split("/");
				
				
				for(int i=0;i<pcodes.length;i++)
				{
					//배열에 각 요소에 있는 pcode,su으로 setter
					gdto.setPcode(pcodes[i]);
					gdto.setSu(Integer.parseInt(sus[i]));
					
					mapper.gumaeOk(gdto);
					
					// gumae테이블에 저장된 상품을 cart에서 삭제하기
					mapper.cartDel(userid, pcodes[i]);
					
					System.out.println("주문코드:"+gdto.getJumuncode());
					
				}
				// member테이블의 juk필드의 값에서 사용된 적립금값을 빼고 저장
				mapper.setJuk(gdto.getUseJuk(),userid);
				
				//뷰에 전달할 내용을 생성후 뷰를 전달
				
				return "redirect:/product/gumaeList?jumuncode="+jumuncode;
				//return null;
			}
		}
	@Override
	public String baesongUpdate(HttpServletRequest request, HttpSession session,Model model) 
	{
		
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/etc/baesongOut";
		}
		else
		{
			String id=request.getParameter("id");
			BaesongDto bdto=mapper.getBaesong2(id);
			model.addAttribute("bdto",bdto);
			
			return "/product/baesongUpdate";
		}
	}
	@Override
	public String baesongUpdateOk(BaesongDto bdto, HttpSession session) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/etc/baesongOut";
		}
		else
		{
			if(bdto.getGibon()==1)
				mapper.setZero(session.getAttribute("userid").toString());
			
			mapper.baesongUpdateOk(bdto);
			
			if(bdto.getCk() == 0)
			{
			return "redirect:/product/baesongList";
			}
			else
			{
				return "/member/baesongUpdateOk";
			}
		}
	}
	@Override
	public String baesongDelete(HttpServletRequest request, HttpSession session) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/etc/baesongOut";
		}
		else
		{
			String id=request.getParameter("id");
			mapper.baesongDelete(id);
			
			if(request.getParameter("ck")==null)
			{
			return "redirect:/product/baesongList";
			}
			else
			{
				return "redirect:/member/baesongList";
			}
		}
	}
	@Override
	public String gumaeList(HttpSession session, HttpServletRequest request
			,Model model) 
	{
		// 방금 주문한 상품의 주문코드를 이용하여 상품의 정보,구매내역을
		// 사용자에게 보여준다.
		// 상품정보 : 배송예정일, 수량, 상품그림, 제목 , 할인적용된 금액
		// 배송지정보 : 받는사람 , 우편번호,주소, 배송요청사항
		// 구매가격 : 모든상품금액 , 모든 배송비 , 사용적립금 => 총 결제금액
		
		String jumuncode=request.getParameter("jumuncode");
		
		// gumae 테이블 내용 가져오기
		ArrayList<GumaeDto> glist=mapper.getGumae(jumuncode);
		
		// glist의 gumaeDto에서 pcode를 이용하여 Product테이블 내용을 ProductDto 가져오기
		
		// 상품의 합계금액, 배송비합계금액, 사용된 적립금을 저장할 변수
		int halinPriceAll=0, baePriceAll=0;
		int useJuk=0;
		
		//product 테이블에 내용을 담을 ArrayList필요
		ArrayList<ProductDto> plist=new ArrayList<ProductDto>();
		
		for(int i=0;i<glist.size();i++)
		{
			GumaeDto gdto=glist.get(i);
			ProductDto pdto=mapper.productContent(gdto.getPcode());
			
			// 배송예정일
			MyUtil.getBaesong(pdto);
			// 구매수량 gdto.getSu() => pdto.setSu()
			pdto.setSu(gdto.getSu());
			// 상품그림, 제목은 pdto에 들어있음
			// 할인 적용된 금액: 상품금액-(상품금액*할인율/100)
			int halinPrice=pdto.getPrice()-(pdto.getPrice()*pdto.getHalin()/100);
			halinPrice=halinPrice*gdto.getSu();
			pdto.setPrice(halinPrice);
			
			//상품의 합계금액, 배송비합계금액, 사용된 적립금 => 따로 뷰에 전달
			halinPriceAll=halinPriceAll+halinPrice;
			baePriceAll=baePriceAll+pdto.getBaeprice();
			useJuk=gdto.getUseJuk();
			
			plist.add(pdto);
		}
		model.addAttribute("plist",plist);
		
		//배송지 정보 glist.get(0).getBaeId();
		GumaeDto gdto=glist.get(0);
		BaesongDto bdto=mapper.getBaesong2(gdto.getBaeId()+"");
		String reqStr;
		switch(bdto.getReq())
		{
	    case 0: reqStr="문 앞"; break;
	    case 1: reqStr="직접 받고 부재시 문 앞"; break;
	    case 2: reqStr="경비실"; break;
	    case 3: reqStr="택배함"; break;
	    case 4: reqStr="기타"; break;
	    default: reqStr="";
		}
		bdto.setReqStr(reqStr);
		model.addAttribute("bdto",bdto);
		
		//MyUtil.comma()메소드를 생성해서 사용
		model.addAttribute("halinPriceAll",MyUtil.comma(halinPriceAll));
		model.addAttribute("baePriceAll",baePriceAll);
		model.addAttribute("useJuk",useJuk);
		model.addAttribute("chongPrice",MyUtil.comma(halinPriceAll+baePriceAll-useJuk));
		
		return "/product/gumaeList";
	}
	@Override
	public String qnaWriteOk(QnaDto qdto, HttpServletRequest request,HttpSession session) 
	{
		String userid=session.getAttribute("userid").toString();
		qdto.setUserid(userid);
		
		mapper.qnaWriteOk(qdto);
		
		return "redirect:/product/productContent?pcode="+qdto.getPcode();
	}
	@Override
	public String qnaDel(HttpServletRequest request)
	{
		String id=request.getParameter("id");
		String pcode=request.getParameter("pcode");
		int ref=Integer.parseInt(request.getParameter("ref"));
		
		if(ref==0) // 답변이 없다
		{
			mapper.qnaDel1(id);
		}
		else
		{
			mapper.qnaDel2(ref);
		}
		
		if(request.getParameter("chk")==null)
			return "redirect:/product/productContent?pcode="+pcode;
		else
			return "redirect:/member/qnaList";
	}
}




















