package com.BigBangCoders_IICQuest.services.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.BigBangCoders_IICQuest.Payloads.CommentDto;
import com.BigBangCoders_IICQuest.entities.Comment;
import com.BigBangCoders_IICQuest.entities.Post;
import com.BigBangCoders_IICQuest.exception.ResourceNotFoundException;
import com.BigBangCoders_IICQuest.repositories.CommentRepo;
import com.BigBangCoders_IICQuest.repositories.PostRepo;
import com.BigBangCoders_IICQuest.services.CommentService;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private PostRepo postRepo;

	@Autowired
	private CommentRepo commentRepo;

	@Autowired
	private ModelMapper modelMapper;

	@Override
	public CommentDto createComment(CommentDto commentDto, Integer postId) {

		Post post = this.postRepo.findById(postId)
				.orElseThrow(() -> new ResourceNotFoundException("Post", "post id ", postId));

		Comment comment = this.modelMapper.map(commentDto, Comment.class);

		comment.setPost(post);

		Comment savedComment = this.commentRepo.save(comment);

		return this.modelMapper.map(savedComment, CommentDto.class);
	}

	@Override
	public void deleteComment(Integer commentId) {

		Comment com = this.commentRepo.findById(commentId)
				.orElseThrow(() -> new ResourceNotFoundException("Comment", "CommentId", commentId));
		this.commentRepo.delete(com);
	}

//	@Override
//	public List<CommentDto> findCommentsByPostId(Integer postId) {
//		List<Comment> comments = this.commentRepo.findByPostId(postId);
//        return comments.stream()
//                .map(comment -> this.modelMapper.map(comment, CommentDto.class))
//                .collect(Collectors.toList());
//	}
	
	
//	 @Override
//	    public List<CommentDto> getCommentsByPostId(Integer postId) {
//	        List<Comment> comments = commentRepo.findByPostId(postId);
//	        return comments.stream()
//	                       .map(comment -> modelMapper.map(comment, CommentDto.class))
//	                       .collect(Collectors.toList());
//	    }

}
