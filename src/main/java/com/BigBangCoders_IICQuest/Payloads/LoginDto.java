package com.BigBangCoders_IICQuest.Payloads;



import com.BigBangCoders_IICQuest.entities.User;


import jakarta.persistence.ManyToOne;
import lombok.Data;
@Data
public class LoginDto {
	 private String email;
	    private String password;
	    @ManyToOne
		private User user;
}
