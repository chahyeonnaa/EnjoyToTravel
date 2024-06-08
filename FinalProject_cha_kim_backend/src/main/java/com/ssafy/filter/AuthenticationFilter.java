package com.ssafy.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;


import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;

@WebFilter(urlPatterns = {"/*"})
public class AuthenticationFilter extends HttpFilter implements Filter {
	private static final long serialVersionUID = -5406378673430703220L;

	public AuthenticationFilter() {
        super();
    }

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        
        System.out.println(request.getRequestURI());
        
        if (request.getRequestURI().startsWith(request.getContextPath() + "/user") 
        		|| request.getRequestURI().startsWith(request.getContextPath() + "/page/user")
        		|| request.getRequestURI().startsWith(request.getContextPath() + "/assets")
        		|| request.getRequestURI().startsWith(request.getContextPath() + "/index.jsp")
        		) {
            chain.doFilter(servletRequest, servletResponse);
            return;
        }
        
        HttpSession session = request.getSession(false);

//        UserInfo userInfo = session != null ? (UserInfo) session.getAttribute("userInfo") : null;

//        if (userInfo == null && !request.getRequestURI().endsWith("/page/user/login.jsp")) {
            response.sendRedirect(request.getContextPath() + "/page/user/login.jsp");
            return;
//        }

//		chain.doFilter(request, response);
	}
}
