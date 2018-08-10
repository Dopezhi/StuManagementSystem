package per.stusystem.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import per.stusystem.pojo.Grade;
import per.stusystem.service.GradeService;
import per.stusystem.utils.Msg;

import java.util.List;

@Controller
public class GradeController {
    @Autowired
    GradeService gradeService;

    @RequestMapping("/grades")
    @ResponseBody
    public Msg getGrades(){
        List<Grade> grades=gradeService.getGrades();
        return Msg.success().add("grades", grades);
    }
}
