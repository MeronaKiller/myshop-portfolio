package com.example.demo.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.MailSend;
import com.example.demo.MyUtil;
import com.example.demo.member.MemberDto;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.server.ServerEndpoint;

@Service
@Qualifier("ls")
public class LoginServiceImpl implements LoginService{

	@Autowired
	private LoginMapper mapper;

	@Override
	public String login(HttpServletRequest request,Model model) 
	{
		String err=request.getParameter("err");
		String pcode=request.getParameter("pcode");
		String su=request.getParameter("su");
		String cart=request.getParameter("cart");
		
		model.addAttribute("pcode",pcode);
		model.addAttribute("err",err);
		model.addAttribute("su",su);
		model.addAttribute("cart",cart);
 		return "/login/login";
	}

	@Override
	public String loginOk(MemberDto mdto,HttpSession session
			,HttpServletRequest request
			,HttpServletResponse response) 
	{
		// 세션변수를 어떤값으로 만들것인지  (아이디,이름)
		String name=mapper.loginOk(mdto);
		if(name==null)
		{
			return "redirect:/login/login?err=1";
		}
		else
		{
			// 세션변수를 할당 후 메인페이지 이동
			session.setAttribute("userid", mdto.getUserid());
			session.setAttribute("name", name);
			//session.setMaxInactiveInterval(600);
		
			// 쿠키변수에 있는 상품을 cart테이블에 저장을 하기
			Cookie cookie=WebUtils.getCookie(request, "cart");
			
			if(cookie!=null && !cookie.getValue().equals(""))
			{
				String cart=cookie.getValue(); //  상품코드1-수량/상품코드2-수량/상품코드3-수량/
				String[] carts=cart.split("/");
				
				for(int i=0;i<carts.length;i++)
				{
					String[] imsi=carts[i].split("-");
					
					// cart테이블에 존재한다면 insert가 아니라 수량을 update하기
					if(mapper.isCart(mdto.getUserid(),imsi[0]))
					{
						mapper.upCart(mdto.getUserid(), imsi[0], imsi[1]);
					}
					else
					{
						mapper.addCart(mdto.getUserid(), imsi[0], imsi[1]);
					}
					
				}
				
				// 추가된 후 쿠키변수는 삭제
				cookie=new Cookie("cart","");
				cookie.setMaxAge(0);
				cookie.setPath("/");
				
				response.addCookie(cookie);
			}
			
			String pcode=request.getParameter("pcode");
			String su=request.getParameter("su");
			
			if(pcode.equals(""))
			{	
				if(request.getParameter("cart")==null)
					return "redirect:/main/main";
				else
					return "redirect:/member/cartView";
			}
			else
			{
				if(su==null)
				return "redirect:/product/productContent?pcode="+pcode;
				else
				return "redirect:/product/productGumae?pcode="+pcode+"&su="+su;
			}
			
			
		}
		 
	}
			
		 

	@Override
	public String logout(HttpSession session)
	{
		session.invalidate();
		
		return "redirect:/main/main";
	}

	@Override
	public String getUserid(MemberDto mdto)
	{
		String userid=mapper.getUserid(mdto);
		return userid;
	}

	@Override
	public String getPwd(MemberDto mdto) throws Exception 
	{
	    String pwd=mapper.getPwd(mdto);
	    
	    if(pwd!=null)
	    {
	    	// 이메일로 비밀번호를 전송하면 된다..
	    	/*
		    MailSend ms=MailSend.getInstance();
		    String title=mdto.getUserid()+"님의 비밀번호를 보내드립니다";
		    String content="당신의 비밀번호는 "+pwd+" 입니다";
		    ms.setEmail(mdto.getEmail(), title, content, "네이버비밀번호");
		    */
	    	
	    	// 6자리의 임의의 비밀번호를 구해서 메시지로 보내기
	       	String imsiPwd=MyUtil.getNewPwd2();
	       	
	        // 새로 만든 비밀번호는 pwd필드에 저장
	       	// 기존의 비밀번호는 oldPwd필드에 저장
	    	mapper.chgPwd(mdto.getUserid(),imsiPwd,pwd);
	       	
			return "임시 비밀번호 : "+imsiPwd;
	    }
	    else
	    	return "정보가 일치하지 않습니다";
	    
	}
}













