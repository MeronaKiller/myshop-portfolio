package com.example.demo;

import java.lang.annotation.Repeatable;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class EtcController {
	
	@Autowired
	private EtcMapper mapper;
    // 이것저것 연습할때 사용할 클래스
	@GetMapping("/etc/thisEx")
	public String thisEx()
	{
		return "/etc/thisEx";
	}
	
 
	@GetMapping("/etc/vo")
	public String vo()
	{
		return "/etc/vo";
	}
	@GetMapping("/etc/chul")
	public String chul()
	{
		return "/etc/chul";
	}
	@GetMapping("/etc/selectJung")
	public String selectJung()
	{
		return "/etc/selectJung";
	}
	
	@GetMapping("/etc/numberString")
	public String numberString()
	{
		return "/etc/numberString";
	}
	
	@GetMapping("/etc/menu2")
	public String menu2()
	{
		return "/etc/menu2";
	}
	@GetMapping("/etc/menu")
	public String menu()
	{
		return "/etc/menu";
	}
	@GetMapping("/etc/menu3")
	public String menu3()
	{
		return "/etc/menu3";
	}
	
	@GetMapping("/etc/jsCal")
	public String jsCal()
	{
		return "/etc/jsCal";
	}
	
	@GetMapping("/etc/getHoliday")
	public @ResponseBody ArrayList<HolDto> getHoliday(HttpServletRequest request)
	{
		String y=request.getParameter("y");
		String m=request.getParameter("m");
		
		if(m.length()==1)
			m="0"+m;
		
		String day=y+"-"+m;
		//System.out.println(day);
		return mapper.getHoliday(day);
	}
	
	@GetMapping("/etc/jsCal2")
	public String jsCal2()
	{
		return "/etc/jsCal2";
	}
	
 
	@GetMapping("/etc/node")
	public String node()
	{
		return "/etc/node";
	}
	
	@GetMapping("/etc/node2")
	public String node2()
	{
		return "/etc/node2";
	}
	
	@GetMapping("/etc/node3")
	public String node3()
	{
		return "/etc/node3";
	}
	
	@RequestMapping("/etc/table")
	public String table()
	{
		return "/etc/table";
	}
	
	@GetMapping("/etc/star")
	public String star(Model model)
	{
		double star=3.89;
		//star=3.56;
		//star=3.18;
		
		// 노란별, 반별, 회색별의 갯수를 전달
		int ystar=0, hstar=0, gstar=0;
		
		// 노란별의 갯수
		ystar=(int)star;
		
		// 소수점 구하기 => 노, 반, 회 지정
		double imsi=star-ystar;
		
		if(imsi>=0.8)
		{
			ystar++;
		}
		else if(imsi<0.8 && imsi>=0.2)
		     {
			     hstar=1;
		     }
		
		// 회색별 =>  5-(노란별+반별)
		gstar=5-(ystar+hstar);
		
		model.addAttribute("ystar",ystar);
		model.addAttribute("hstar",hstar);
		model.addAttribute("gstar",gstar);
		
		return "/etc/star";
	}
	
 
	@RequestMapping("/etc/id")
	public String id()
	{
		return "/etc/id";
	}
	
	@RequestMapping("/etc/chkbox")
	public String chkbox()
	{
		return "/etc/chkbox";
	}
	@RequestMapping("/etc/comma")
	public String comma()
	{
		return "/etc/comma";
	}
	
	@RequestMapping("/etc/juso")
	public String juso()
	{
		return "/etc/juso";
	}
	
	@RequestMapping("/etc/juso2")
	public String juso2()
	{
		return "/etc/juso2";
	}
	
	@RequestMapping("/etc/google")
	public String google()
	{
		return "/etc/google";
	}
	@RequestMapping("/etc/naverMap")
	public String naverMap()
	{
		return "/etc/naverMap";
	}
	@RequestMapping("/etc/naverMap2")
	public String naverMap2()
	{
		return "/etc/naverMap2";
	}
	@RequestMapping("/etc/form")
	public String form()
	{
		return "/etc/form";
	}
	
	@RequestMapping("/etc/form2")
	public String form2()
	{
		return "/etc/form2";
	}
	
	@RequestMapping("/etc/formOk")
	public void formOk(HttpServletRequest request)
	{
		String[] pcodes=request.getParameterValues("pcode");
		String[] sus=request.getParameterValues("su");
		String[] subChks=request.getParameterValues("subChk");
		
		for(int i=0;i<subChks.length;i++)
		{
			int n=Integer.parseInt(subChks[i]);
			System.out.println(pcodes[n]+" "+sus[n]);
		}
		
		/*
		for(int i=0;i<subChks.length;i++)
		{
			System.out.println(subChks[i]);
		}
		
		for(int i=0;i<pcodes.length;i++)
		{
			System.out.println(pcodes[i]+" "+sus[i]);
		}
		*/
	}
	
	@RequestMapping("/etc/movie")
	public String movie()
	{
		return "/etc/movie";
	}
	@RequestMapping("/etc/weather")
	public String weather()
	{
		return "/etc/weather";
	}
	@RequestMapping("/etc/load")
	public String load()
	{
		return "/etc/load";
	}
	@RequestMapping("/etc/load2")
	public String load2()
	{
		return "/etc/load2";
	}
	
	
	
	@GetMapping("/etc/baesongOut")
	public String baesongOut()
	{
		return "/etc/baesongOut";
	}
	
	@GetMapping("/etc/exMain")
	public String exMain()
	{
		return "/etc/exMain";		
	}
}











