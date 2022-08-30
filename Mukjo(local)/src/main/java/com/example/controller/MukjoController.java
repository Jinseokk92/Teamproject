package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.model1.AdminDAO;
import com.example.model1.BoardDAO;
import com.example.model1.BoardListTO;
import com.example.model1.BoardTO;
import com.example.model1.CommentDAO;
import com.example.model1.CommentTO;
import com.example.model1.FavoriteDAO;
import com.example.model1.FavoriteTO;
import com.example.model1.FoodDAO;
import com.example.model1.FoodTO;
import com.example.model1.MainTeamPageTO;
import com.example.model1.MainTeamTO;
import com.example.model1.MapDAO;
import com.example.model1.MapDAO2;
import com.example.model1.MapDAO3;
import com.example.model1.MemberDAO;
import com.example.model1.MemberTO;
import com.example.model1.MenuTO;
import com.example.model1.NoticeDAO;
import com.example.model1.NoticeTO;
import com.example.model1.PageAdminTeamTO;
import com.example.model1.PageMainTeamTO;
import com.example.model1.PageMemberTO;
import com.example.model1.PageTeamMemberTO;
import com.example.model1.ReviewDAO;
import com.example.model1.ReviewTO;
import com.example.model1.SignUpDAO;
import com.example.model1.SignUpTO;
import com.example.model1.TeamBossPageTO;
import com.example.model1.TeamDAO;
import com.example.model1.TeamTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@RestController

public class MukjoController {
   @Autowired
   private SignUpDAO sdao;

   @Autowired
   private MemberDAO mdao;
   
   @Autowired
   private AdminDAO adao;
   
   @Autowired
   private BoardDAO bdao;

   @Autowired
   private TeamDAO tdao;
   
   @Autowired
   private CommentDAO cdao;
   
   @Autowired
   private MapDAO mapdao;
   
   @Autowired
   private MapDAO2 mapdao2;
   
   @Autowired
   private MapDAO3 mapdao3;
   
   @Autowired
   private NoticeDAO ndao;
   
   @Autowired
   private FoodDAO fdao;
   
   @Autowired
   private ReviewDAO rdao;
   
   @Autowired
   private FavoriteDAO favdao;
   
   @RequestMapping(value = "/welcome")
   public ModelAndView login(HttpServletRequest request, Model model) {
      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("login");
      
      return modelAndView;
   }

   @RequestMapping(value = "/login")
   public ModelAndView loginOk(HttpSession session, HttpServletRequest request, Model model) {
      int flag = 10;

      String userName = request.getParameter("username");
      String password = request.getParameter("password");

      MemberTO mto = new MemberTO();
      mto.setEmail(userName);
      mto.setPassword(password);

      flag = mdao.CheckedLogin(mto);
      String name = "";
      if (flag == 1) {
         mto = mdao.MemberLogin(mto);
         session.setAttribute("loginedMemberSeq", mto.getSeq());
         session.setAttribute("loginedMemberName", mto.getName());
      }
      
      
      ModelAndView modelAndView = new ModelAndView();

      modelAndView.setViewName("loginok");
      modelAndView.addObject("flag", flag);

      return modelAndView;
   }

   @RequestMapping(value = "/bye")
   public ModelAndView logoutOk(HttpSession session, HttpServletRequest request, Model model) {
      String loginedMemberSeq = (String) session.getAttribute("loginedMemberSeq");


      int flag = 10;
      if (loginedMemberSeq != null) {
         flag = 1;
         session.removeAttribute("loginedMemberSeq");
         session.removeAttribute("loginedMemberName");
      }

      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("logoutok");
      modelAndView.addObject("flag", flag);

      return modelAndView;
   }
   
   //회운탈퇴 때 쓰임
   @RequestMapping(value = "/byebye")
   public ModelAndView logoutOk2(HttpSession session, HttpServletRequest request, Model model) {
      String loginedMemberSeq = (String) session.getAttribute("loginedMemberSeq");


      int flag = 10;
      if (loginedMemberSeq != null) {
         flag = 1;
         session.removeAttribute("loginedMemberSeq");
         session.removeAttribute("loginedMemberName");
      }

      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("logoutok2");
      modelAndView.addObject("flag", flag);

      return modelAndView;
   }

   @RequestMapping(value="/findpw")
      public ModelAndView forgotPw(HttpSession session,HttpServletRequest request, Model model) {


         return new ModelAndView("forgotpw");
    }
      
   @RequestMapping(value="/sentpw")
   public ModelAndView forgotPwOk(HttpSession session,HttpServletRequest request, Model model) {
        int flag = 10;
         
         
        String mail = request.getParameter("usermail");
        String name = request.getParameter("username");
        MemberTO mto = new MemberTO();
        mto.setEmail(mail);
        mto.setName(name);
        
        
        flag = mdao.forgotPw(mto);
        
        
        model.addAttribute("flag",flag);


         return new ModelAndView("forgotpw_ok");
   }

   @RequestMapping(value = "/signup")
   public ModelAndView signup(HttpServletRequest request, Model model) {

      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("signup");
      return modelAndView;
   }

   @RequestMapping(value = "/signedup")
   public ModelAndView signup_ok(HttpServletRequest request, Model model) {
      SignUpTO sto = new SignUpTO();
      sto.setEmail(request.getParameter("email"));
      sto.setPassword(request.getParameter("password"));
      sto.setName(request.getParameter("name"));
      sto.setPhone(request.getParameter("phone"));
      sto.setBirth(request.getParameter("birth"));

      int flag = sdao.SignUpOk(sto);

      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("signup_ok");
      modelAndView.addObject("flag", flag);
      return modelAndView;
   }

   @RequestMapping(value = "/chkmail")
   public ModelAndView checkmail(HttpServletRequest request, Model model) {
      String mail = request.getParameter("email");
      boolean result = sdao.CheckMail(mail);

      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("checkmail");
      modelAndView.addObject("result", result);
      return modelAndView;
   }

   //가입한 소모임 리스트 + 검색
   @RequestMapping(value = "/main")
   public ModelAndView main(HttpSession session, HttpServletRequest request, Model model) {
     
      String seq=(String) session.getAttribute("loginedMemberSeq");
      String search = request.getParameter("search");

      int cpage = 1;
      if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
         cpage = Integer.parseInt(request.getParameter("cpage"));
      }
      
      MainTeamPageTO mainTeamPageTO=new MainTeamPageTO();
      mainTeamPageTO.setCpage(cpage);
      
      if (search==null) {
         mainTeamPageTO = tdao.teamList(mainTeamPageTO, seq);
      } else {
         mainTeamPageTO = tdao.teamListSearch(mainTeamPageTO, seq, search);
      }
      
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);

      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("main");
      modelAndView.addObject("mainTeamPageTO", mainTeamPageTO);
      modelAndView.addObject("noticeList", noticeList);
      modelAndView.addObject("noticeCount", noticeCount);
      
      return modelAndView;
   }
   
   @RequestMapping(value = "/main/groups/members")
   public ModelAndView mainjoin(HttpSession session, HttpServletRequest request, Model model) {
      String tseq = request.getParameter("tseq");
      String seq=(String) session.getAttribute("loginedMemberSeq");

      int cpage = 1;
      if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
         cpage = Integer.parseInt(request.getParameter("cpage"));
      }
      
      PageTeamMemberTO pageTeamMemberTO = new PageTeamMemberTO();
      pageTeamMemberTO.setCpage(cpage);
      
      pageTeamMemberTO = mdao.teamMemberList(pageTeamMemberTO, tseq);
      
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("mainjoin");
       modelAndView.addObject("pageTeamMemberTO", pageTeamMemberTO);
       modelAndView.addObject("noticeList", noticeList);
       modelAndView.addObject("noticeCount", noticeCount);

       return modelAndView;
   }
   
   //전체 소모임 + 검색
   @RequestMapping(value = "/main/groups")
   public ModelAndView mainall(HttpSession session, HttpServletRequest request, Model model) {
      String seq=(String) session.getAttribute("loginedMemberSeq");
      
      int cpage = 1;
      if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
         cpage = Integer.parseInt(request.getParameter("cpage"));
      }
      String search = request.getParameter("search");
      
      PageMainTeamTO pageMainTeamTO = new PageMainTeamTO();
      pageMainTeamTO.setCpage(cpage);

      if (search==null) {
         pageMainTeamTO = tdao.mainteamList(pageMainTeamTO);
      } else {
         pageMainTeamTO = tdao.mainteamListSearch(pageMainTeamTO, search);
      }
      
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("mainall");
       modelAndView.addObject("pageMainTeamTO", pageMainTeamTO);
       modelAndView.addObject("noticeList", noticeList);
       modelAndView.addObject("noticeCount", noticeCount);
       
       return modelAndView;
   }
   
   //중복이름검사 & 소모임 만들기
   @RequestMapping(value = "/main/groups/new")
   public ModelAndView checktname(HttpServletRequest request, Model model) {
      String tname = request.getParameter("tname");
      String seq = request.getParameter("seq");
      boolean result = tdao.CheckTname(tname, seq);

      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("checktname");
      modelAndView.addObject("result", result);
      return modelAndView;
   }
   
   // 소모임 가입
   @RequestMapping(value = "/main/groups/members/join")
   public ModelAndView jointeam(HttpServletRequest request, Model model) {
      String tseq = request.getParameter("tseq");
      String seq = request.getParameter("seq");
      int flag = tdao.Jointeam(tseq, seq);
      
      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("jointeam");
      modelAndView.addObject("flag", flag);
      return modelAndView;
   }
   
   //구글 - 회원가입? 로그인?
   @RequestMapping(value="/google/login")
   public ModelAndView googlelogin(HttpSession session,HttpServletRequest request, Model model) {
      
      OAuth2User user = getCurrentUser();
      
      String email=(String)user.getAttributes().get("email");
      int count=mdao.EmailCheck(email); 
      
      ModelAndView modelAndView=new ModelAndView();
      
      if(count==0) { //비회원 --> 회원 가입
         modelAndView.setViewName("signup_google");
         modelAndView.addObject("email",email);
      } else if (count==1) { //회원 --> 로그인         
         int flag=1;
         
         MemberTO mto = new MemberTO();
         mto.setEmail(email);
         
         mto=mdao.EmailLogin(mto);
         session.setAttribute("loginedMemberSeq", mto.getSeq());
         session.setAttribute("loginedMemberName", mto.getName());
         modelAndView.setViewName("loginok");
         modelAndView.addObject("flag",flag);
      } else {
         System.out.println("대환장 에러");
      }

      return modelAndView;
      
   }
   
   public OAuth2User getCurrentUser() {
      Authentication auth = SecurityContextHolder.getContext().getAuthentication();
      return ((OAuth2AuthenticationToken)auth).getPrincipal();
   }
      
   //관리자 페이지
   @RequestMapping(value = "/admin")
    public ModelAndView admin(HttpServletRequest request, Model model) {

      int btoday=adao.boardToday();
      int bone=adao.boardOne();
      int btwo=adao.boardTwo();
      int bthree=adao.boardThree();
      int bfour=adao.boardFour();
      int bfive=adao.boardFive();
      int bsix=adao.boardSix();
      int bseven=adao.boardSeven();
      int rtoday=adao.reviewToday();
      int rone=adao.reviewOne();
      int rtwo=adao.reviewTwo();
      int rthree=adao.reviewThree();
      int rfour=adao.reviewFour();
      int rfive=adao.reviewFive();
      int rsix=adao.reviewSix();
      int rseven=adao.reviewSeven();
      String today=adao.today();
      String one=adao.one();
      String two=adao.two();
      String three=adao.three();
      String four=adao.four();
      String five=adao.five();
      String six=adao.six();
      String seven=adao.seven();

       ModelAndView mv = new ModelAndView();
       mv.setViewName("admin");
       mv.addObject("btoday",btoday);
       mv.addObject("bone",bone);
       mv.addObject("btwo",btwo);
       mv.addObject("bthree",bthree);
       mv.addObject("bfour",bfour);
       mv.addObject("bfive",bfive);
       mv.addObject("bsix",bsix);
       mv.addObject("bseven",bseven);
       mv.addObject("rtoday",rtoday);
       mv.addObject("rone",rone);
       mv.addObject("rtwo",rtwo);
       mv.addObject("rthree",rthree);
       mv.addObject("rfour",rfour);
       mv.addObject("rfive",rfive);
       mv.addObject("rsix",rsix);
       mv.addObject("rseven",rseven);
       mv.addObject("today",today);
       mv.addObject("one",one);
       mv.addObject("two",two);
       mv.addObject("three",three);
       mv.addObject("four",four);
       mv.addObject("five",five);
       mv.addObject("six",six);
       mv.addObject("seven",seven);
       
       return mv;
   }
 
   //관리자 페이지 - 전체 회원 목록 + 페이징 + 검색 
   @RequestMapping(value = "/admin/members")
   public ModelAndView adminmemberlists(HttpServletRequest request, Model model) {
      
     String search = request.getParameter("search");
      
      int cpage = 1;
      if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
         cpage = Integer.parseInt(request.getParameter("cpage"));
      }
      
      PageMemberTO pageMemberTO=new PageMemberTO();
      pageMemberTO.setCpage(cpage);
      
      if (search==null) {
          pageMemberTO = mdao.memberList(pageMemberTO);
       } else {
         pageMemberTO = mdao.memberListSearch(pageMemberTO, search);
       }
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("adminmemberlists");
       modelAndView.addObject("pageMemberTO",pageMemberTO);
   
       return modelAndView;
    }
    
    //회원 추방 확인
    @RequestMapping(value = "/admin/members/del")
       public ModelAndView addeletemember(HttpServletRequest request, Model model) {
   
      String name=request.getParameter("name");
      String seq=request.getParameter("seq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("addeletemember");
       modelAndView.addObject("name",name);
       modelAndView.addObject("seq",seq);
   
       return modelAndView;
    }
    
    //회원 추방 확인 후 삭제
    @RequestMapping(value = "/admin/members/del/success")
       public ModelAndView adminmemberdeleteok(HttpServletRequest request, Model model) {
   
      String seq=request.getParameter("seq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("addeletemember_ok");
       int flag=mdao.adDeleteMember(seq);
       modelAndView.addObject("flag",flag);
   
       return modelAndView;
    }
    
   //소모임 목록
    @RequestMapping(value = "/admin/groups")
    public ModelAndView adminteam(HttpServletRequest request, Model model) {
   
      String search = request.getParameter("search");

      int cpage = 1;
      if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
         cpage = Integer.parseInt(request.getParameter("cpage"));
      }
      
      PageAdminTeamTO pageAdminTeamTO=new PageAdminTeamTO();
      pageAdminTeamTO.setCpage(cpage);
      
      if (search==null) {
         pageAdminTeamTO = tdao.teamList(pageAdminTeamTO);
       } else {
         pageAdminTeamTO = tdao.teamListSearch(pageAdminTeamTO, search);
       }

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("adminteam");
       modelAndView.addObject("pageAdminTeamTO",pageAdminTeamTO);
       
       return modelAndView;
    }
    
    //소모임 삭제 확인
    @RequestMapping(value = "/admin/groups/del")
       public ModelAndView addeleteteam(HttpServletRequest request, Model model) {
   
      String tseq=request.getParameter("tseq");
      String tname=request.getParameter("tname");
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("addeleteteam");
       modelAndView.addObject("tname",tname);
       modelAndView.addObject("tseq",tseq);
   
       return modelAndView;
    }
    
    //소모임 삭제 확인 후 삭제
    @RequestMapping(value = "/admin/groups/del/success")
       public ModelAndView addeleteteamok(HttpServletRequest request, Model model) {
   
      String tseq=request.getParameter("tseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("addeleteteam_ok");
       int flag=tdao.adDeleteTeam(tseq);
       modelAndView.addObject("flag",flag);
   
       return modelAndView;
    }
    
    @RequestMapping(value = "/admin/notice")
       public ModelAndView adminnotice(HttpServletRequest request, Model model) {
       
      int cpage = 1;
      if(request.getParameter( "cpage" ) != null && !request.getParameter( "cpage" ).equals( "" ) ) {
         cpage = Integer.parseInt( request.getParameter( "cpage" ) );
      }
      
      BoardListTO boardListTO = new BoardListTO();

      boardListTO.setCpage(cpage);
      //listTO.setTseq("1");
      
      boardListTO = bdao.noticeList(boardListTO);
      
      ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("adminnotice");
       modelAndView.addObject("boardListTO",boardListTO);
   
       return modelAndView;
    }
    
    @RequestMapping(value = "/admin/notice/write")
       public ModelAndView adminnotice_write(HttpServletRequest request, Model model) {
   
      int cpage = 1;
      if( request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
         cpage = Integer.parseInt(request.getParameter("cpage"));
      }
      
      BoardListTO listTO = new BoardListTO();      
      listTO.setCpage(cpage);
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("adminnotice_write");
       modelAndView.addObject("cpage",cpage);
   
       return modelAndView;
    }
    
    @RequestMapping(value = "/admin/notice/write/success")
        public ModelAndView adminnotice_writeok(HttpSession sess,HttpServletRequest request,HttpServletResponse response,Model model) {
        String uploadPath=request.getRealPath("upload");

       int maxFileSize = 20 * 1024 * 1024;
       String encoding = "utf-8";
   
       int flag = 10;
   
       MultipartRequest multi = null;
       BoardTO bto = new BoardTO();
       try {
          multi=new MultipartRequest(request, uploadPath, maxFileSize, encoding, new DefaultFileRenamePolicy());
         
          bto.setSeq((String)sess.getAttribute("loginedMemberSeq"));
          bto.setWriter( (String)sess.getAttribute("loginedMemberName") );
         
          bto.setSubject( multi.getParameter( "subject" ) );
          bto.setContent( multi.getParameter( "content" ) ); 
   
          bto.setFilename( multi.getFilesystemName( "upload" ) );
          if( multi.getFile( "upload" ) != null ) {
             bto.setFilesize( multi.getFile( "upload" ).length() );
          }
          
          flag = bdao.noticeWriteOk(bto);
      } catch (IOException e) {
         System.out.println( "[에러] " + e.getMessage() );
      }
   
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("adminnotice_writeok");
        modelAndView.addObject("flag",flag);
   
        return modelAndView;
    }
    
    @RequestMapping(value = "/admin/notice/view")
       public ModelAndView adminnotice_view(HttpServletRequest request, Model model) {
   
      int cpage = 1;
      if ( request.getParameter( "cpage" ) != null && !request.getParameter( "cpage" ).equals("") ) {
         cpage = Integer.parseInt( request.getParameter( "cpage" ) );
      }
      
      BoardListTO listTO = new BoardListTO();
      listTO.setCpage(cpage);
      
      BoardTO to=new BoardTO();
      to.setBseq(request.getParameter("bseq"));
      to=bdao.noticeView(to);
         
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("adminnotice_view");
       modelAndView.addObject("to",to);
      modelAndView.addObject("cpage",cpage);
   
       return modelAndView;
    }
      
    @RequestMapping(value = "/admin/notice/modify")
       public ModelAndView adminnotice_modify(HttpServletRequest request, Model model) {
   
      int cpage = 1;
      if( request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
         cpage = Integer.parseInt(request.getParameter("cpage"));
      }

      BoardListTO listTO = new BoardListTO();      
      listTO.setCpage(cpage);   
      
      BoardTO to = new BoardTO();
      to.setBseq(request.getParameter("bseq"));
      
      to = bdao.noticeModify(to);
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("adminnotice_modify");
       modelAndView.addObject("to",to);
      modelAndView.addObject("cpage",cpage);
      
       return modelAndView;
    }
   
    //공지 수정 - 확인 후 수정
    @RequestMapping(value = "/admin/notice/modify/success")
    public ModelAndView adminnotice_modifyok(HttpServletRequest request, Model model) {
      String uploadPath=request.getRealPath("upload");

      int cpage = 1;

      BoardListTO listTO = new BoardListTO();      

      int maxFileSize=2*1024*1024; //2메가
      String encType="utf-8";
      
      MultipartRequest multi = null;
      int flag=100;
      String bseq="";
      
      try {
         multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy() );
         
         cpage=Integer.parseInt(multi.getParameter("cpage"));
         listTO.setCpage(cpage);   
         
         BoardTO to=new BoardTO();
         to.setBseq(multi.getParameter("bseq"));
         to.setSubject(multi.getParameter("subject"));
         to.setContent(multi.getParameter("content"));
         String trash=multi.getParameter("trash");
         
         //새 파일명
         to.setNewFileName(multi.getFilesystemName("upload"));
         to.setNewFileSize(0);
         if (multi.getFile("upload")!=null) {
            to.setNewFileSize(multi.getFile("upload").length());
         }
         bseq = multi.getParameter("bseq");
         flag=bdao.noticeModifyOk(to, uploadPath, trash);
      } catch (IOException e) {
         System.out.println( "[에러] " + e.getMessage() );
      }
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("adminnotice_modifyok");
       modelAndView.addObject("flag",flag);
      modelAndView.addObject("cpage",cpage);
      modelAndView.addObject("bseq",bseq);
      
       return modelAndView;
    }
   
    
    //공지 삭제 확인
    @RequestMapping(value = "/admin/notice/del")
       public ModelAndView adminnotice_delete(HttpServletRequest request, Model model) {
   
      String bseq=request.getParameter("bseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("adminnotice_delete");
       modelAndView.addObject("bseq",bseq);
   
       return modelAndView;
    }
    
    //공지 삭제 확인 후 삭제
    @RequestMapping(value = "/admin/notice/del/success")
       public ModelAndView adminnotice_deleteok(HttpServletRequest request, Model model) {
        String uploadPath=request.getRealPath("upload");
      String bseq=request.getParameter("bseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("adminnotice_deleteok");
       int flag=bdao.noticeDelete(bseq, uploadPath);
       modelAndView.addObject("flag",flag);
   
       return modelAndView;
    }
    
    //즐찾 목록
    @RequestMapping(value = "/favorite")
    public ModelAndView favorite(HttpSession session, HttpServletRequest request, Model model) {
   
        String seq=(String) session.getAttribute("loginedMemberSeq");
        String search = request.getParameter("search");

        ArrayList<FavoriteTO> favList=favdao.favList(seq);
        
        ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
        int noticeCount=ndao.noticeCount(seq);
        
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("favorite");
        modelAndView.addObject("favList", favList);
        modelAndView.addObject("noticeList", noticeList);
        modelAndView.addObject("search", search);
        modelAndView.addObject("noticeCount", noticeCount);
         
        return modelAndView;
    }
    
    //즐찾 추가
    @RequestMapping(value = "/favorite/add")
    public ModelAndView favoriteadd(HttpSession session, HttpServletRequest request, Model model) {

        String seq=(String) session.getAttribute("loginedMemberSeq");
        String restcode=request.getParameter("id");

        favdao.favAdd(seq, restcode);
        
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("favoriteadd");
         
        return modelAndView;
    }
    
    //즐찾 취소
    @RequestMapping(value = "/favorite/del")
    public ModelAndView favoritedel(HttpSession session, HttpServletRequest request, Model model) {

       String seq=(String) session.getAttribute("loginedMemberSeq");
        String restcode=request.getParameter("id");

        favdao.favDelete(seq, restcode);
        
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("favoritedel");
         
        return modelAndView;
    }
    
    //소모임 게시판 + 검색
   @RequestMapping( "/main/board")   
   public ModelAndView boardList(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {
      String seq=(String) session.getAttribute("loginedMemberSeq");
      
     int cpage = 1;
      if(request.getParameter( "cpage" ) != null && !request.getParameter( "cpage" ).equals( "" ) ) {
         cpage = Integer.parseInt( request.getParameter( "cpage" ) );
      }
         
      String search=request.getParameter("search");
      String which=request.getParameter("which");

      BoardListTO listTO = new BoardListTO();
      listTO.setCpage(cpage);
      listTO.setTseq(request.getParameter("tseq"));
      TeamTO tto = bdao.teamName(listTO.getTseq());
      model.addAttribute("tseq",listTO.getTseq());
      model.addAttribute("tname",tto.getTname());
      
      ArrayList<BoardTO> noticeLists = new ArrayList<BoardTO>();
      if (search==null) {
         listTO = bdao.boardList(listTO);
         noticeLists = bdao.noticeList();
      } else {
         listTO = bdao.boardListSearch(listTO, which, search);
         noticeLists = bdao.noticeListSearch(which, search);
      }
            
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      
      model.addAttribute("noticeLists",noticeLists);
      model.addAttribute("listTO",listTO);
      model.addAttribute("noticeList", noticeList);
      model.addAttribute("noticeCount", noticeCount);
      
      return new ModelAndView("somoimboard_list"); 
      
   }
   
   @RequestMapping( "/main/board/write")   
   public ModelAndView boardWrite(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {
      String seq=(String) session.getAttribute("loginedMemberSeq");

      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      
      model.addAttribute("noticeList", noticeList);
      model.addAttribute("noticeCount", noticeCount);

      return new ModelAndView("somoimboard_write"); 
   }
   
   @RequestMapping( "/main/board/write/success")   
   public ModelAndView boardWriteOk(HttpSession sess,HttpServletRequest request,HttpServletResponse response,Model model) throws IOException {
       String uploadPath=request.getRealPath("upload");
      int maxFileSize = 20 * 1024 * 1024;
      String encoding = "utf-8";
      int flag = 10;
      
      MultipartRequest multi = new MultipartRequest(request, uploadPath, maxFileSize, encoding, new DefaultFileRenamePolicy());
      BoardTO bto = new BoardTO();
      
      
      bto.setTseq(multi.getParameter("tseq"));
      model.addAttribute("tseq",bto.getTseq());
      bto.setSeq((String)sess.getAttribute("loginedMemberSeq"));
      bto.setWriter( (String)sess.getAttribute("loginedMemberName") );
      
      bto.setSubject( multi.getParameter( "subject" ) );
      bto.setContent( multi.getParameter( "content" ) ); 

      bto.setFilename( multi.getFilesystemName( "upload" ) );
      File file = multi.getFile( "upload" ); 
      if( file != null ) {
         bto.setFilesize( file.length() );
      }
      
      
      flag = bdao.boardWriteOk(bto);
      
      model.addAttribute("flag",flag);
      
      
      return new ModelAndView("somoimboard_writeok"); 
   }

   @RequestMapping( "/main/board/view")   
      public ModelAndView boardView(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {

     String seq=(String) session.getAttribute("loginedMemberSeq");

      String tseq = request.getParameter("tseq");
      String bseq = request.getParameter("bseq");
      BoardTO bto = new BoardTO();
      bto.setBseq(bseq);
      bto.setTseq(tseq);
      
      bto = bdao.boardView(bto);
      ArrayList<CommentTO> commentLists = cdao.commentView(bseq);
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      
      model.addAttribute("bto",bto);
      model.addAttribute("commentLists",commentLists);
      model.addAttribute("noticeList", noticeList);
      model.addAttribute("noticeCount", noticeCount);

         return new ModelAndView("somoimboard_view"); 
   }
   
   @RequestMapping( "/main/board/view/notice")   
      public ModelAndView boardnView(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {

     String seq=(String) session.getAttribute("loginedMemberSeq");

      String tseq = request.getParameter("tseq");
      String bseq = request.getParameter("bseq");
      BoardTO bto = new BoardTO();
      bto.setBseq(bseq);
      bto.setTseq(tseq);
      
      bto = bdao.boardView(bto);
      int noticeCount=ndao.noticeCount(seq);
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);

      model.addAttribute("noticeList", noticeList);
      model.addAttribute("bto",bto);
      model.addAttribute("noticeCount", noticeCount);

      
         return new ModelAndView("somoimboard_nview"); 
   }
   
   @RequestMapping( "/main/board/view/del/success")   
   public ModelAndView boardDeleteOk(HttpServletRequest request,HttpServletResponse response,Model model) {
      BoardTO to = new BoardTO();
      String bseq = request.getParameter("bseq");
      String uploadPath=request.getRealPath("upload");

      to.setBseq(bseq);      

      int flag = bdao.boardDeleteOk(to, uploadPath);

      model.addAttribute("flag", flag );

      
      return new ModelAndView("somoimboard_deleteok");
   }
   
   @RequestMapping( "main/board/view/modify")   
   public ModelAndView boardModify(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {
      String seq=(String) session.getAttribute("loginedMemberSeq");

      BoardTO bto = new BoardTO();
      String bseq = request.getParameter("bseq");


      bto.setBseq(bseq);         

      bto = bdao.boardModify(bto);
      
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      
      model.addAttribute("bto",bto);
      model.addAttribute("noticeList", noticeList);
      model.addAttribute("noticeCount", noticeCount);
      
      return new ModelAndView("somoimboard_modify");
   }
   
   @RequestMapping( "main/board/view/modify/success")   
   public ModelAndView boardModifyOk(HttpServletRequest request,HttpServletResponse response,Model model) {
       String uploadPath=request.getRealPath("upload");

      int maxFileSize = 20 * 1024 * 1024;
      String encoding = "utf-8";

      MultipartRequest multi = null;
      try {
         multi = new MultipartRequest( request, uploadPath, maxFileSize, encoding, new DefaultFileRenamePolicy() );
         
      } catch (IOException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
      String tseq = multi.getParameter("tseq");
      String bseq = multi.getParameter("bseq");
      String cpage = multi.getParameter("cpage");
      String trash = multi.getParameter("trash");

      BoardTO to = new BoardTO();
      to.setBseq( bseq );
      to.setSubject( multi.getParameter( "subject" ) );
      to.setContent( multi.getParameter( "content" ) );
      to.setFilename( multi.getFilesystemName( "upload" ) );
      if( multi.getFile( "upload" ) != null ) {
         to.setFilesize( multi.getFile( "upload" ).length() );
      }

      int flag = bdao.boardModifyOk(to, uploadPath, trash);
      

      model.addAttribute("flag", flag );
      model.addAttribute("tseq",tseq);
      model.addAttribute("bseq",bseq);
      model.addAttribute("cpage",cpage);

      
      return new ModelAndView("somoimboard_modifyok");
   }
   
   //소모임 회원 목록
   @RequestMapping(value = "main/members")
    public ModelAndView somoimboard_memberlist(HttpSession session, HttpServletRequest request, Model model) {
     String seq=(String) session.getAttribute("loginedMemberSeq");

      String tseq = request.getParameter("tseq");
      String search = request.getParameter("search");

      int cpage = 1;
      if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
         cpage = Integer.parseInt(request.getParameter("cpage"));
      }
      
      PageTeamMemberTO pageTeamMemberTO = new PageTeamMemberTO();
      pageTeamMemberTO.setCpage(cpage);

      if (search==null) {
         pageTeamMemberTO = tdao.memberList(pageTeamMemberTO, tseq);
      } else {
         pageTeamMemberTO = tdao.memberListSearch(pageTeamMemberTO, tseq, search);
      }

      String tname=tdao.tnameFromTseq(tseq);
      String jangseq=tdao.jangseq(tseq);
      int noticeCount=ndao.noticeCount(seq);
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);

      ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("somoimboard_memberlist");
       modelAndView.addObject("pageTeamMemberTO", pageTeamMemberTO);
       modelAndView.addObject("tname", tname);
       modelAndView.addObject("jangseq", jangseq);
       modelAndView.addObject("noticeList", noticeList);
       modelAndView.addObject("noticeCount", noticeCount);
       
       return modelAndView;
    }
   
   @RequestMapping(value = "main/quitgroup")
    public ModelAndView somoimboard_memberexit(HttpSession session, HttpServletRequest request, Model model) {
      
      String seq=(String) session.getAttribute("loginedMemberSeq");
      String tseq = request.getParameter("tseq");
      String tname=tdao.tnameFromTseq(tseq);
      String jangseq=tdao.jangseq(tseq);

      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("somoimboard_memberexit");
       modelAndView.addObject("tname",tname);
       modelAndView.addObject("seq", seq);
       modelAndView.addObject("jangseq", jangseq);
       modelAndView.addObject("noticeList", noticeList);
       modelAndView.addObject("noticeCount", noticeCount);
       
       return modelAndView;
    }
   
   @RequestMapping(value = "main/quitgroup/success")
    public ModelAndView somoimboard_memberexitok(HttpSession session, HttpServletRequest request, Model model) {
         
      String seq=(String) session.getAttribute("loginedMemberSeq");
      String tseq = request.getParameter("tseq");
      int flag=tdao.memberExit(seq, tseq);      
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("somoimboard_memberexitok");
       modelAndView.addObject("flag",flag);
   
       return modelAndView;
    }
   
   
   @RequestMapping( "/main/board/view/writecmt")   
      public ModelAndView cmtWriteOk(HttpSession sess,HttpServletRequest request,HttpServletResponse response,Model model) {
      CommentTO cto = new CommentTO();
      
      cto.setSeq((String)sess.getAttribute("loginedMemberSeq"));
      cto.setBseq( request.getParameter("bseq") );
      cto.setCContent( request.getParameter( "cContent" ) ); 

      int flag = cdao.commentWrite(cto);
      
      model.addAttribute("flag",flag);
      

      
         return new ModelAndView("somoimboardcmt_writeok"); 
   }
   
   @RequestMapping( "/main/board/view/delcmt")   
      public ModelAndView cmtDeleteOk(HttpSession sess,HttpServletRequest request,HttpServletResponse response,Model model) {
      CommentTO cto = new CommentTO();
      
      cto.setCseq(request.getParameter("cseq"));

      int flag = cdao.commentDelete(cto);
      
      model.addAttribute("flag",flag);

         return new ModelAndView("somoimboardcmt_deleteok"); 
   }
   
   @RequestMapping(value = "/mypage")
       public ModelAndView myPage(HttpSession session, HttpServletRequest request, Model model) {
   
      String seq=(String) session.getAttribute("loginedMemberSeq");
      
      int cpage = 1;
      if(request.getParameter( "cpage" ) != null && !request.getParameter( "cpage" ).equals( "" ) ) {
         cpage = Integer.parseInt( request.getParameter( "cpage" ) );
      }
      
      String search=request.getParameter("search");
      String which=request.getParameter("which");
      
      BoardListTO boardListTO = new BoardListTO();
      boardListTO.setCpage(cpage);
      
      ArrayList<BoardTO> boardList = new ArrayList<BoardTO>();
      if (search==null) {
         boardListTO = bdao.myPageList(boardListTO, seq);
      } else {
         boardListTO = bdao.myPageListSearch(boardListTO, seq, which, search);
      }
            
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("myPage");
       modelAndView.addObject("boardListTO",boardListTO);
       modelAndView.addObject("noticeList", noticeList);
       modelAndView.addObject("noticeCount", noticeCount);
       
       return modelAndView;
    }
      
   @RequestMapping(value = "/mypage/view")
       public ModelAndView myPage_view(HttpSession session, HttpServletRequest request, Model model) {
         String seq=(String) session.getAttribute("loginedMemberSeq");

      int cpage = 1;
      if ( request.getParameter( "cpage" ) != null && !request.getParameter( "cpage" ).equals("") ) {
         cpage = Integer.parseInt( request.getParameter( "cpage" ) );
      }
      
      BoardListTO listTO = new BoardListTO();
      listTO.setCpage(cpage);
      
      BoardTO to=new BoardTO();
      to.setBseq(request.getParameter("bseq"));
      to=bdao.myPageView(to);
      ArrayList<CommentTO> commentLists = cdao.commentView(request.getParameter("bseq"));
      int noticeCount=ndao.noticeCount(seq);
      String tseq=to.getTseq();
      String tname=bdao.myPageViewTname(tseq);
         
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("myPage_view");
       modelAndView.addObject("to",to);
      modelAndView.addObject("cpage",cpage);
      modelAndView.addObject("tname",tname);
      modelAndView.addObject("tseq",tseq);
      modelAndView.addObject("commentLists",commentLists);
      modelAndView.addObject("noticeList", noticeList);
      modelAndView.addObject("noticeCount", noticeCount);
      
       return modelAndView;
    }
   
   @RequestMapping( "/mypage/view/writecmt")   
   public ModelAndView mypagecmtWriteOk(HttpSession sess,HttpServletRequest request,HttpServletResponse response,Model model) {
      CommentTO cto = new CommentTO();
      
      cto.setSeq((String)sess.getAttribute("loginedMemberSeq"));
      cto.setBseq( request.getParameter("bseq") );
      cto.setCContent( request.getParameter( "cContent" ) ); 
   
      int flag = cdao.commentWrite(cto);
      
      model.addAttribute("flag",flag);
      
 
      return new ModelAndView("myPage_cmt_writeok"); 
   }

   @RequestMapping( "/mypage/view/delcmt")   
      public ModelAndView mypagecmtDeleteOk(HttpSession sess,HttpServletRequest request,HttpServletResponse response,Model model) {
      CommentTO cto = new CommentTO();
      
      cto.setCseq(request.getParameter("cseq"));
   
      int flag = cdao.commentDelete(cto);
      
      model.addAttribute("flag",flag);
   
         return new ModelAndView("myPage_cmt_deleteok"); 
   }
   
   //내가 쓴 글 보기에서 게시물 삭제 확인
    @RequestMapping(value = "/mypage/view/del")
       public ModelAndView myPage_delete(HttpServletRequest request, Model model) {
   
      String bseq=request.getParameter("bseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("myPage_delete");
       modelAndView.addObject("bseq",bseq);
   
       return modelAndView;
    }
    
    //내가 쓴 글 보기에서 게시물 삭제 
    @RequestMapping(value = "/mypage/view/del/success")
       public ModelAndView myPage_deleteok(HttpServletRequest request, Model model) {
        String uploadPath=request.getRealPath("upload");
      String bseq=request.getParameter("bseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("myPage_deleteok");
       int flag=bdao.noticeDelete(bseq, uploadPath);
       modelAndView.addObject("flag",flag);
   
       return modelAndView;
    }
   
    //글 수정
    @RequestMapping(value = "/mypage/view/modify")
       public ModelAndView myPage_modify(HttpSession session, HttpServletRequest request, Model model) {
         String seq=(String) session.getAttribute("loginedMemberSeq");

      int cpage = 1;
      if( request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
         cpage = Integer.parseInt(request.getParameter("cpage"));
      }

      BoardListTO listTO = new BoardListTO();      
      listTO.setCpage(cpage);   
      
      BoardTO to = new BoardTO();
      to.setBseq(request.getParameter("bseq"));
      
      to = bdao.noticeModify(to);
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("myPage_modify");
       modelAndView.addObject("to",to);
      modelAndView.addObject("cpage",cpage);
      modelAndView.addObject("noticeList", noticeList);
      modelAndView.addObject("noticeCount", noticeCount);
      
       return modelAndView;
    }
   
    //글 수정 - 확인 후 수정
    @RequestMapping(value = "/mypage/view/modify/success")
    public ModelAndView myPage_modifyok(HttpServletRequest request, Model model) {
      String uploadPath=request.getRealPath("upload");

      int cpage = 1;

      BoardListTO listTO = new BoardListTO();      
         
      int maxFileSize=2*1024*1024; //2메가
      String encType="utf-8";
      
      MultipartRequest multi = null;
      int flag=100;
      String bseq="";
      
      try {
         multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy() );
         
         cpage=Integer.parseInt(multi.getParameter("cpage"));
         listTO.setCpage(cpage);
         
         BoardTO to=new BoardTO();
         to.setBseq(multi.getParameter("bseq"));
         to.setSubject(multi.getParameter("subject"));
         to.setContent(multi.getParameter("content"));
         String trash = multi.getParameter("trash");

         //새 파일명
         to.setNewFileName(multi.getFilesystemName("upload"));
         to.setNewFileSize(0);
         if (multi.getFile("upload")!=null) {
            to.setNewFileSize(multi.getFile("upload").length());
         }
         bseq = multi.getParameter("bseq");
         flag=bdao.noticeModifyOk(to, uploadPath, trash);
      } catch (IOException e) {
         System.out.println( "[에러] " + e.getMessage() );
      }
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("myPage_modifyok");
       modelAndView.addObject("flag",flag);
      modelAndView.addObject("cpage",cpage);
      modelAndView.addObject("bseq",bseq);
      
       return modelAndView;
    }
    
   //내 정보수정 확인
   @RequestMapping(value = "/mypage/change")
       public ModelAndView mypage_modify(HttpSession session, HttpServletRequest request, Model model) {
   
      String seq=(String) session.getAttribute("loginedMemberSeq");
      MemberTO to=mdao.myPageModify(seq);
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("myPage_info_modify");
       modelAndView.addObject("to",to);
       modelAndView.addObject("noticeList", noticeList);
       modelAndView.addObject("noticeCount", noticeCount);
       
       return modelAndView;
    }
   
   //내정보수정 
   @RequestMapping(value = "/mypage/change/success")
       public ModelAndView mypage_modifyok(HttpSession session, HttpServletRequest request, Model model) {
   
      String seq=(String) session.getAttribute("loginedMemberSeq");
      MemberTO to=new MemberTO();
      to.setSeq(seq);
      to.setEmail(request.getParameter("email"));
      to.setBirth(request.getParameter("birth"));
      to.setPhone(request.getParameter("phone"));
      to.setPassword(request.getParameter("pwd1"));
   
      int flag=mdao.myPageModifyOk(to);
      
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("myPage_info_modifyok");
       modelAndView.addObject("flag",flag);
       
       return modelAndView;
    }
   
   //회원탈퇴
   @RequestMapping(value = "/mypage/change/quit/success")
   public ModelAndView myPage_info_deleteok(HttpServletRequest request, Model model) {
       
       String seq=request.getParameter("seq");
       int flag=mdao.myPage_info_delete(seq);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("myPage_info_deleteok");
        modelAndView.addObject("flag",flag);
        modelAndView.addObject("seq",seq);
        
        return modelAndView;
    }
   
   // 소모임페이지
   @RequestMapping( "/main/search/info")   
   public ModelAndView somoimboard_home(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {
     String seq=(String) session.getAttribute("loginedMemberSeq");
      String rescode=request.getParameter("id");
      String tseq=request.getParameter("tseq");
      
      ArrayList<String> resDetail=mapdao.resDetail(rescode);
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      String onoff=favdao.onoff(seq, rescode);
      String avg=fdao.avg(rescode, tseq);
      
      ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("somoimboard_home");
       modelAndView.addObject("resDetail",resDetail);
       modelAndView.addObject("noticeList", noticeList);
       modelAndView.addObject("noticeCount", noticeCount);
       modelAndView.addObject("onoff", onoff);
       modelAndView.addObject("avg", avg);
       
       return modelAndView;
   }
   
   @RequestMapping( "/main/search/review")   
   public ModelAndView boardReview(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {
     String seq=(String) session.getAttribute("loginedMemberSeq");
     String rescode=request.getParameter("id");
      String tseq = request.getParameter("tseq");
      ReviewTO rto = new ReviewTO();
       
      rto.setRest(rescode);
      rto.setTseq(tseq);
      
      ArrayList<ReviewTO> lists = rdao.reviewLists(rto);
      String onoff=favdao.onoff(seq, rescode);
      String avg=fdao.avg(rescode, tseq);
      
      model.addAttribute("lists",lists);
     
      ArrayList<String> resDetail=mapdao.resDetail(rescode);
      String rname=resDetail.get(0);
       
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      
      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("somoimboard_review");
      modelAndView.addObject("noticeList", noticeList);
      modelAndView.addObject("noticeCount", noticeCount);
      modelAndView.addObject("rname",rname);
      modelAndView.addObject("onoff", onoff);
      modelAndView.addObject("avg", avg);

      return modelAndView;
   }
   
   @RequestMapping( "/main/search/review/del")   
   public ModelAndView boardReviewWrite(HttpSession sess,HttpServletRequest request,HttpServletResponse response,Model model) {
      
      String rseq = request.getParameter("rseq");

      ReviewTO rto = new ReviewTO();

      rto.setRseq(rseq);
      
      int flag = rdao.reviewDelete(rto);
      
      model.addAttribute("rto",rto);
      model.addAttribute("flag",flag);
      

      return new ModelAndView("somoimboard_reviewdelete"); 
   }
   
   @RequestMapping( "/main/search/review/write")   
   public ModelAndView boardReviewDelete(HttpSession sess,HttpServletRequest request,HttpServletResponse response,Model model) {
      
      String rescode=request.getParameter("id");
      String tseq = request.getParameter("tseq");
      String content = request.getParameter("content");
      String seq = (String)sess.getAttribute("loginedMemberSeq");
      String star = request.getParameter("star");
      ReviewTO rto = new ReviewTO();
       

      rto.setTseq(tseq);
      rto.setSeq(seq);
      rto.setRest(rescode);
      rto.setRcontent(content);
      // 점수가없음
      rto.setStar(star);
      
      int flag = rdao.reviewWrite(rto);
      
      model.addAttribute("rto",rto);
      model.addAttribute("flag",flag);
      

      return new ModelAndView("somoimboard_reviewwrite"); 
   }
   
   @RequestMapping( "/main/search/menu")   
   public ModelAndView somoimboard_menu(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {
     String seq=(String) session.getAttribute("loginedMemberSeq");
      String rescode=request.getParameter("id");
      String tseq=request.getParameter("tseq");
      
      ArrayList<String> resDetail=mapdao.resDetail(rescode);
      String rname=resDetail.get(0);
      
      ArrayList<MenuTO> resMenu=mapdao2.resMenu(rescode);
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      String onoff=favdao.onoff(seq, rescode);
      String avg=fdao.avg(rescode, tseq);

      ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("somoimboard_menu");
       modelAndView.addObject("resMenu",resMenu);
       modelAndView.addObject("rname",rname);
       modelAndView.addObject("noticeList", noticeList);
       modelAndView.addObject("noticeCount", noticeCount);
       modelAndView.addObject("onoff", onoff);
       modelAndView.addObject("avg", avg);
       
       return modelAndView;      
   }
   
   @RequestMapping( "/main/search/pic")   
   public ModelAndView somoimboard_picture(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {
     String seq=(String) session.getAttribute("loginedMemberSeq");
      String rescode=request.getParameter("id");
      String tseq=request.getParameter("tseq");
      
      ArrayList<String> resDetail=mapdao.resDetail(rescode);
      String rname=resDetail.get(0);
      
      ArrayList<String> pic=mapdao3.crawler(rescode);
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      String onoff=favdao.onoff(seq, rescode);
      String avg=fdao.avg(rescode, tseq);
      
      ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("somoimboard_picture");
       modelAndView.addObject("pic",pic);
       modelAndView.addObject("rname",rname);
       modelAndView.addObject("noticeList", noticeList);
       modelAndView.addObject("noticeCount", noticeCount);
       modelAndView.addObject("onoff", onoff);
       modelAndView.addObject("avg", avg);

       return modelAndView;
   }
   
   @RequestMapping( "/main/search")
   public ModelAndView boardSearch(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {
   String seq=(String) session.getAttribute("loginedMemberSeq");

   String tseq=request.getParameter("tseq");
    String tname=fdao.tnameFromTseq(tseq);
    String search = request.getParameter("search");
    
      ArrayList<FoodTO> lists = fdao.crawler(search,tseq);
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      
      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("somoimboard_search");
      modelAndView.addObject("tname", tname);
      modelAndView.addObject("lists", lists);       
      modelAndView.addObject("noticeList", noticeList);
      modelAndView.addObject("noticeCount", noticeCount);
      
      return modelAndView;
   }
   
   @RequestMapping( "/adgroups")   
      public ModelAndView boss(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {

      String seq=(String) session.getAttribute("loginedMemberSeq");

      int cpage = 1;
      if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
         cpage = Integer.parseInt(request.getParameter("cpage"));
      }
      
      TeamBossPageTO teamBossPageTO=new TeamBossPageTO();
      teamBossPageTO.setCpage(cpage);
      
      teamBossPageTO = tdao.bossTeamList(teamBossPageTO, seq);
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);

      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("boss");
      modelAndView.addObject("teamBossPageTO", teamBossPageTO);
      modelAndView.addObject("noticeList", noticeList);
      modelAndView.addObject("noticeCount", noticeCount);
      
      return modelAndView; 
    }
      
    @RequestMapping( "/adgroups/members")   
    public ModelAndView bossmember(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {
      String myseq=(String) session.getAttribute("loginedMemberSeq");
      String search = request.getParameter("search");
      
      int cpage = 1;
      if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
         cpage = Integer.parseInt(request.getParameter("cpage"));
      }
      String tseq=request.getParameter("tseq");
      
      PageMemberTO pageMemberTO=new PageMemberTO();
      pageMemberTO.setCpage(cpage);
      
      if (search==null) {
         pageMemberTO = tdao.bossMember(pageMemberTO, tseq);
       } else {
          pageMemberTO = tdao.bossMemberSearch(pageMemberTO, tseq, search);
       }
      
      String tname=tdao.tnameFromTseq(tseq);
      ArrayList<NoticeTO> noticeList=ndao.noticeList(myseq);
      int noticeCount=ndao.noticeCount(myseq);
      
      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("bossmember");
      modelAndView.addObject("pageMemberTO", pageMemberTO);
      modelAndView.addObject("myseq", myseq);
      modelAndView.addObject("tseq", tseq);
      modelAndView.addObject("tname", tname);
      modelAndView.addObject("noticeList", noticeList);
      modelAndView.addObject("noticeCount", noticeCount);
      
      return modelAndView; 
    }
      
    //권한 위임 확인
   @RequestMapping(value = "/adgroups/members/chgleader")
       public ModelAndView bosschange(HttpServletRequest request, Model model) {
   
      String name=request.getParameter("name");
      String seq=request.getParameter("seq");
      String tseq=request.getParameter("tseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("bosschange");
       modelAndView.addObject("name",name);
       modelAndView.addObject("seq",seq);
       modelAndView.addObject("tseq",tseq);
   
       return modelAndView;
    }
    
   //권한 위임
   @RequestMapping(value = "/adgroups/members/chgleader/success")
       public ModelAndView bosschangeok(HttpServletRequest request, Model model) {
   
      String seq=request.getParameter("seq");
      String tseq=request.getParameter("tseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("bosschangeok");
       int flag=tdao.BossChange(seq, tseq);
       modelAndView.addObject("flag",flag);
   
       return modelAndView;
    }
    
   //소모임으로부터 추방 확인
    @RequestMapping(value = "/adgroups/members/delmember")
       public ModelAndView bossdeletemember(HttpServletRequest request, Model model) {
   
      String name=request.getParameter("name");
      String seq=request.getParameter("seq");
      String tseq=request.getParameter("tseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("bossdeletemember");
       modelAndView.addObject("name",name);
       modelAndView.addObject("seq",seq);
       modelAndView.addObject("tseq",tseq);
   
       return modelAndView;
    }
    
   //소모임으로부터 추방
    @RequestMapping(value = "/adgroups/members/delmember/success")
       public ModelAndView bossdeletememberok(HttpServletRequest request, Model model) {
   
      String seq=request.getParameter("seq");
      String tseq=request.getParameter("tseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("bossdeletememberok");
       int flag=tdao.BossDeleteMember(seq, tseq);
       
       modelAndView.addObject("flag",flag);
       modelAndView.addObject("tseq",tseq);
   
       return modelAndView;
    }
    
    //소모임 가입신청 리스트
    @RequestMapping( "/adgroups/request")   
    public ModelAndView bossaccept(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {
        String seq=(String)session.getAttribute("loginedMemberSeq");

       int cpage = 1;
      if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
         cpage = Integer.parseInt(request.getParameter("cpage"));
      }
      String tseq=request.getParameter("tseq");
      
      PageMemberTO pageMemberTO=new PageMemberTO();
      pageMemberTO.setCpage(cpage);
      
      pageMemberTO = tdao.bossAccept(pageMemberTO, tseq);
      String tname = tdao.tnameFromTseq(tseq);
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);
      int noticeCount=ndao.noticeCount(seq);
      
      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("bossaccept");
      modelAndView.addObject("pageMemberTO", pageMemberTO);
      modelAndView.addObject("tseq", tseq);
      modelAndView.addObject("tname", tname);
      modelAndView.addObject("noticeCount", noticeCount);
      modelAndView.addObject("noticeList", noticeList);

      return modelAndView;
    }
    
    //소모임 가입신청 승인 확인
    @RequestMapping(value = "/adgroups/request/yes")
       public ModelAndView bossacceptyes(HttpSession session, HttpServletRequest request, Model model) {

      String name=request.getParameter("name");
      String seq=request.getParameter("seq");
      String tseq=request.getParameter("tseq");
      ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("bossacceptyes");
       modelAndView.addObject("name",name);
       modelAndView.addObject("seq",seq);
       modelAndView.addObject("tseq",tseq);
       modelAndView.addObject("noticeList", noticeList);

       return modelAndView;
    }
    
   //소모임 가입 승인
    @RequestMapping(value = "/adgroups/request/yes/success")
    public ModelAndView bossacceptyesok(HttpServletRequest request, Model model) {
   
      String seq=request.getParameter("seq");
      String tseq=request.getParameter("tseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("bossacceptyesok");
       int flag=tdao.BossAcceptYes(seq, tseq);
       
       modelAndView.addObject("flag",flag);
       modelAndView.addObject("tseq",tseq);
   
       return modelAndView;
    }
    
   //소모임 가입 승인
    @RequestMapping(value = "/adgroups/request/no/success")
    public ModelAndView bossacceptnook(HttpServletRequest request, Model model) {
   
      String seq=request.getParameter("seq");
      String tseq=request.getParameter("tseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("bossacceptnook");
       int flag=tdao.BossAcceptNo(seq, tseq);
       
       modelAndView.addObject("flag",flag);
       modelAndView.addObject("tseq",tseq);
   
       return modelAndView;
    }
    
   //소모임 가입신청 거절 확인
    @RequestMapping(value = "/adgroups/request/no")
    public ModelAndView bossacceptno(HttpServletRequest request, Model model) {
   
      String name=request.getParameter("name");
      String seq=request.getParameter("seq");
      String tseq=request.getParameter("tseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("bossacceptno");
       modelAndView.addObject("name",name);
       modelAndView.addObject("seq",seq);
       modelAndView.addObject("tseq",tseq);
   
       return modelAndView;
    }
    
    @RequestMapping( "/adgroups/admin")   
    public ModelAndView bossadmin(HttpSession session, HttpServletRequest request,HttpServletResponse response,Model model) {
       String seq=(String) session.getAttribute("loginedMemberSeq");

       String tseq=request.getParameter("tseq");
       ArrayList<NoticeTO> noticeList=ndao.noticeList(seq);

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("bossadmin");
       String tname=tdao.tnameFromTseq(tseq);
       int noticeCount=ndao.noticeCount(seq);
       
       modelAndView.addObject("tseq", tseq);
       modelAndView.addObject("tname", tname);
       modelAndView.addObject("noticeCount", noticeCount);
       modelAndView.addObject("noticeList", noticeList);

       return modelAndView; 
    }
    
    //중복 이름 확인
   @RequestMapping(value = "/adgroups/admin/chkgname")
   public ModelAndView bosschecktname(HttpServletRequest request, Model model) {
      String tname = request.getParameter("tname");
      boolean result = tdao.CheckTname(tname);

      ModelAndView modelAndView = new ModelAndView();
      modelAndView.setViewName("bosschecktname");
      modelAndView.addObject("result", result);
      return modelAndView;
   }
   
    @RequestMapping( "/adgroups/admin/chggname")   
    public ModelAndView bossadminchange(HttpServletRequest request,HttpServletResponse response,Model model) {

       String newname=request.getParameter("newname");
      String tseq=request.getParameter("tseq");

      ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("bossadminchange");
       int flag=tdao.BossChangeTname(tseq, newname);
       
       modelAndView.addObject("flag", flag);
       modelAndView.addObject("newname", newname);
       modelAndView.addObject("tseq", tseq);
   
       return modelAndView; 
    }
    
    //소모임 삭제 확인
   @RequestMapping(value = "/adgroups/admin/del")
   public ModelAndView bossdeleteteam(HttpServletRequest request, Model model) {
   
      String tseq=request.getParameter("tseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("bossdeleteteam");
       modelAndView.addObject("tseq",tseq);
   
       return modelAndView;
    }
    
   //소모임 삭제
   @RequestMapping(value = "/adgroups/admin/chggname/success")
   public ModelAndView bossdeleteteamok(HttpServletRequest request, Model model) {
   
      String tseq=request.getParameter("tseq");

       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("bossdeleteteamok");
       int flag=tdao.DeleteTeam(tseq);
       
       modelAndView.addObject("flag",flag);
       modelAndView.addObject("tseq",tseq);
   
       return modelAndView;
    }
   
   //회원 탈퇴
   @RequestMapping(value = "/mypage/change/quit")
   public ModelAndView myPage_info_delete(HttpServletRequest request, Model model) {
       
       String seq=request.getParameter("seq");

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("myPage_info_delete");
        modelAndView.addObject("seq",seq);
    
        return modelAndView;
    }
   //알림 읽음
   @RequestMapping(value = "/notice/read")
   public ModelAndView readNotice(HttpSession session, HttpServletRequest request, Model model) {
       
       String seq=(String) session.getAttribute("loginedMemberSeq");
       ndao.noticeDeleteOk(seq);
       
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("noticedeleteok");
        modelAndView.addObject("seq",seq);
    
        return modelAndView;
    }
}
