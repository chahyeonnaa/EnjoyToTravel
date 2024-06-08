package com.ssafy.board.model.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ssafy.board.model.BoardDto;
import com.ssafy.board.model.dao.BoardDao;
import com.ssafy.util.BoardSize;
import com.ssafy.util.PageNavigation;

@Service
public class BoardServiceImpl implements BoardService {
	
	private BoardDao boardMapper;

	
	public BoardServiceImpl(BoardDao boardMapper) {
		super();
		this.boardMapper = boardMapper;
	}

	@Override
	public void writeArticle(BoardDto boardDto) throws SQLException {
		boardMapper.writeArticle(boardDto);	
	}

	@Override
	public List<BoardDto> listArticle(Map<String, String> map) throws SQLException {
		
		
		Map<String, Object> param = new HashMap<String, Object>();
		String key = map.get("key");
		if("userid".equals(key))
			key = "b.user_id";
		param.put("key", key == null ? "" : key);
		param.put("word", map.get("word") == null ? "" : map.get("word"));
		int pgNo = Integer.parseInt(map.get("pgno") == null ? "1" : map.get("pgno"));
		int start = pgNo * BoardSize.LIST_SIZE - BoardSize.LIST_SIZE;
		param.put("start", start);
		param.put("listsize", BoardSize.LIST_SIZE);

		System.out.println("@@@@ " + param);
		return boardMapper.listArticle(param);

	}


	@Override
	public BoardDto getArticle(int articleNo) throws SQLException {
		return boardMapper.getArticle(articleNo);
	}

	@Override
	public void updateHit(int articleNo) throws SQLException {
		boardMapper.updateHit(articleNo);
		
	}

	@Override
	public void modifyArticle(BoardDto boardDto) throws SQLException {
		boardMapper.modifyArticle(boardDto);
		
	}

	@Override
	public void deleteArticle(int articleNO) throws SQLException {
		boardMapper.deleteArticle(articleNO);
		
	}

	@Override
	public PageNavigation makePageNavigation(Map<String, String> map) throws Exception {
		PageNavigation pageNavigation = new PageNavigation();

		int naviSize = BoardSize.NAVIGATION_SIZE;
		int sizePerPage = BoardSize.LIST_SIZE;
		int currentPage = Integer.parseInt(map.get("pgno"));

		pageNavigation.setCurrentPage(currentPage);
		pageNavigation.setNaviSize(naviSize);
		Map<String, Object> param = new HashMap<String, Object>();
		String key = map.get("key");
		if ("userid".equals(key))
			key = "user_id";
		param.put("key", key == null ? "" : key);
		param.put("word", map.get("word") == null ? "" : map.get("word"));
		int totalCount = boardMapper.getTotalArticleCount(param);
		pageNavigation.setTotalCount(totalCount);
		int totalPageCount = (totalCount - 1) / sizePerPage + 1;
		pageNavigation.setTotalPageCount(totalPageCount);
		boolean startRange = currentPage <= naviSize;
		pageNavigation.setStartRange(startRange);
		boolean endRange = (totalPageCount - 1) / naviSize * naviSize < currentPage;
		pageNavigation.setEndRange(endRange);
		pageNavigation.makeNavigator();

		return pageNavigation;

	}
	
	


}
