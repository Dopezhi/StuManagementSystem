package per.stusystem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TestController {

    @RequestMapping(value = "/hello",method = RequestMethod.POST)
    public String testMVC(Model model){
        String testStr="Dopezhi";
        model.addAttribute("msg",testStr);
        return "/list";
    }
}
