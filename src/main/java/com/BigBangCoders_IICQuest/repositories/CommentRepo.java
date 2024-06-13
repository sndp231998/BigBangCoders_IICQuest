package com.BigBangCoders_IICQuest.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.BigBangCoders_IICQuest.entities.Comment;

public interface CommentRepo extends JpaRepository<Comment, Integer> {
   
	//List<Comment> findByPostId(Integer postId);
}
