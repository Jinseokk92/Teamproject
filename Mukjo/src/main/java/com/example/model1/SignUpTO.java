package com.example.model1;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class SignUpTO {
	String seq;
	String email;
	String password;
	String name;
	String phone;
	String birth;
}