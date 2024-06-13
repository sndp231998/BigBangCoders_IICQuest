package com.BigBangCoders_IICQuest.Payloads;




import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
public class CommentDto {
	private int id;

	private String content;
	
	private Integer postId;
}
