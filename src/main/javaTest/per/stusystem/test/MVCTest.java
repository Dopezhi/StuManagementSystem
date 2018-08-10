package per.stusystem.test;

import com.github.pagehelper.PageInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import per.stusystem.pojo.Student;

import java.util.List;

/**
 * 使用Spring测试模块提供的测试请求功能，测试CRUD请求的正确性
 * Spring 4测试的时候，需要servlet3.0的支持
 * @author 36473
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MVCTest {
    //传入Spring mvc的ioc，容器本身不能加载容器本身，只要加了@WebAppConfiguration
    @Autowired
    WebApplicationContext context;
    //虚拟mvc请求，获取到处理结果的正确性
//    MockMvc mockMvc;


//    @Before
//    public void initMokcMvc() {
//        mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
//    }

    @Test
    public void testPage() throws Exception {
//        System.out.println(context);
        MockMvc mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
        //执行模拟请求拿到返回值
        MvcResult result=mockMvc.perform(MockMvcRequestBuilders.get("/stus").param("pn","1"))
                .andReturn();
        //请求成功以后，请求域中会有pageInfo,我们可以取出pageInfo进行验证
        MockHttpServletRequest request=result.getRequest();
        PageInfo pi=(PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码："+pi.getPageNum());
        System.out.println("总页码:"+pi.getPages());
        System.out.println("总记录数:"+pi.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int []nums=pi.getNavigatepageNums();
        for (int i : nums) {
            System.out.println("  "+i);
        }
        //获取员工数据
        List<Student> list=pi.getList();
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(1));
        }
    }
}
