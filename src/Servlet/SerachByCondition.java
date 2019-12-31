package Servlet;

import com.sun.rowset.CachedRowSetImpl;
import jdk.internal.org.objectweb.asm.TypeReference;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.*;

import JavaBean.DataByPage;

@WebServlet(name = "SearchByCondition",urlPatterns = "/searchByConditionServlet")
public class SerachByCondition extends HttpServlet {
    CachedRowSetImpl rowSet=null;
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        try {
            Class.forName("com.mysql.jdbc.Driver");
        }catch (Exception e){ }
    }
    public String handleString(String s){
        String s0=new String(s.getBytes(StandardCharsets.ISO_8859_1),StandardCharsets.UTF_8);
        return s0;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchMess=req.getParameter("searchMess");
        searchMess=handleString(searchMess);
        String radioMess=req.getParameter("radio");
        if(searchMess==null||searchMess.length()==0){
            failResult(req,resp,"没有查询信息，无法查询");
            return;
        }
        String condition="";
        if(radioMess.equals("mobile_version")){
            condition="SELECT * FROM mobileform WHERE mobile_version='"+searchMess+"'";
        }
        else if(radioMess.equals("mobile_name")){
            condition="SELECT * FROM mobileform WHERE mobile_name LIKE '%"+searchMess+"%'";
        }
        else if(radioMess.equals("mobile_price")){
            double max=0,min=0;
            String regex="[^0123456789.]";
            String [] priceMess=searchMess.split(regex);
            if(priceMess.length==1){
                max=min=Double.parseDouble(priceMess[0]);
            }
            else if(priceMess.length==2){
                min=Double.parseDouble(priceMess[0]);
                max=Double.parseDouble(priceMess[1]);
                if(max<min){
                    double t=max;
                    max=min;
                    min=t;
                }
            }
            else {
                failResult(req,resp,"输入的价格格式有错误");
                return;
            }
            condition="SELECT * FROM mobileform WHERE mobile_price <= "+max+" AND mobile_price >="+min;
        }
        HttpSession session=req.getSession(true);
        Connection connection=null;
        DataByPage dataBean=null;
        try {
            dataBean=(DataByPage)session.getAttribute("dataBean");
            if(dataBean==null){
                dataBean=new DataByPage();
                session.setAttribute("dataBean",dataBean);
            }
        }catch (Exception e){
            dataBean=new DataByPage();
            session.setAttribute("dataBean",dataBean);
        }
        String uri="jdbc:mysql://127.0.0.1/mobileshop?user=root&password=1234&characterEncoding=GB2312";
        try {
            connection= DriverManager.getConnection(uri);
            Statement statement=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
            ResultSet resultSet=statement.executeQuery(condition);
            rowSet=new CachedRowSetImpl();
            rowSet.populate(resultSet);
            dataBean.setRowSet(rowSet);
            connection.close();
        }catch (SQLException exp){
            System.out.println(exp);
        }
        resp.sendRedirect("byPageShow.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
    public void failResult(HttpServletRequest req,HttpServletResponse resp,String backNews) throws ServletException, IOException {
        HttpSession session=req.getSession(true);
        session.setAttribute("searchResult",backNews);
        RequestDispatcher dispatcher=req.getRequestDispatcher("failSearchByCondition.jsp");
        dispatcher.forward(req,resp);
    }
}
