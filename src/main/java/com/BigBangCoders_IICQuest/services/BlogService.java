package com.BigBangCoders_IICQuest.services;

import java.util.List;

import com.BigBangCoders_IICQuest.Payloads.BlogDto;
import com.BigBangCoders_IICQuest.Payloads.PostDto;
import com.BigBangCoders_IICQuest.entities.Blog;


public interface BlogService {
	List<Blog> getBlogs();
	
	//PostDto postDto, Integer userId, Integer categoryId
	BlogDto createBlog(BlogDto blogDto);
}
