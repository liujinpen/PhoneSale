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
import java.util.LinkedList;
@WebServlet(name = "HandleDelete", urlPatterns = "/deleteServlet")
public class HandleDelete extends HttpServlet {
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
        String delete=req.getParameter("delete");
        delete=handleString(delete);
        System.out.println("要删除的："+delete);
        Login loginBean=null;
        HttpSession session=req.getSession(true);
        try {
            loginBean=(Login)session.getAttribute("loginBean");
            boolean b=loginBean.getLogin_name()==null||loginBean.getLogin_name().length()==0;
            if(b){
                resp.sendRedirect("login.jsp");
            }
            LinkedList<String> car=loginBean.getCar();
            car.remove(delete);
        }catch (Exception e){
            System.out.println(e);
            resp.sendRedirect("login.jsp");
        }
        RequestDispatcher dispatcher=req.getRequestDispatcher("lookShoppingCar.jsp");
        dispatcher.forward(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
}
