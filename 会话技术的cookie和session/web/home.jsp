<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>home</title>
</head>
<body>
 在很久很久以前
<%


    //1.获取所有的cookie
    Cookie[] cookies = request.getCookies();
    boolean flag=false; //没有cookie为lastTime

    //2.遍历cookie数组
    if (cookies!=null && cookies.length>0){
        for (Cookie cookie :
                cookies) {
            //获取cookie的名称
            String name=cookie.getName();
            //判断名称是否是lastTime
            if ("lastTime".equals(name)){
                //有该Cookie,不是第一次访问

                flag=true;//有lastTime的cookie

                //设置cookie的value
                //获取当前时间的字符串，重新设置cookie的值，重新发送cookie
                Date date=new Date();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日-HH:mm:ss");
                String str_date = sdf.format(date);

                System.out.println("编码前数据--"+str_date);
                //URL编码
                str_date= URLEncoder.encode(str_date,"utf-8");
                System.out.println("编码后数据--"+str_date);

                cookie.setValue(str_date);
                //设置cookie的存活时间
                cookie.setMaxAge(3600*24*30);
                response.addCookie(cookie);
                //响应数据
                String value = cookie.getValue();

                //URL解码:
                System.out.println("解码前数据--"+value);
                //URL解码
                value= URLDecoder.decode(value,"utf-8");
                System.out.println("解码后数据--"+value);

              //  response.getWriter().write("欢迎回来,你上次访问时间是-"+value);
                %>
 <h1>
     欢迎回来，你上次访问的时间是+<%= value%>
 </h1>
 <%

                break;
            }
        }
    }

    if (cookies==null || cookies.length==0 || flag==false){
        //没有，第一次访问cookie
        //设置cookie的value
        //获取当前时间的字符串，重新设置cookie的值，重新发送cookie
        Date date=new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日-HH:mm:ss");
        String str_date = sdf.format(date);

        System.out.println("编码前数据--"+str_date);
        //URL编码
        str_date= URLEncoder.encode(str_date,"utf-8");
        System.out.println("编码后数据--"+str_date);

        Cookie cookie = new Cookie("lastTime",str_date);
        cookie.setValue(str_date);
        //设置cookie的存活时间
        cookie.setMaxAge(3600*24*30);
        response.addCookie(cookie);
%>
 <h1> 欢迎您第一次过来</h1>

 <%
 }
%>

</body>
</html>
