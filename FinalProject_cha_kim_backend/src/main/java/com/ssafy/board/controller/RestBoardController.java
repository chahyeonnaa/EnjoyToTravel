package com.ssafy.board.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
@RequestMapping("/api/article")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class RestBoardController {

//	@Autowired
//	private ServletContext servletContext;

	private final BoardService boardService;

	private int pgno;
	private String key;
	private String word;
	private String queryString;

	public RestBoardController(BoardService boardService) {
		super();
		this.boardService = boardService;

	}

	@GetMapping("/boards")
	public ResponseEntity<Map<String, Object>> list(@RequestParam Map<String, String> map) throws Exception {

		// 이상한 값이 들어오면 무조건 1페이지로 가도록
		pgno = ParameterCheck.notNumberToOne(map.get("pgno"));
		// key와 word의 값이 null이라면 뒷단에서 NullPointerException이 발생할 수 있다 -> null을 Blank로
		// 변환처리
		key = ParameterCheck.nullToBlank(map.get("key"));
		word = ParameterCheck.nullToBlank(map.get("word"));

		map.put("pgno", pgno + "");
		map.put("key", key);
		map.put("word", word);

		List<BoardDto> list = boardService.listArticle(map);
		PageNavigation pageNavigation = boardService.makePageNavigation(map);

		Map<String, Object> res = new HashMap<>();
		res.put("articles", list);
		res.put("navigation", pageNavigation);
		res.put("pgno", map.get("pgno"));
		res.put("key", map.get("key"));
		res.put("word", map.get("word"));
		ResponseEntity<Map<String, Object>> resp = new ResponseEntity<Map<String, Object>>(res, HttpStatus.OK);
		return resp;
	}

	@GetMapping("/board/{number}")
	public ResponseEntity<Map<String, Object>> view(@PathVariable("number") String id) throws Exception {

		int articleNo = Integer.parseInt(id);
		BoardDto boardDto = boardService.getArticle(articleNo);
		boardService.updateHit(articleNo);

		Map<String, Object> res = new HashMap<>();
		res.put("article", boardDto);
		ResponseEntity<Map<String, Object>> resp = new ResponseEntity<Map<String, Object>>(res, HttpStatus.OK);
		return resp;
	}

	@PostMapping("/board")
	public ResponseEntity<Map<String, Object>> write(@RequestBody BoardDto boardDto) throws Exception {

		boardDto.setUserId(4);
		boardDto.setWriter("1");
		boardService.writeArticle(boardDto);

		Map<String, Object> res = new HashMap<>();
		res.put("msg", "board 작성 완료");
		ResponseEntity<Map<String, Object>> resp = new ResponseEntity<Map<String, Object>>(res, HttpStatus.OK);
		return resp;

	}

	@PutMapping("/board/{number}")
	public ResponseEntity<Map<String, Object>> modify(@PathVariable("number") String id, @RequestBody BoardDto boardDto)
			throws Exception {

		System.out.println(boardDto);
		
		int articleNo = Integer.parseInt(id);
		BoardDto newArticle = boardService.getArticle(articleNo);
		System.out.println(newArticle);
		newArticle.setContent(boardDto.getContent());
		newArticle.setSubject(boardDto.getSubject());
		System.out.println(newArticle);
		boardService.modifyArticle(newArticle);

		Map<String, Object> res = new HashMap<>();
		res.put("msg", "board 수정 완료");
		ResponseEntity<Map<String, Object>> resp = new ResponseEntity<Map<String, Object>>(res, HttpStatus.OK);
		return resp;
	}

	@DeleteMapping("/board/{number}")
	public ResponseEntity<Map<String, Object>> delete(@PathVariable("number") String id, Model model) throws Exception {

		int articleNo = Integer.parseInt(id);
		boardService.deleteArticle(articleNo);

		Map<String, Object> res = new HashMap<>();
		res.put("msg", "board 삭제 완료");
		ResponseEntity<Map<String, Object>> resp = new ResponseEntity<Map<String, Object>>(res, HttpStatus.OK);
		return resp;
	}

}
