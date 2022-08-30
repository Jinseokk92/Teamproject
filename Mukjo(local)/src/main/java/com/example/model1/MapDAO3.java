package com.example.model1;

import java.io.IOException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MapDAO3 {

   public static JSONObject jsonParser(String content) {
         JSONParser parser = new JSONParser();
         JSONObject jsonObj = null;

         try {
            Object obj = parser.parse(content);
            jsonObj = (JSONObject)obj;

         } catch(Exception e) {
            e.printStackTrace();
         }
         return jsonObj;
      }

      public static ArrayList<String> crawler(String rescode) {
         ArrayList<String> lists = new ArrayList();
         Document doc = null;

         try {
               doc = Jsoup.connect("https://m.place.naver.com/restaurant/"+rescode+"/photo").get();
            
         } catch (IOException e) {
            e.printStackTrace();
         }
         Elements scripts = doc.getElementsByClass("K0PDV _div");

         for(Element element : scripts) {
            lists.add(element.attr("style").split("background-image:")[1].replace("url(\"", "").split("background")[0].replace("\");", ""));
            //System.out.println(element.attr("style").split("background-image:")[1].replace("url(\"", "").split("background")[0].replace("\");", ""));
         }
         
         return lists;
      }
}