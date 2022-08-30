package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableOAuth2Client;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@EnableOAuth2Client
public class SecurityConfig extends WebSecurityConfigurerAdapter{

   @Autowired
   private MyCustomOAuth2UserService userService;

   @Override
   public void configure(HttpSecurity http) throws Exception {
       http.csrf().disable()
          .authorizeRequests()
          .antMatchers("/upload/**").permitAll()
          .antMatchers("/js/**").permitAll()
          .antMatchers("/css/**").permitAll() // 이부분
           .antMatchers("/images/**").permitAll() // 이부분
          .antMatchers("/google").authenticated()
          .antMatchers("/login/**").permitAll()
          .antMatchers("/welcome").permitAll()
          .antMatchers("/bye").permitAll()
          .antMatchers("/byebye").permitAll()
          .antMatchers("/findpw").permitAll()
          .antMatchers("/sentpw").permitAll()
          .antMatchers("/signup").permitAll()
          .antMatchers("/signedup").permitAll()
          .antMatchers("/chkmail").permitAll()
          .antMatchers("/main").permitAll()
          .antMatchers("/main/**").permitAll()
          .antMatchers("/mypage").permitAll()
          .antMatchers("/mypage/**").permitAll()
          .antMatchers("/adgroups").permitAll()
          .antMatchers("/adgroups/**").permitAll()
          .antMatchers("/admin").permitAll()
          .antMatchers("/admin/**").permitAll()
          .antMatchers("/favorite").permitAll()
          .antMatchers("/favorite/**").permitAll()
          .antMatchers("/notice/read").permitAll()
          .anyRequest().authenticated()
          .and()
          .oauth2Login()
            .userInfoEndpoint()
               .userService(userService);
   }
}
