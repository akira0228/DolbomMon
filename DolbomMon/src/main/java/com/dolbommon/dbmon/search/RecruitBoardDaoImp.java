	
package com.dolbommon.dbmon.search;
	 
import java.util.List;

import com.dolbommon.dbmon.member.RegularDateVO;
import com.dolbommon.dbmon.member.SpecificDateVO;
import com.dolbommon.dbmon.parent.ApplyToParentInfoVO;
import com.dolbommon.dbmon.parent.ApplyToParentVO;
import com.dolbommon.dbmon.parent.ChildrenVO;

	public interface RecruitBoardDaoImp { 
	//구인게시판 리스트보기 

	public List<RecruitBoardVO> recruitBoardList();
	
	//총 게시물 수 구하기 
	public int getTotalRecords(); 
	
	//레코드 한 개 선택 
	public RecruitBoardVO jobSearchBoardSelect(int no);
	//레코드 한 개 선택 - 자녀
	public ChildrenVO jobSearchChildSelect(int no);
	//레코드 한 개 선택 - 정기적 선택(S)
	public RegularDateVO jobSearchRegularDateSelect(int no);
	//레코드 한 개 선택 - 특정날 선택(R)
	public SpecificDateVO jobSearchSpecificDateSelect(int no);
	
	//선생님이 학부모의 글을 보고 신청했을 때
	public int applyToParent(int no, String t_userid, String p_userid);
	
	//해당 글번호의 학부모아이디 가져오기
	public ApplyToParentVO getParentId(int no);
	
	//신청한 선생님의 정보를 담은 리스트 출력
	public List<ApplyToParentInfoVO> applyDbmSelect(int no); 
	
	//신청한 선생님 거절하기 - 리스트에서 삭제
	public int refusalDbm(String t_userid);
	
	//선생님이 신청 취소하기
	public int applyCancel(String t_userid);
	
	
	
	//이미 신청한 선생님인지 확인하기
	public int applyChk(int no, String userid);
	
	//조회수 증가
	public int hitCount(int job_board_no);
	//조회수 증가
	public int hitCount(RecruitBoardVO vo);
	//구인게시판 글쓰기
	public int recruitBoardInsert(RecruitBoardVO vo); 
	//구인게시판 글 삭제 
	public int recruitBoardDel(int job_board_no, String userid); 
	//구인게시판 글 수정
	public int recruitBoardEditOk(RecruitBoardVO vo); 
	//답글 쓰기 옵션 선택  
	public RecruitBoardVO optionSelect(int job_board_no);
		  
	//public int levelUpdate(RecruitBoardVO vo); 
	//답글 쓰기 
	public int replyBoardInsert(RecruitBoardVO vo); 

	//글번호 구하기
	public List<MemberVO> selectTMemNo(); 
	}
	
	
