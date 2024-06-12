package com.BigBangCoders_IICQuest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.BigBangCoders_IICQuest.Payloads.BlogDto;
import com.BigBangCoders_IICQuest.Payloads.PostDto;
import com.BigBangCoders_IICQuest.entities.Blog;

import com.BigBangCoders_IICQuest.services.BlogService;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/blogs")
public class BlogController {
	@Autowired
    private BlogService blogService;
	
	//create
	@PostMapping("/")
	public ResponseEntity<BlogDto> createBlog(@RequestBody BlogDto blogDto) {
		BlogDto createBlog = this.blogService.createBlog(blogDto);
		return new ResponseEntity<BlogDto>(createBlog, HttpStatus.CREATED);
	}
	
	
	 @GetMapping
	    public List<Blog> getAllBlogs() {
	        return blogService.getBlogs();
	    }
}
