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
import javax.swing.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.LinkedList;

@WebServlet(name = "PutGoodsToCar" ,urlPatterns = "/putGoodsServlet")
public class PutGoodsToCar extends HttpServlet {
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public String handleString(String s){
        String s0=new String(s.getBytes(StandardCharsets.ISO_8859_1),StandardCharsets.UTF_8);
        return s0;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String goods=req.getParameter("java");
        goods=handleString(goods);
        System.out.println(goods);
        Login loginBean=null;
        HttpSession session=req.getSession(true);
        try {
            loginBean=(Login)session.getAttribute("loginBean");
            boolean b=loginBean.getLogin_name()==null||loginBean.getLogin_name().length()==0;
            if(b){
                resp.sendRedirect("login.jsp");
            }
            LinkedList<String>car=loginBean.getCar();
            car.add(goods);
            session.setAttribute("currentGoods",goods);
            RequestDispatcher dispatcher=req.getRequestDispatcher("shopSuccess.jsp");
            dispatcher.forward(req,resp);
        }catch (Exception e){
            System.out.println(e);
            resp.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

}
