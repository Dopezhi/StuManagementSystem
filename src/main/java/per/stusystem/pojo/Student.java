package per.stusystem.pojo;

public class Student {
    private Integer stuId;

    private String stuName;

    private String stuPwd;

    private String email;

    private String stuGender;

    private Integer gradeId;

    private String stuIdf;

    private Grade grade;

    public Grade getGrade() {
        return grade;
    }

    public void setGrade(Grade grade) {
        this.grade = grade;
    }

    public Integer getStuId() {
        return stuId;
    }

    public void setStuId(Integer stuId) {
        this.stuId = stuId;
    }

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName == null ? null : stuName.trim();
    }

    public String getStuPwd() {
        return stuPwd;
    }

    public void setStuPwd(String stuPwd) {
        this.stuPwd = stuPwd == null ? null : stuPwd.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getStuGender() {
        return stuGender;
    }

    public void setStuGender(String stuGender) {
        this.stuGender = stuGender == null ? null : stuGender.trim();
    }

    public Integer getGradeId() {
        return gradeId;
    }

    public void setGradeId(Integer gradeId) {
        this.gradeId = gradeId;
    }

    public String getStuIdf() {
        return stuIdf;
    }

    public void setStuIdf(String stuIdf) {
        this.stuIdf = stuIdf == null ? null : stuIdf.trim();
    }

    public Student(Integer stuId, String stuName, String stuPwd, String email, String stuGender, String stuIdf,Integer gradeId) {
        this.stuId = stuId;
        this.stuName = stuName;
        this.stuPwd = stuPwd;
        this.email = email;
        this.stuGender = stuGender;
        this.gradeId = gradeId;
        this.stuIdf = stuIdf;
    }

    public Student() {

    }

    @Override
    public String toString() {
        return "Student{" +
                "stuId=" + stuId +
                ", stuName='" + stuName + '\'' +
                ", stuPwd='" + stuPwd + '\'' +
                ", email='" + email + '\'' +
                ", stuGender='" + stuGender + '\'' +
                ", gradeId=" + gradeId +
                ", stuIdf='" + stuIdf + '\'' +
                ", grade=" + grade +
                '}';
    }
    public String getIntroduce(){
        String stuRealGender=(stuGender=="M"?"男":"女");
        return "大家好，我的学号是"+stuId+",是来自"+gradeId+"班的"+stuName+",email是"+email+",我是一名"+stuRealGender+"生,这是我的自我介绍。";
    }
}