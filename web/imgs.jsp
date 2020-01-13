<%@ page import="java.awt.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page contentType="image/jpeg;charset=UTF-8" language="java" %>
<%!
    //随机产生颜色值
    public Color getColor() {
        Random ran = new Random();
        int r = ran.nextInt(256);
        int g = ran.nextInt(256);
        int b = ran.nextInt(256);
        return new Color(r, g, b);//red green blue 0-255
    }

    //产生验证码值
    public String getNum() {
        int ran = (int) (Math.random() * 9000) + 1000;
        return String.valueOf(ran);
    }
%>

<%
    //禁止缓存
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "0");
    //绘制验证码
    BufferedImage image = new BufferedImage(80, 30, BufferedImage.TYPE_INT_RGB);
    //画笔
    Graphics graphics = image.getGraphics();
    //填充背景
    graphics.fillRect(0, 0, 80, 30);
    //绘制干扰线条
    for (int i = 0; i < 40; i++) {
        Random ran = new Random();
        //线条起始值
        int xBegin = ran.nextInt(80);
        int yBegin = ran.nextInt(30);
        //线条终止值
        int xEnd = ran.nextInt(xBegin + 10);
        int yEnd = ran.nextInt(yBegin + 10);

        graphics.setColor(getColor());
        //绘制线条
        graphics.drawLine(xBegin, yBegin, xEnd, yEnd);
    }
    //设置字体
    graphics.setFont(new Font("seif", Font.BOLD, 20));
    //绘制验证码
    graphics.setColor(getColor());//随机颜色 也可自定义颜色
    String checkCode = getNum();
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < checkCode.length(); i++) {
        sb.append(checkCode.charAt(i) + " ");//提取验证码的每一位数字并保存至StringBuffer
    }
    graphics.drawString(sb.toString(), 15, 20);//绘制验证码 调整验证码位置

    //将验证码真实值保存在session中，供使用时比较真实性
    session.setAttribute("CKECKCODE", checkCode);

    //真实的产生图片
    ServletOutputStream sos = response.getOutputStream();
    ByteArrayOutputStream baos =new ByteArrayOutputStream();
    ImageIO.write(image,"JPEG",baos);
    byte[] buffer = baos.toByteArray();
    response.setContentLength(buffer.length);
    sos.write(buffer);
    //关闭(释放资源)
    baos.close();
    sos.close();

%>
