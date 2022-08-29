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
public class MapDAO {
   
   public ArrayList<String> resDetail(String rescode) {
      BufferedReader br=null;
      
      ArrayList<String> resDetail=new ArrayList<String>();
      String rname="";
      String rloc="";
      String rfac="";
      String rphone="";
      String rtime="";
      String rsite="";
      
      try {
         URL url=new URL("https://m.place.naver.com/restaurant/"+rescode+"/home");

         br=new BufferedReader(new InputStreamReader(url.openStream()));
         
         String line=null;
         while ((line=br.readLine())!=null) {
            if (line.contains("D_Xqt naver-splugin spi_sns_share")) {
                 String what=br.readLine().trim();
                 rname=what.substring(what.indexOf("line-title")+12, what.indexOf("data-line-description")-2).replace("&amp;", "&");
                 rloc=what.substring(what.indexOf("line-description")+18, what.indexOf("data-kakaotalk")-2);              
              }
            
            if (line.contains("<span class=\"place_blind\">편의</span>")) {
                 rfac=line.split("<span class=\"place_blind\">편의</span></strong><div class=\"x8JmK\">")[1].split("</div></li><li class=\"SF_Mq nKpE4\">")[0];
                 if (rfac.contains("</div></li><li class=\"SF_Mq kLgRV\">")) {
                    rfac=rfac.split("</div></li><li class=\"SF_Mq kLgRV\">")[0];
                 }
                 if (rfac.contains("</div></li><li class=\"SF_Mq I5Ypx\">")) {
                    rfac=rfac.split("</div></li><li class=\"SF_Mq I5Ypx\">")[0];
                 }
              }
            
            
             if (line.contains("<span class=\"dry01\">")) {
                rphone=line.split("<span class=\"dry01\">")[1].split("</span><a href=\"#\" role=\"button\" class=\"zkI3M\"")[0];
                if (rphone.contains("</span><span class=\"mnnPt\">")) {
                   rphone=rphone.split("</span><span class=\"mnnPt\">")[0];
                }
             }
            
            
             if (line.contains("<span class=\"MxgIj\"><time aria-hidden=\"true\"")) {
                String what=line.split("time aria-hidden=\"true\">")[1].split("</time><span class=\"place_blind\">")[0];
               
                rtime=what;
            } 
            
             if (line.contains("<div class=\"CQDdi\"><a href=")) {
                rsite=line.split("CQDdi")[1].split("role=\"button\" class=\"JhzE0\">")[0].replaceAll("\"", "").replaceAll("><a href=","");
             }
            
         }
      } catch (MalformedURLException e) {
         e.printStackTrace();
      } catch (IOException e) {
         e.printStackTrace();
      } finally {
         if (br!=null) try {br.close();} catch(IOException e) {}
      }
      
      resDetail.add(rname);
      resDetail.add(rloc);
      resDetail.add(rfac);
      resDetail.add(rphone);
      resDetail.add(rtime);
      resDetail.add(rsite);
   
      return resDetail;
   }
}   
   