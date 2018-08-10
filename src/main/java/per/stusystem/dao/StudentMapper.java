package per.stusystem.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import per.stusystem.pojo.Student;
import per.stusystem.pojo.StudentExample;

public interface StudentMapper {
    int countByExample(StudentExample example);

    int deleteByExample(StudentExample example);

    int deleteByPrimaryKey(Integer stuId);

    int insert(Student record);

    int insertSelective(Student record);

    List<Student> selectByExample(StudentExample example);

    Student selectByPrimaryKey(Integer stuId);

    List<Student> selectByExampleWithGrade(StudentExample example);

    Student selectByPrimaryKeyWithGrade(Integer stuId);

    int updateByExampleSelective(@Param("record") Student record, @Param("example") StudentExample example);

    int updateByExample(@Param("record") Student record, @Param("example") StudentExample example);

    int updateByPrimaryKeySelective(Student record);

    int updateByPrimaryKey(Student record);

    int selectByPrimaryKeyGetNum(int stuId);
}