package com.ssafy.board.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ssafy.board.model.BoardDto;
import com.ssafy.board.model.service.BoardService;
import com.ssafy.board.model.service.BoardServiceImpl;
import com.ssafy.util.PageNavigation;
import com.ssafy.util.ParameterCheck;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/article")
public class BoardController {


//	@Autowired
//	private ServletContext servletContext;

	private final BoardService boardService;

	private int pgno;
	private String key;
	private String word;
	private String queryString;

	public BoardController(BoardService boardService) {
		super();
		this.boardService = boardService;
		
	}
	
	@GetMapping("/list")
	public ModelAndView list(@RequestParam Map<String, String> map) throws Exception {
		
		// 이상한 값이 들어오면 무조건 1페이지로 가도록
		pgno = ParameterCheck.notNumberToOne(map.get("pgno"));
		// key와 word의 값이 null이라면 뒷단에서 NullPointerException이 발생할 수 있다 -> null을 Blank로 변환처리
		key = ParameterCheck.nullToBlank(map.get("key"));
		word = ParameterCheck.nullToBlank(map.get("word"));

		map.put("pgno", pgno+"");
		map.put("key", key);
		map.put("word", word);
		
		ModelAndView mav = new ModelAndView();
		List<BoardDto> list = boardService.listArticle(map);
		System.out.println(list);
		System.out.println(map);
		PageNavigation pageNavigation = boardService.makePageNavigation(map);
		mav.addObject("articles", list);
		mav.addObject("navigation", pageNavigation);
		mav.addObject("pgno", map.get("pgno"));
		mav.addObject("key", map.get("key") );
		mav.addObject("word", map.get("word"));
		mav.setViewName("board/list");
		return mav;
	}
	
	@GetMapping("/write")
	public String write(@RequestParam Map<String, String> map, Model model) {
		return "board/write";
	}
	
	@PostMapping("/writes")
	public String write(BoardDto boardDto, HttpSession session,
			RedirectAttributes redirectAttributes) throws Exception {
		
//		UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
//		boardDto.setUserId(userInfo.getUserId());
//		boardDto.setWriter(userInfo.getName());
//		boardService.writeArticle(boardDto);
//		System.out.println("어ㅔ이나낭라ㅓ니ㅏ러ㅣㄴ알");
//		System.out.println(boardDto);
		return "redirect:/article/list";
				
	}
	
	@GetMapping("/view/{number}")
	public String view(@PathVariable("number") String id, Model model) {
		
		try {
			int articleNo = Integer.parseInt(id);
			BoardDto boardDto = boardService.getArticle(articleNo);
			boardService.updateHit(articleNo);
			model.addAttribute("article", boardDto);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "board/view";
	}
	
	@GetMapping("/mvmodify/{number}")
	public String mvmodify(@PathVariable("number") String id, Model model) {
		
		try {
			int articleNo = Integer.parseInt(id);
			BoardDto boardDto = boardService.getArticle(articleNo);
			model.addAttribute("article", boardDto);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "board/modify";
	}
	
	@PostMapping("/modify/{number}")
	public String modify(@PathVariable("number") String id, BoardDto boardDto, Model model) {
		
		try {
			int articleNo = Integer.parseInt(id);
			BoardDto news = boardService.getArticle(articleNo);
			news.setContent(boardDto.getContent());
			news.setSubject(boardDto.getSubject());

			boardService.modifyArticle(news);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/article/view/"+id;
	}
	
	@GetMapping("/delete/{number}")
	public String delete(@PathVariable("number") String id, Model model) {
		
		try {
			int articleNo = Integer.parseInt(id);
			System.out.println(articleNo+"gdgdfgdfg");
			boardService.deleteArticle(articleNo);
			System.out.println("삭제 완");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/article/list";
	}

}
