package com.BigBangCoders_IICQuest.services;



import java.util.List;

import com.BigBangCoders_IICQuest.Payloads.CommentDto;


public interface CommentService {
	CommentDto createComment(CommentDto commentDto, Integer postId);

	void deleteComment(Integer commentId);
	
	//List<CommentDto> findCommentsByPostId(Integer postId);
	
	

}
