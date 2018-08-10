package per.stusystem.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import per.stusystem.dao.StudentMapper;
import per.stusystem.pojo.Student;
import per.stusystem.pojo.StudentExample;

import java.util.List;

@Service
public class StudentService {
    @Autowired
    StudentMapper studentMapper;

    public List<Student> getAll() {
        List<Student>students=studentMapper.selectByExampleWithGrade(null);
        return students;
    }

    public void saveNewStu(Student student) {
        studentMapper.insertSelective(student);
    }

    public int getNumInTable(Integer stuId) {
        int numInTable=studentMapper.selectByPrimaryKeyGetNum(stuId);
        return  numInTable;
    }

    public boolean checkIdExistNot(Integer stuId) {
        Student student=studentMapper.selectByPrimaryKey(stuId);
        if(student!=null){
            return true;
        }
        return  false;
    }

    public void deleteStuByList(List<Integer> ids) {
        StudentExample studentExample=new StudentExample();
        StudentExample.Criteria criteria=studentExample.createCriteria();
        criteria.andStuIdIn(ids);
        studentMapper.deleteByExample(studentExample);
    }

    public void deleteStuById(int stuId) {
        studentMapper.deleteByPrimaryKey(stuId);
    }

    public Student getStuById(int stuId) {
        Student student=studentMapper.selectByPrimaryKey(stuId);
        return student;
    }

    public void updateByRecord(Student student) {
        studentMapper.updateByPrimaryKey(student);
    }

    public Student loginStuByIdAndPwd(int stuId, String stuPwd) {
        Student tempStudent=studentMapper.selectByPrimaryKey(stuId);
        if(tempStudent!=null){
            if(tempStudent.getStuPwd().equals(stuPwd)){
                return tempStudent;
            }
        }
        return null;
    }

    public void regStudent(Student regStudent) {
        studentMapper.insertSelective(regStudent);
    }
}
