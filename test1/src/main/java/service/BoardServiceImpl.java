package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.BoardDAO;
import dto.BoardDTO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO dao;
	
	//글쓰기
	public int insertBoard(BoardDTO dto) {
		return dao.insertBoard(dto);
	}
	
	//전체글갯수
	public int getTotalBoard() {
		return dao.getTotalBoard();
	}
	
	//개인보드갯수조회
	public int getCountMyBoard(String receiver) {
		return dao.getCountMyBoard(receiver);
	}
	
	//개인보드 전체조회 + 페이징처리
	public List<BoardDTO> getSearchMyBoard(HashMap<String, String> map) {
		return dao.getSearchMyBoard(map);
	}
	
	//페이징처리
	public List<BoardDTO> boardPagingList(ArrayList limit) {
		return dao.boardPagingList(limit);
	}
	
	//클릭한 게시물 조회
	public BoardDTO getBoardDetail(int seq) {
		return dao.getBoardDetail(seq);
	}
	
	//선택된 게시물 조회수 증가&조회
	public BoardDTO updateViewcntAndGetDetail(int seq) {
		int updaterow = dao.updateViewcnt(seq);
		return dao.getBoardDetail(seq);
	}
	
	//게시물 삭제
	public int deleteBoard(int seq) {
		return dao.deleteBoard(seq);
	}
	
	//게시물 수정
	public int updateBoard(BoardDTO dto) {
		//System.out.println("Service updateBoard");
		return dao.updateBoard(dto);
	}
}
