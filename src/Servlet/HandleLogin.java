package Servlet;

import JavaBean.Login;
import com.sun.corba.se.spi.protocol.RequestDispatcherDefault;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;
import java.io.IOException;
import java.io.StreamTokenizer;
import java.nio.charset.StandardCharsets;
import java.sql.*;

@WebServlet(name = "Handle_login",urlPatterns="/handle_login",initParams= {
        @WebInitParam(name="database_name",value="mobileshop"),
        @WebInitParam(name="table_name",value="user"),
        @WebInitParam(name="user_name",value="root"),
        @WebInitParam(name="password",value="1234"),
},
        loadOnStartup=1
)
public class HandleLogin extends HttpServlet {
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        try {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch (Exception e){}
    }
    public String handleString(String s){
        String s0=new String(s.getBytes(StandardCharsets.ISO_8859_1),StandardCharsets.UTF_8);
        return s0;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection;
        Statement statement;
        //数据库的参数
        String user_name=getInitParameter("user_name").trim();
        String database_name=getInitParameter("database_name").trim();
        String password=getInitParameter("password").trim();
        String table_name=getInitParameter("table_name").trim();
        //表单参数
        String login_name=req.getParameter("login_name").trim();
        String login_pwd=req.getParameter("login_pwd").trim();
        login_name=handleString(login_name);
        login_pwd=handleString(login_pwd);
        //链接数据库
        String uri="jdbc:mysql://127.0.0.1/"+database_name+"?user="+user_name+"&password="+password+"&characterEncoding=GB2312";
        boolean boo=(login_name.length()>0&&login_pwd.length()>0);
        try {
            connection= DriverManager.getConnection(uri);
            String condition="SELECT * FROM "+table_name+" WHERE logname= '"+login_name+"'AND password= '"+login_pwd+"'";
            statement=connection.createStatement();
            if(boo){
                ResultSet resultSet=statement.executeQuery(condition);
                boolean m=resultSet.next();
                if (m==true){
                    success(req,resp,login_name);
                }
                else{
                    String backNews="用户名不存在或密码错误";
                    fail(req,resp,backNews);
                }
            }
            else{
                String backNews="请输入用户名和密码";
                fail(req,resp,backNews);
            }
            connection.close();

        }catch (SQLException exp){
            String backNews="登录失败，数据库有误";
            fail(req,resp,backNews);
            System.out.println(exp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    public void success(HttpServletRequest req,HttpServletResponse resp,String login_name) throws ServletException, IOException {
        Login loginBean=null;
        HttpSession session=req.getSession(true);
        try {
            loginBean=(Login)session.getAttribute("loginBean");
            if (loginBean==null){
                loginBean=new Login();
                session.setAttribute("loginBean",loginBean);
                loginBean=(Login)session.getAttribute("loginBean");
            }
            String name=loginBean.getLogin_name();
            if(name.equals(login_name)){
                loginBean.setBackNews("你已登录");
                loginBean.setLogin_name(login_name);
                loginBean.setReturn_index("");
                loginBean.setReturn_login("");
            }
            else{
                loginBean.setBackNews("登录成功");
                loginBean.setLogin_name(login_name);
                loginBean.setReturn_index("");
                loginBean.setReturn_login("");
            }
        }catch (Exception e){
            loginBean=new Login();
            session.setAttribute("loginBean",loginBean);
            loginBean.setBackNews("登录成功");
            loginBean.setLogin_name(login_name);
            loginBean.setReturn_index("");
            loginBean.setReturn_login("");
            System.out.println(e);
        }
        RequestDispatcher dispatcher=req.getRequestDispatcher("login.jsp");
        dispatcher.forward(req,resp);
    }

    public void fail(HttpServletRequest req,HttpServletResponse resp,String backNews) throws ServletException, IOException {
        Login loginBean=null;
        HttpSession session=req.getSession(true);
        loginBean=new Login();
        session.setAttribute("loginBean",loginBean);
        loginBean.setBackNews(backNews);
        loginBean.setLogin_name("（正确登录后将显示）");
        loginBean.setReturn_index("<a href=index.jsp>返回主页</a>");
        loginBean.setReturn_login("<a href=login.jsp>返回登录</a>");
        RequestDispatcher dispatcher=req.getRequestDispatcher("login.jsp");
        dispatcher.forward(req,resp);
    }

}
