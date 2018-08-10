package per.stusystem.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import per.stusystem.dao.GradeMapper;
import per.stusystem.pojo.Grade;

import java.util.List;

@Service
public class GradeService {
    @Autowired
    GradeMapper gradeMapper;

    public List<Grade> getGrades() {
        List<Grade>grades=gradeMapper.selectByExample(null);
        return grades;
    }
}
