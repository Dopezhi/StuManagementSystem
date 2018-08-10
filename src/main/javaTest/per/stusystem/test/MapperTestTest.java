package per.stusystem.test;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import per.stusystem.dao.GradeMapper;
import per.stusystem.dao.StudentMapper;
import per.stusystem.pojo.Grade;
import per.stusystem.pojo.Student;
import per.stusystem.service.StudentService;

import java.util.List;
import java.util.UUID;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTestTest {

    @Autowired
    StudentMapper studentMapper;
    @Autowired
    GradeMapper gradeMapper;

    @Autowired
    SqlSession sqlSession;

    @Autowired
    StudentService studentService;

    @Test
    public void testCRUD() {
//        Grade one=new Grade();
//        one.setGradeId(3);
//        one.setGradeName("16DNF一班");
//        gradeMapper.insertSelective(one);
//        Grade grade=gradeMapper.selectByPrimaryKey(1);
//        System.out.println(grade);

        List<Student> students =studentMapper.selectByExampleWithGrade(null);
        for (int i = 0; i < students.size(); i++) {
            System.out.println(students.get(i));
        }

//        为学生表插入记录
//		StudentMapper mapper=SqlSession.getMapper(StudentMapper.class);
//		String qian="1615432";
//		for(int i=10;i<=50;i++) {
//			String stuId=qian+String.valueOf(i);
//			String uid=UUID.randomUUID().toString().substring(0, 5)+i;
//			Student temp=new Student(Integer.valueOf(stuId), uid, stuId, uid+"@dopezhi.com", "M",null,2);
//			temp.setStuIdf(temp.getIntroduce());
//			studentMapper.insertSelective(temp);
//
//		}
//
//		System.out.println("done");
//		Student temp=studentMapper.selectByPrimaryKeyWithGrade(161543101);
//		System.out.println(temp);
//		int num=studentMapper.selectByPrimaryKeyGetNum(161543132);
//		System.out.println(""+num);
    }

}