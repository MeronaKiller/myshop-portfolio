package com.example.demo.member;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.MyUtil;
import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.ReviewDto;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ms")
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberMapper mapper;

	@Override
	public String member()
	{
		return "/member/member";
	}

	@Override
	public String useridCheck(HttpServletRequest request) 
	{
		String userid=request.getParameter("userid");
		
		//Integer val=mapper.useridCheck(userid);
		// String imsi=val.toString();
		//return imsi;
		return mapper.useridCheck(userid).toString();
	}

	@Override
	public String memberOk(MemberDto mdto)
    {
		// 아이디 중복체크를 다시 한다..
		Integer n=mapper.useridCheck(mdto.getUserid());
		if(n==0)
		{
			mapper.memberOk(mdto);
			return "redirect:/login/login";
		}
		else
		{
			return "redirect:/member/member?err=1";
		}
	}

	@Override
	public String cartView(HttpServletRequest request, Model model, HttpSession session) 
	{
		ArrayList<ProductDto> plist=null;
		
		if(session.getAttribute("userid")==null) // 로그인을 하지 않은 경
		{
			 // 쿠키변수를 읽어온다 //  상품코드-수량
			Cookie cookie=WebUtils.getCookie(request, "cart");
			if(cookie!=null && !cookie.getValue().equals(""))
			{
				String[] pcodes=cookie.getValue().split("/"); // 상품코드1-수량/상품코드2-수량/상품코드3-수량/
				
				plist=new ArrayList<ProductDto>();
				DecimalFormat df=new DecimalFormat("#,###");
				
				for(int i=0;i<pcodes.length;i++)
				{
					String pcode=pcodes[i].substring(0,12);
					
					ProductDto pdto=mapper.getProduct(pcode);
					
					MyUtil.getBaesong(pdto);
					
					int price=pdto.getPrice();
					int halin=pdto.getHalin();
					int juk=pdto.getJuk();
					
					double halinPrice=price-(price*halin/100.0);		
					double jukPrice= price*juk/100.0;
					
					pdto.setHalinPriceStr(df.format(halinPrice));
					pdto.setJukPriceStr(df.format(jukPrice));
				 
					// 계산된 할인금액을 price필드에 저장해서 뷰에 전달
					pdto.setPrice((int)halinPrice);
					
					// 배열에서 수량을 뽑아서 pdto의 su필드에 저장
					int su=Integer.parseInt(pcodes[i].substring(13));
					pdto.setSu(su);
				
					//  wchk를 모두 1
					pdto.setWchk(1);
					
					plist.add(pdto);
				}
				model.addAttribute("allChk","1");
				model.addAttribute("plist",plist);
			}
		}
		else // 로그인 한 경우
		{
			// cart테이블의 정보를 전달하기
			String userid=session.getAttribute("userid").toString();
			plist=mapper.cartView(userid);
		 
			
			DecimalFormat df=new DecimalFormat("#,###");
			int wchkNum=0;
			for(int i=0;i<plist.size(); i++) // ArrayList에서 모든 dto작업
			{
				ProductDto pdto=plist.get(i);
				// 1. baeday를 baedayStr로 저장  ( 3 => 2/10일 도착예정 )
				MyUtil.getBaesong(pdto);
				
				int price=pdto.getPrice();
				int halin=pdto.getHalin();
				int juk=pdto.getJuk();
				
				double halinPrice=price-(price*halin/100.0);		
				double jukPrice= price*juk/100.0;
				
				pdto.setHalinPriceStr(df.format(halinPrice));
				pdto.setJukPriceStr(df.format(jukPrice));
			 
				// 계산된 할인금액을 price필드에 저장해서 뷰에 전달
				pdto.setPrice((int)halinPrice);
				
				// ArrayList의 pdto에 있는 wchk값이 1인 pdto의 갯수와 ArrayList의 size가 같으면
				// 모두 선택
				if(pdto.getWchk()==1)
					wchkNum++;
				
				/*
				// wchk에 장바구니 날짜가 오늘날짜면 1 아니면 0을 저장
				String[] wday=pdto.getWriteday().split("-"); //  2025-02-07
				int year=Integer.parseInt(wday[0]);
				int month=Integer.parseInt(wday[1]);
				int day=Integer.parseInt(wday[2]);
				LocalDate cartDay=LocalDate.of(year,month,day); // cart테이블의 날짜
				LocalDate today=LocalDate.now(); // 오늘날짜
				
			    if(today.isEqual(cartDay))
			    {
			    	pdto.setWchk(1);
			    }
			    else
			    {
			    	pdto.setWchk(0);
			    }
			    */
			}
			
			int allChk=0;
			if(wchkNum==plist.size())  // pdto.wchk변수의 값이 1인 갯수와  ArrayList의 갯수가 같다
				allChk=1;
			
			//System.out.println(wchkNum+" "+plist.size());
			model.addAttribute("allChk",allChk);
			
			model.addAttribute("plist",plist);
		}
		 
		// 레코드의 갯수에 따른 section의 높이 조절
		int height=660;
		int size=0;
		if(plist!=null) // 로그인하지 않고 쿠키가 null이거나 "" 이면 plist객체가 null이므로 추가
		  size=plist.size();
		
		if(size>4) 
		{
			int n=size-4; 
			
			n=n*115; // 추가되는 레코드당 110px을 추가
			
			height=n+height; // 기본값 추가
		}
	 
	    model.addAttribute("height",height);
		                           // 2025-02-07
	    model.addAttribute("today",LocalDate.now().toString());
	    
 		return "/member/cartView";
	}

	@Override
	public String cartDel(HttpServletRequest request, HttpSession session,HttpServletResponse response) 
	{
		if(session.getAttribute("userid")==null)
		{
			String pcodes=request.getParameter("ids"); // 상품코드1 : 상품코드1,상품코드2,상품코드3,
			
			Cookie cookie=WebUtils.getCookie(request, "cart");
			
			if(cookie!=null && !cookie.getValue().equals(""))
			{
				String cart=cookie.getValue(); // 쿠키변수에 있는 값 => 상품코드1-수량/상품코드2-수량/상품코드3-수량/
				String[] carts=cart.split("/"); // 상품코드를 배열로 변경
				
				String[] pcodeDel=pcodes.split(","); // 삭제하고자 하는 상품코드의 집합
		 				
				for(int i=0;i<carts.length;i++)
				{
					for(int j=0;j<pcodeDel.length;j++)
					{
						if(carts[i].indexOf(pcodeDel[j]) != -1) // 있으면 0이상의 인덱스값 , 없으면 -1
						{
							carts[i]="";
						}
					}					
				}
				
				for(int i=0;i<carts.length;i++)
				{
					System.out.println(i+" : "+carts[i]);
				}
				
				// 배열의 상품코드를 문자열로 변경
				String newCart="";
				for(int i=0;i<carts.length;i++)
				{
					if(carts[i]!="")
					{
						newCart=newCart+carts[i]+"/";
						
						System.out.println(i);
					}
				}
				
				cookie=new Cookie("cart",newCart);
				cookie.setMaxAge(60*60*24);
				cookie.setPath("/");
				
				response.addCookie(cookie);
			}
		}
		else
		{
			// 요청된 상품을 cart테이블에서 삭제
			// 선택삭제 =>  "11,22,33,"
			// 삭제    =>  "11"
	
			String ids=request.getParameter("ids");
			
			String[] imsi=ids.split(",");  
		     
			for(int i=0;i<imsi.length;i++)
			{
				mapper.cartDel(imsi[i]);
			}
		}
		 
		
		return "redirect:/member/cartView";
	}

	@Override
	public String chgSu(HttpServletRequest request
			,HttpSession session
			,HttpServletResponse response) 
	{
		 String id=request.getParameter("id");
		 String num=request.getParameter("num");
		 String pcode=request.getParameter("pcode");
		
		 if(session.getAttribute("userid")==null)
		 {
			 Cookie cookie=WebUtils.getCookie(request, "cart");
			 
			 if(cookie!=null && !cookie.getValue().equals(""))
			 {
				 String cart=cookie.getValue();
				 
				 String[] carts=cart.split("/");
				 
				 for(int i=0;i<carts.length;i++)
				 {
					 if(carts[i].indexOf(pcode) != -1)
					 {
						 // 상품코드-
						 carts[i]=pcode+"-"+num;
					 }
				 }
				 
				 // 다시 문자열을 생성 쿠키에 저장
				 String newCart="";
				 for(int i=0;i<carts.length;i++)
				 {
					 newCart=newCart+carts[i]+"/";
				 }
				 
				 cookie=new Cookie("cart",newCart);
				 cookie.setMaxAge(3600);
				 cookie.setPath("/");
				 response.addCookie(cookie);
			 }
			 return "0";
		 }
		 else
		 {
			 mapper.chgSu(id,num);
			 return "0";
		 }
		 
	}

	@Override
	public String jjimList(HttpSession session, Model model) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			ArrayList<ProductDto> plist=mapper.jjimList(userid);
			model.addAttribute("plist",plist);
			return "/member/jjimList";
		}
		
	}

	@Override
	public String jjimDel(HttpServletRequest request, HttpSession session) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String ids=request.getParameter("ids");
			
			String[] imsi=ids.split(",");
			
			for(int i=0;i<imsi.length;i++)
			{
				mapper.jjimDel(imsi[i]);
			}
			
			
			return "redirect:/member/jjimList";	
		}
		
	}

	@Override
	public String addCart(HttpServletRequest request, HttpSession session) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			String pcode=request.getParameter("pcode");
			
			mapper.addCart(userid,pcode);
			
			return "redirect:/member/jjimList";
		}
		 
	}
	@Override
	public String addCart2(HttpServletRequest request, HttpSession session) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "-1";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			String pcode=request.getParameter("pcode");
			
			if(mapper.isCart(userid,pcode)) // 장바구니에 상품이 존재한다면
			{
				mapper.upCart(userid,pcode); // 수량을 1증가
			}
			else
			{
				mapper.addCart(userid,pcode);
			}
			
			
			
			// return을 장바구니 갯수
			return mapper.getCartSu(userid);
		}
		 
	}

	@Override
	public String jumunList(HttpSession session, Model model,HttpServletRequest request) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			String start,end;
			int month;
	        if(request.getParameter("start")==null)
	        {
	        	month=0;
				if(request.getParameter("month")!=null)
				   month=Integer.parseInt(request.getParameter("month")); // 3 6 12
				
				// 오늘날짜
				LocalDate today=LocalDate.now(); 
				
				// month값에 해당되는 날짜 구하기
				LocalDate xday=today.minusMonths(month);
				
				start=xday.toString();
				end=today.toString();
	        }
	        else
	        {
	        	start=request.getParameter("start");
	        	end=request.getParameter("end");
	        	month=1;
	        	
	        	model.addAttribute("start",start);
	        	model.addAttribute("end",end);
	        }
			
		 
			ArrayList<HashMap> mapAll=mapper.jumunList(userid,start,end, month);
			
			for(int i=0;i<mapAll.size();i++)
			{
				HashMap map=mapAll.get(i);
				int state=Integer.parseInt(map.get("state").toString());
				String stateStr=MyUtil.getState(state);
				map.put("stateStr", stateStr);
			}
			
			model.addAttribute("mapAll",mapAll);
			
			return "/member/jumunList";
		}
		
		
	}

	@Override
	public String chgState(HttpSession session, GumaeDto gdto) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			mapper.chgState(gdto);
			return "redirect:/member/jumunList";
		}
		 
	}

	@Override
	public String review(ReviewDto rdto, Model model) 
	{
		// id,pcode을 뷰에 전달
		model.addAttribute("gid",rdto.getId()); //gumae테이블의 id
		model.addAttribute("pcode",rdto.getPcode());
		
		return "/member/review";
	}

	@Override
	public String reviewOk(ReviewDto rdto, HttpSession session) 
	{
		// review테이블에 저장
		String userid=session.getAttribute("userid").toString();
		rdto.setUserid(userid);
		// gumae.id를 rdto.gid변수에 setter
		rdto.setGid(rdto.getId());
		mapper.reviewOk(rdto); // 상품평등록
		
		// 지금 상품평을 추가한 구매내용에 상품평을 등록했다는것을 저장
		// gumae.review필드의 값을 변경 => 1
		mapper.chgReview(rdto.getId());
		
		
		
		// 상품당 별점의 평균은 어디에 ? product.star
		// 상품평을 추가한 상품의 평균별점을 계산하여 product.star에 저장
		// review.star(동일한 상품) 평균
		double avg=mapper.avgStar(rdto.getPcode()); // 현재 상품의 별점 평균을 가져오기
		
	    mapper.chgStar(avg,rdto.getPcode()); // product.star필드에 평균을 전달
		
	    // 현재 상품평을 추가하는 상품의 product.review필드의 값을 1증가시키기
	    mapper.upReview(rdto.getPcode());
		
		return "redirect:/member/jumunList";
	}

	@Override
	public String reviewDelete(HttpServletRequest request, HttpSession session) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String id=request.getParameter("id"); // review.id
			String pcode=request.getParameter("pcode");
			String gid=request.getParameter("gid"); // gumae.id
			mapper.reviewDelete(id);
			
			// 상품평을 삭제
			// 1.별점을 재계산 => product.star , product.review => -1
			//상품평이 하나도 없을때 null이 발생
			double avg=mapper.avgStar(pcode); 
			mapper.chgStar2(avg,pcode);
			
			// 2.gumae.review => 0
			mapper.setReview(gid); // gumae.id가 필요하다 => gumae.id를 review테이블에 저장
			
			if(request.getParameter("chk")==null)
				return "redirect:/product/productContent?pcode="+pcode;
			else
				return "redirect:/member/reviewList";
		}
		 
	}

	@Override
	public String reviewUpdate(HttpServletRequest request, HttpSession session,Model model) 
	{
		if(session.getAttribute("userid")==null) 
		{
			return "redirect:/login/login";
		}
		else
		{
		    String id=request.getParameter("id");
		    String pcode=request.getParameter("pcode");
		    // pcode는 review테이블에서 읽어올 수 있으므로 없어도 된다.
		    
		    String chk=request.getParameter("chk");
		    model.addAttribute("chk",chk);
		    
		    ReviewDto rdto=mapper.getReview(id);
		    
		    model.addAttribute("rdto",rdto);
		    return "/member/reviewUpdate";
		} 
	}

	@Override
	public String reviewUpdateOk(ReviewDto rdto, HttpSession session,HttpServletRequest request)
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			// 1. review테이블 수정
			mapper.reviewUpdateOk(rdto);
			
			// 2. 해당상품의 별점을 계산 => product.star에 수정
			double avg=mapper.avgStar(rdto.getPcode());
			mapper.chgStar(avg, rdto.getPcode());
			
			if(request.getParameter("chk")==null)
				return "redirect:/product/productContent?pcode="+rdto.getPcode();
			else
			    return "redirect:/member/reviewList";
		}
	}

	@Override
	public String memberInfo(HttpSession session, Model model) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			
			MemberDto mdto=mapper.memberInfo(userid);
			model.addAttribute("mdto",mdto);
			
			return "/member/memberInfo";
		} 
	}

	@Override
	public String chgEmail(HttpServletRequest request, HttpSession session) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "0";
		}
		else
		{
			String email=request.getParameter("email");
			String userid=session.getAttribute("userid").toString();
			
			mapper.chgEmail(email,userid);
			
			return "1";
		} 
	}

	@Override
	public String chgPhone(HttpServletRequest request, HttpSession session) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String phone=request.getParameter("phone");
			String userid=session.getAttribute("userid").toString();
			
			mapper.chgPhone(phone,userid);
			
			return "redirect:/member/memberInfo";
		} 
	}

	@Override
	public String chgPwd(HttpServletRequest request, HttpSession session) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String oldPwd=request.getParameter("oldPwd");
			String newPwd=request.getParameter("newPwd");
			String userid=session.getAttribute("userid").toString();
			
			String err;
			if(mapper.isPwd(userid,oldPwd)) // 현재 비밀번호가 일치하는 지 확인
			{
				// 현재비밀번호 일치 => 새 비밀번호 변경
				mapper.chgPwd(userid,newPwd);
				err="1";
			}
			else
			{
				err="0";
			}
						
			return "redirect:/member/memberInfo?err="+err;
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
		
		return "/member/baesongList";
	}

	@Override
	public String reviewList(HttpSession session, Model model) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			
			ArrayList<HashMap> mapAll=mapper.reviewList(userid);
			model.addAttribute("mapAll",mapAll);
			
			return "/member/reviewList";
			
		} 
	}

	@Override
	public String qnaList(HttpSession session, Model model) 
	{
		if(session.getAttribute("userid")==null) 
		{
			return "redirect:/login/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			ArrayList<HashMap> mapAll=mapper.qnaList(userid);
			model.addAttribute("mapAll",mapAll);
		    return "/member/qnaList";	
	    }
	}
	
}







