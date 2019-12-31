package JavaBean;

import java.util.LinkedList;

public class Login {
    String login_name="";
    String backNews="未登录";
    String return_index="";
    String return_login="";
    LinkedList<String>car;

    public String getReturn_index() {
        return return_index;
    }

    public void setReturn_index(String return_index) {
        this.return_index = return_index;
    }

    public String getReturn_login() {
        return return_login;
    }

    public void setReturn_login(String return_login) {
        this.return_login = return_login;
    }



    public LinkedList<String> getCar() {
        return car;
    }

    public String getLogin_name() {
        return login_name;
    }

    public void setLogin_name(String login_name) {
        this.login_name = login_name;
    }

    public String getBackNews() {
        return backNews;
    }

    public void setBackNews(String backNews) {
        this.backNews = backNews;
    }

    public Login(){
        car=new LinkedList<String>();
    }
}
