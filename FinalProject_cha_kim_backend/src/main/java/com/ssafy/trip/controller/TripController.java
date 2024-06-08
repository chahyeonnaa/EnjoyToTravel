package com.ssafy.trip.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.trip.model.TripDto;
import com.ssafy.trip.model.service.TripService;
import com.ssafy.trip.model.service.TripServiceImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/trip")
public class TripController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private TripService tripService;
	private ObjectMapper objectMapper;

	public TripController(TripService tripService, ObjectMapper objectMapper) {
		super();
		this.tripService = tripService;
		this.objectMapper = objectMapper;
	}
	
	@GetMapping("mvTrip")
	public String trip() {
		return "trip/trip";
	}

//	@Override
//	public void init(ServletConfig config) throws ServletException {
//		super.init(config);
//		tripService = TripServiceImpl.getTripService();
//	}
//
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String action = request.getParameter("action");
//
//		System.out.println("action: " + action);
//		
//		String path = "";
//		if ("list".equals(action)) {
//			path = list(request, response);
//			forward(request, response, path);
//		} 
//		else if ("getlist".equals(action)) {
//			getList(request, response);
//		} 
//		else if ("mvTrip".equals(action)) {
//			path = "/page/trip.jsp";
//			redirect(request, response, path);
//		}
//		else {
//			redirect(request, response, path);
//		}
//	}
//



	@GetMapping("/list")
	private String list(HttpServletRequest request, HttpServletResponse response) {
		try {

			Integer sidoCode = Integer.parseInt(request.getParameter("sidoCode"));
			Integer contentTypeId = Integer.parseInt(request.getParameter("contentTypeId"));
			String keyword = (String) request.getParameter("keyword");
			
			List<TripDto> list = tripService.listTrip(sidoCode, contentTypeId, keyword);
			request.setAttribute("trips", list);
			request.setAttribute("sidoCode", sidoCode);
			request.setAttribute("contentTypeId", contentTypeId);
			request.setAttribute("keyword", keyword);

			return "/page/trip.jsp";
		} catch (Exception e) {
			e.printStackTrace();
			return "/index.jsp";
		}
	}
	
	@GetMapping("/getlist")
	private void getList(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			Integer sidoCode = Integer.parseInt(request.getParameter("sidoCode"));
			Integer contentTypeId = Integer.parseInt(request.getParameter("contentTypeId"));
			String keyword = (String) request.getParameter("keyword");

			System.out.println("getlist " + sidoCode + " " + contentTypeId + " " + keyword);
			
			List<TripDto> list = tripService.listTrip(sidoCode, contentTypeId, keyword);
			
			
			objectMapper = new ObjectMapper();
			
			String res = objectMapper.writeValueAsString(list);
	        System.out.println(res);
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        PrintWriter writer; 
	        
			writer = response.getWriter();
			writer.write(res);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

//	private void forward(HttpServletRequest request, HttpServletResponse response, String path)
//			throws ServletException, IOException {
//		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
//		dispatcher.forward(request, response);
//	}
//
//	private void redirect(HttpServletRequest request, HttpServletResponse response, String path) throws IOException {
//		response.sendRedirect(request.getContextPath() + path);
//	}
	
//	protected void doPost(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//		request.setCharacterEncoding("utf-8");
//		doGet(request, response);
//	}
}
