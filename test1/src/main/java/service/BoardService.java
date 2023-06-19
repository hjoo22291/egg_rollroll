package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import dto.BoardDTO;

public interface BoardService {
	public int insertBoard(BoardDTO dto);
	public int getTotalBoard();
	public int getCountMyBoard(String receiver);
	public List<BoardDTO> getSearchMyBoard(HashMap<String, String> map);
	public List<BoardDTO> boardPagingList(ArrayList limit);
	public BoardDTO updateViewcntAndGetDetail(int seq);
	public int deleteBoard(int seq);
	public int updateBoard(BoardDTO dto);
	public BoardDTO getBoardDetail(int seq);
	
}
