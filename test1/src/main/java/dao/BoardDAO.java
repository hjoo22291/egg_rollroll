package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.BoardDTO;

@Repository
public class BoardDAO {
	@Autowired
	SqlSession session;
	
	//글쓰기
	public int insertBoard(BoardDTO dto) {
		return session.insert("insertBoard", dto);	
	}
	
	//전체 글 갯수
	public int getTotalBoard() {
		return session.selectOne("getTotalBoard");
	}
	
	//개인 글 갯수 조회
	public int getCountMyBoard(String receiver) {
		return session.selectOne("getCountMyBoard", receiver);
	}
	
	//개인 보드 전체글 조회 + 페이징처리
	public List<BoardDTO> getSearchMyBoard(HashMap<String, String> map) {
		return session.selectList("getSearchMyBoard", map);
	}
	
	//페이징처리
	public List<BoardDTO> boardPagingList(ArrayList limit){
		return session.selectList("boardPagingList", limit);
	}
	
	//선택된 게시물 조회수 +1
	public int updateViewcnt(int seq) {
		return session.update("updateViewcnt", seq);
	}
	
	//선택된 게시물 조회
	public BoardDTO getBoardDetail(int seq) {
		return session.selectOne("getBoardDetail", seq);
	}
	
	//게시물 삭제
	public int deleteBoard(int seq) {
		return session.update("deleteBoard", seq);
	}
		
	//게시물 업데이트
	public int updateBoard(BoardDTO dto) {
		//System.out.println("BoardDAO 출력");
		return session.update("updateBoard", dto);
	}
	
}
