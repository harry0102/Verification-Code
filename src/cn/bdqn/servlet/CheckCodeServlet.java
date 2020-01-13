package cn.bdqn.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @Author: Mr.Zhou
 * @Date 2020/1/12
 * @Explain:
 */
@WebServlet(name = "CheckCodeServlet", urlPatterns = "/CheckCodeServlet")
public class CheckCodeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        String resultTip = "image/wrong.jpg";
        //获取用户输入的验证码
        String checkcodeClient = request.getParameter("checkcode");
        //真实的验证码值
        String checkcodeSevlet = (String) request.getSession().getAttribute("CKECKCODE");
        if (checkcodeSevlet.equals(checkcodeClient)) {
            resultTip = "image/right.jpg";
        }
        PrintWriter writer = response.getWriter();//输出流
        writer.write(resultTip);
        writer.flush();//刷新流
        writer.close();//关闭
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
