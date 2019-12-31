package Servlet;

import JavaBean.Login;

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
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.LinkedList;
@WebServlet(name = "HandleBuyGoods", urlPatterns = "/buyServlet")
public class HandleBuyGoods extends HttpServlet {
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
        String buyGoodsMess=req.getParameter("buy");
        if(buyGoodsMess!=null){
            buyGoodsMess=handleString(buyGoodsMess);
        }
        if(buyGoodsMess==null||buyGoodsMess.length()==0){
            showOrderResult(req,resp,"购物车没有物品，无法生成订单");
            return;
        }
        String price=req.getParameter("price");
        if(price==null||price.length()==0){
            showOrderResult(req,resp,"没有计算价格和，无法生成订单");
            return;
        }
        float sum=Float.parseFloat(price);
        Login loginBean=null;
        HttpSession session=req.getSession(true);
        try {
            loginBean=(Login)session.getAttribute("loginBean");
            boolean b=loginBean.getLogin_name()==null||loginBean.getLogin_name().length()==0;
            if(b){
                resp.sendRedirect("login.jsp");
            }
        }catch (Exception e){
            System.out.println(e);
            resp.sendRedirect("login.jsp");
        }
        String uri="jdbc:mysql://127.0.0.1/mobileshop?user=root&password=1234&characterEncoding=GB2312";
        try {
            Connection connection= DriverManager.getConnection(uri);
            String insertCondition="INSERT INTO orderform VALUES(?,?,?,?)";
            PreparedStatement statement=connection.prepareStatement(insertCondition);
            statement.setInt(1,0);
            statement.setString(2,loginBean.getLogin_name());
            statement.setString(3,buyGoodsMess);
            statement.setFloat(4,sum);
            statement.executeUpdate();
            LinkedList car=loginBean.getCar();
            car.clear();
            showOrderResult(req,resp,"生成订单成功");
        }catch (SQLException exp){
            showOrderResult(req,resp,"生成订单失败，数据库有误");
            System.out.println(exp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    public void showOrderResult(HttpServletRequest req,HttpServletResponse resp,String backNews) throws ServletException, IOException{
        HttpSession session=req.getSession(true);
        session.setAttribute("orderResult",backNews);
        RequestDispatcher dispatcher=req.getRequestDispatcher("orderResult.jsp");
        dispatcher.forward(req,resp);
    }
}
