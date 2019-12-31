package Servlet;

import JavaBean.Register;
import com.sun.xml.internal.bind.v2.model.core.ID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Console;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.*;

@WebServlet(name = "Handle_register",urlPatterns="/handle_register",initParams= {
        @WebInitParam(name="database_name",value="mobileshop"),
        @WebInitParam(name="table_name",value="user"),
        @WebInitParam(name="user_name",value="root"),
        @WebInitParam(name="password",value="1234"),
},
        loadOnStartup=1
)
public class HandleRegister extends HttpServlet {
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
        PreparedStatement statement;
        Register registerBean=new Register();
        req.setAttribute("registerBean",registerBean);
        //数据库的参数
        String user_name=getInitParameter("user_name").trim();
        String database_name=getInitParameter("database_name").trim();
        String password=getInitParameter("password").trim();
        String table_name=getInitParameter("table_name").trim();
        //表单参数
        String register_name=req.getParameter("register_name").trim();
        String register_real_name=req.getParameter("register_real_name").trim();
        String register_pwd=req.getParameter("register_pwd").trim();
        String register_re_pwd=req.getParameter("register_re_pwd").trim();
        String register_phone=req.getParameter("register_phone").trim();
        String register_address=req.getParameter("register_address").trim();
        //防止乱码
        register_name=handleString(register_name);
        register_real_name=handleString(register_real_name);
        register_pwd=handleString(register_pwd);
        register_re_pwd=handleString(register_re_pwd);
        register_phone=handleString(register_phone);
        register_address=handleString(register_address);
        if(register_name==null){
            register_name="";
        }
        if (register_pwd==null){
            register_pwd="";
        }
        if(!register_pwd.equals(register_re_pwd)){
            registerBean.setBackNews("两次密码不同，注册失败");
            RequestDispatcher dispatcher=req.getRequestDispatcher("inputRegisterMess.jsp");
            dispatcher.forward(req,resp);
            return;
        }
        boolean isLD=true;
        for(int i=0;i<register_name.length();i++){
            char c=register_name.charAt(i);
            if (!((c<='z'&&c>='a')||(c<='Z'&&c>='A')||(c<'9'&&c>='0'))){
                isLD=false;
            }
        }
        boolean boo=(register_name.length()>0&&register_pwd.length()>0&& isLD);
        String backNews="";
        //链接数据库操作
        String uri="jdbc:mysql://127.0.0.1/"+database_name+"?user="+user_name+"&password="+password+"&characterEncoding=GB2312";
        try {
            connection= DriverManager.getConnection(uri);
            String insertCondition="INSERT INTO "+table_name+" VALUES(?,?,?,?,?)";
            statement=connection.prepareStatement(insertCondition);
            if(boo){
                statement.setString(1,register_name);
                statement.setString(2,register_pwd);
                statement.setString(3,register_phone);
                statement.setString(4,register_address);
                statement.setString(5,register_real_name);
                int m=statement.executeUpdate();
                if(m!=0){
                    backNews="注册成功";
                    registerBean.setBackNews(backNews);
                    registerBean.setLogname(register_name);
                    registerBean.setPhone(register_phone);
                    registerBean.setAddress(register_address);
                    registerBean.setRealname(register_real_name);
                }
            }
            else{
                backNews="信息填写不完整或名字内有非法字符";
                registerBean.setBackNews(backNews);
            }
            statement.close();
        }catch (SQLException exp){
            backNews="该会员名已被使用，请重新注册";
            registerBean.setBackNews(backNews);
            System.out.println(exp);
        }
        RequestDispatcher dispatcher=req.getRequestDispatcher("inputRegisterMess.jsp");
        dispatcher.forward(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
}
