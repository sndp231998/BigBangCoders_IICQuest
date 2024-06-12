package com.BigBangCoders_IICQuest.services.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.modelmapper.ModelMapper;
import com.BigBangCoders_IICQuest.Payloads.BlogDto;

import com.BigBangCoders_IICQuest.entities.Blog;

import com.BigBangCoders_IICQuest.repositories.BlogRepo;

import com.BigBangCoders_IICQuest.services.BlogService;
@Service
public class BlogServiceImpl implements BlogService{
	
	 @Autowired
	    private ModelMapper modelMapper;

	  @Autowired
	    private BlogRepo blogRepo;
	@Override
	public List<Blog> getBlogs() {
		 return blogRepo.findAll();
	}
	@Override
	public BlogDto createBlog(BlogDto blogDto) {
		  Blog blog = this.modelMapper.map(blogDto, Blog.class);
		  blog.setCreatedon(new Date());
		  Blog newBlog = this.blogRepo.save(blog);

	        return this.modelMapper.map(newBlog, BlogDto.class);
	}

}
