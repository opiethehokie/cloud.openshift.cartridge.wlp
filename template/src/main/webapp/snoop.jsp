<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%
    ServletContext context = getServletConfig().getServletContext();

    out.print("<br>");
    out.print("[<b>Servlet init parameters:" + "</b>]<br>");
    Enumeration e = getServletConfig().getInitParameterNames();
    while (e.hasMoreElements()) {
        String key = (String)e.nextElement();
        String value = getServletConfig().getInitParameter(key);
        out.print("   " + key + " = " + value + "<br>");
    }
    out.print("<br>");

    out.print("[<b>Context init parameters:" + "</b>]<br>");

    Enumeration enumer = context.getInitParameterNames();
    while (enumer.hasMoreElements()) {
        String key = (String)enumer.nextElement();
            Object value = context.getInitParameter(key);
            out.print("   " + key + " = " + value + "<br>");
    }
    out.print("<br>");

    out.print("[<b>Context attributes:" + "</b>]<br>");
    enumer = context.getAttributeNames();
    while (enumer.hasMoreElements()) {
        String key = (String)enumer.nextElement();
            Object value = context.getAttribute(key);
            out.print("   " + key + " = " + value + "<br>");
    }
    out.print("<br>");


        out.print("[<b>Request attributes:" + "</b>]<br>");
        e = request.getAttributeNames();
        while (e.hasMoreElements()) {
            String key = (String)e.nextElement();
            Object value = request.getAttribute(key);
            out.print("   " + key + " = " + value + "<br>");
        }
        out.print("<br>");
        out.print("[<b>Parameter names in this request:" + "</b>]<br>");
        e = request.getParameterNames();
        while (e.hasMoreElements()) {
            String key = (String)e.nextElement();
            String[] values = request.getParameterValues(key);
            out.print("   " + key + " = ");
            for(int i = 0; i < values.length; i++) {
                out.print(values[i] + " ");
            }
            out.print("<br>");
        }
        out.print( "<br>");
        out.print("[<b>Headers in this request: "+ "</b>]<br>");
        e = request.getHeaderNames();
        while (e.hasMoreElements()) {
            String key = (String)e.nextElement();
            String value = request.getHeader(key);
            out.print("   " + key + ": " + value + "<br>");
        }
        out.print("<br>");
        out.print("[<b>Cookies in this request:" + "</b>]<br>");
        Cookie[] cookies = request.getCookies();
        for (int i = 0; i < (cookies!=null?cookies.length:0); i++) {
            Cookie cookie = cookies[i];
            out.println ("   " + cookie.getName() + " = " + cookie.getValue() + "<br>");
            out.println ("");
            out.println ("  domain:" + cookie.getDomain() + "<br>");
            out.println ("  path:" + cookie.getPath() + "<br>");
            out.println ("  comment:" + cookie.getComment() + "<br>");
            out.println ("  max age:" + cookie.getMaxAge() + "<br>");
            out.println ("  secure?:" + cookie.getSecure() + "<br>");
            out.println ("  version:" + cookie.getVersion() + "<br>");
            out.println ("");
        }
        out.print("<br>");

        out.print("[<b>Misc request information:" + "</b>]<br>");
        // out.print("Servlet Name: " + getServletConfig().getServletName());
        out.print("Protocol: " + request.getProtocol() + "<br>");
        out.print("Scheme: " + request.getScheme() + "<br>");
        out.print("Server Name: " + request.getServerName() + "<br>");
        out.print("Server Port: " + request.getServerPort() + "<br>");
        out.print("Server Info: " + context.getServerInfo() + "<br>");
        out.print("Remote Addr: " + request.getRemoteAddr() + "<br>");
        out.print("Remote Host: " + request.getRemoteHost() + "<br>");
        out.print("Character Encoding: " + request.getCharacterEncoding() + "<br>");
        out.print("Content Length: " + request.getContentLength() + "<br>");
        out.print("Content Type: "+ request.getContentType() + "<br>");
        out.print("Locale: "+ request.getLocale() + "<br>");
        out.print("Default Response Buffer: "+ response.getBufferSize() + "<br>");
        out.print("Request Is Secure: " + request.isSecure() + "<br>");
        out.print("Auth Type: " + request.getAuthType() + "<br>");
        out.print("HTTP Method: " + request.getMethod() + "<br>");
        out.print("Remote User: " + request.getRemoteUser() + "<br>");
        out.print("Request URI: " + request.getRequestURI() + "<br>");
        out.print("Context Path: " + request.getContextPath() + "<br>");
        out.print("Servlet Path: " + request.getServletPath() + "<br>");
        out.print("Path Info: " + request.getPathInfo() + "<br>");
        out.print("Path Trans: " + request.getPathTranslated() + "<br>");
        out.print("Query String: " + request.getQueryString() + "<br>");

        out.print("<br>");
        out.print("[<b>Session info:" + "</b>]<br>");
       // HttpSession session = request.getSession();
        out.print("Requested Session Id: " +
                    request.getRequestedSessionId() + "<br>");
        out.print("Current Session Id: " + session.getId() + "<br>");
        out.print("Session Created Time: " + session.getCreationTime() + "<br>");
        out.print("Session Last Accessed Time: " +
                    session.getLastAccessedTime() + "<br>");
        out.print("Session Max Inactive Interval Seconds: " +
                    session.getMaxInactiveInterval() + "<br>");
        out.print("<br>");
        out.print("[<b>Session values: " + "</b>]<br>");
        Enumeration names = session.getAttributeNames();
        while (names.hasMoreElements()) {
            String name = (String) names.nextElement();
            out.print("   " + name + " = " + session.getAttribute(name) + "<br>");
        }
      out.print("<br>");
      out.print("[<b>Java System Parameters:" + "</b>]<br>");
      Properties prop = System.getProperties();
      e = prop.propertyNames();
      while (e.hasMoreElements()) {
          String key = (String)e.nextElement();
          out.print("   " + key + " = " + prop.getProperty(key));
          out.println("<br>");
      }
  %>
<%
    Runtime runtime = Runtime.getRuntime();
%>  
  <h2>Runtime Data</h2>
<table>
    <tr>
        <td>Number of Processors</td>
        <td><%=runtime.availableProcessors()%></td>
    </tr>
    <tr>
        <td>Free Memory</td>
        <td><%=runtime.freeMemory()%></td>
    </tr>
    <tr>
        <td>Max Memory</td>
        <td><%=runtime.maxMemory()%></td>
    </tr>
    <tr>
        <td>Total Memory</td>
        <td><%=runtime.totalMemory()%></td>
    </tr>
</table>
