package com.sp.app.dress;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller("dress.dressController")
@RequestMapping("/dress/*")
public class DressController {
	@RequestMapping("list")
	public String DressList() throws Exception{
		return ".dress.list";
	}
}
