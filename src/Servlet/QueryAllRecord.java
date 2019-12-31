package Servlet;

import JavaBean.DataByPage;
import com.sun.rowset.CachedRowSetImpl;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "QueryAllRecord",urlPatterns="/queryServlet")
public class QueryAllRecord extends HttpServlet {
    CachedRowSetImpl rowSet=null;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        try {
            Class.forName("com.mysql.jdbc.Driver");
        }catch (Exception e){ }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idNumber=req.getParameter("fenleiNumber");
        if(idNumber==null){
            idNumber="0";
        }
        int id=Integer.parseInt(idNumber);
        HttpSession session=req.getSession(true);
        Connection connection=null;
        DataByPage dataBean=null;
        try {
            dataBean=(DataByPage)session.getAttribute("dataBean");
            if(dataBean==null){
               dataBean=new DataByPage();
               session.setAttribute("dataBean",dataBean);
            }
        }catch (Exception exp){
            dataBean=new DataByPage();
            session.setAttribute("dataBean",dataBean);
        }
        String uri="jdbc:mysql://127.0.0.1/mobileshop?user=root&password=1234&characterEncoding=GB2312";
        try {
            connection= DriverManager.getConnection(uri);
            Statement statement=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
            ResultSet resultSet=statement.executeQuery("SELECT * FROM mobileform WHERE id="+id);
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
}
