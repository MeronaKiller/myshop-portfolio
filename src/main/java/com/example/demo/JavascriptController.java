package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class JavascriptController {
    @GetMapping("/javascript/move/{ck}")
    public String move(@PathVariable String ck)
    {
    	 return "/javascript/move"+ck;
    }
 
    @GetMapping("/javascript/key")
    public String key()
    {
    	 return "/javascript/key";
    }
    
    @GetMapping("/javascript/array")
    public String array()
    {
    	 return "/javascript/array";
    }
    
    @GetMapping("/javascript/rightButton")
    public String rightButton()
    {
    	 return "/javascript/rightButton";
    }
    
    @GetMapping("/javascript/layerMove")
    public String layerMove()
    {
    	 return "/javascript/layerMove";
    }
    
    @GetMapping("/javascript/cal2")
    public String cal2()
    {
    	return "/javascript/cal2";
    }
    @GetMapping("/javascript/cal3")
    public String cal3()
    {
    	return "/javascript/cal3";
    }
    @GetMapping("/javascript/cal4")
    public String cal4()
    {
    	return "/javascript/cal4";
    }
    @GetMapping("/javascript/cal5")
    public String cal5()
    {
    	return "/javascript/cal5";
    }
    @GetMapping("/javascript/cal6")
    public String cal6()
    {
    	return "/javascript/cal6";
    }
    @GetMapping("/javascript/cal7")
    public String cal7()
    {
    	return "/javascript/cal7";
    }
    @GetMapping("/javascript/calEx")
    public String calEx()
    {
    	return "/javascript/calEx";
    }
    
    @GetMapping("/javascript/javascriptFunc")
    public String javascriptFunc()
    {
    	return "/javascript/javascriptFunc";
    }
    
    @GetMapping("/javascript/javascriptFunc2")
    public String javascriptFunc2()
    {
    	return "/javascript/javascriptFunc2";
    }
    
    @GetMapping("/javascript/javascriptFunc3")
    public String javascriptFunc3()
    {
    	return "/javascript/javascriptFunc3";
    }
    
    @GetMapping("/javascript/exception")
    public String exception()
    {
    	return "/javascript/exception";
    }
    
    @GetMapping("/javascript/setEx")
    public String setEx()
    {
    	return "/javascript/setEx";
    }
    
    @GetMapping("/javascript/getTime")
    public String getTime()
    {
    	return "/javascript/getTime";
    }
    @GetMapping("/javascript/imsi")
    public String imsi()
    {
    	return "/javascript/imsi";
    }
    @GetMapping("/javascript/abc")
    public String abc()
    {
    	return "/javascript/abc";
    }
}








