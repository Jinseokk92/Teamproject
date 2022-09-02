package com.example.model1;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MapDAO2 {
   
   public ArrayList<MenuTO> resMenu(String rescode) {
      BufferedReader br=null;
      String line="";
      String what="";
      String link="";
      
      ArrayList<MenuTO> resMenu=new ArrayList<MenuTO>();
      String rmenuimage="";
      String rmenuname="";
      String rmenuprice="";
      
      try {
         
         URL url=new URL("https://m.place.naver.com/restaurant/"+rescode+"/menu/list");

         br=new BufferedReader(new InputStreamReader(url.openStream()));
         
         
         while ((line=br.readLine())!=null) {
            
             if (line.contains("<ul class=\"ZUYk_\">")) {     
               
                 what=line;

               }
            }
         } catch (MalformedURLException e) {
            e.printStackTrace();
         } catch (IOException e) {
            e.printStackTrace();
         } finally {
            if (br!=null) try {br.close();} catch(IOException e) {}
         }
      
      link="<a href=\"/restaurant/"+rescode+"/menu/"+rescode+"_";

         for (int i=1; i<what.split(link).length; i++) {
            MenuTO to=new MenuTO();
            if (what.split(link)[i].contains("이미지 준비중")) {
               //이미지 없음
               to.setRmenuimage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsNGGjrfSqqv8UjL18xS4YypbK-q7po_8oVQ&usqp=CAU");
            } else if (!what.split(link)[i].contains("ground-image")) {
               //이미지 없음
               to.setRmenuimage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsNGGjrfSqqv8UjL18xS4YypbK-q7po_8oVQ&usqp=CAU");
            } else {
               to.setRmenuimage(what.split(link)[i].replace("&quot;","").split("background-image:url")[1].split("<span class=\"place_blind\">")[0].replace(")\">","").replace("(",""));
            }
            
            rmenuname=what.split(link)[i].split("<span class=\"Sqg65\">")[1].split("</span><span class=\"GPETv\">")[0].replaceAll("&amp;", "&");
           if (rmenuname.contains("</span></div></div><div class=\"TvLl7\">")) {
              rmenuname=rmenuname.split("</span></div></div><div class=\"TvLl7\">")[0].replaceAll("&amp;", "&");
           }
            to.setRmenuname(rmenuname);
            
            rmenuprice=what.split(link)[i].split("<div class=\"SSaNE\">")[1].split("</div></div></a></li><li class=\"P_Yxm\">")[0];
           if (rmenuprice.contains("</div></div></a></li></ul><div class=\"KPQDP\">")) {
              rmenuprice=rmenuprice.split("</div></div></a></li></ul><div class=\"KPQDP\">")[0];
           }
            to.setRmenuprice(rmenuprice);
            
            resMenu.add(to);
         }
            /*   
            //이미지   
            for (int i=1; i<what.split(link).length; i++) {
               if (what.split(link)[i].contains("이미지 준비중")) {
                  //System.out.println("이미지 준비중");
               } else if (!what.split(link)[i].contains("ground-image")) {
                  //System.out.println("이미지 준비중");
               } else {
                  //System.out.println(what.split(link)[i].replace("&quot;","").split("background-image:url")[1].split("<span class=\"place_blind\">")[0].replace(")\">","").replace("(",""));
               }
            }
            
             
            //메뉴 이름
            for (int i=1; i<what.split(link).length; i++) {
               System.out.println(what.split(link)[i].split("\"_3yfZ1\">")[1].split("</span></div></div><div class")[0].replace("</span><span class=\"_1-N1N\"><svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 29 16\" class=\"_3mZLQ\" aria-hidden=\"true\"><path fill=\"#ffaf3b\" d=\"M8 0h13c4.4 0 8 3.6 8 8s-3.6 8-8 8H8c-4.4 0-8-3.6-8-8s3.6-8 8-8z\"></path><path fill=\"#fff\" d=\"M13.7 12.9h-1.2V8h-.9v4.5h-1.2V3.2h1.2v3.7h.9V3.1h1.2v9.8zM6.9 9.5c1 0 2.2-.1 2.8-.2l.1 1c-.7.2-2.2.3-3.3.3h-.9V4.2h3.7v1H6.9v4.3zm16.5 2.1h-8.9v-1h2.2V8.7H18v1.9h1.9V8.7h1.3v1.9h2.2v1zm-.9-3.3h-7.2v-1h1.4l-.2-1.8 1.3-.1.1 2H20l.3-2 1.2.2-.3 1.8h1.3v.9zm.1-3.5h-7.2v-1h7.2v1z\"></path></svg><span class=\"place_blind\">대표</span>", "").replace("&amp;", "&"));
            }
            
            System.out.println();
            
            
            //가격               
            for (int i=1; i<what.split(link).length; i++) {
               System.out.println(what.split(link)[i].split("=\"_3qFuX\">")[1].split("</div></div></a></li><li class=\"_3j-Cj\">")[0]);
            }
            */
      return resMenu;
      
   }
}
   