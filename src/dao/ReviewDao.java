package dao;

import java.util.List;
import java.util.Map;

public interface ReviewDao {
	public int insertReview(Map<String,Object> param);
	public List<Map<String,Object>> selectAll(Map<String,Object> param);
	public int countReview(Map<String,Object> param);
	public Map<String,Object> selectOne(String reviewNum);
	public int insertReply(Map<String,Object> reply);
	public int updateReview(String reviewNum);
	public int updateMemberPoint(String memberNum);
	public int deleteReview(String reviewNum);
	
}
