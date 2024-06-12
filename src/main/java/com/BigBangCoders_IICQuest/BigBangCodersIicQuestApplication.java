package com.BigBangCoders_IICQuest;

import org.modelmapper.ModelMapper;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class BigBangCodersIicQuestApplication {

	public static void main(String[] args) {
		SpringApplication.run(BigBangCodersIicQuestApplication.class, args);
	
	
		
	}
	
	@Bean
	public ModelMapper modelMapper() {
		return new ModelMapper();
	}

}
