<%@ page import="java.util.ArrayList"%><%@ page import="book.bookBean.BookProcessBean"%><%@ page import="common.Cnst"%><%@ page import="commonJson.JsonUtil"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><jsp:useBean id="mng_user_info" scope="session" class="manage.manageBean.ManageProcessBean" /><!DOCTYPE html><html><head><title>ブックリスト</title><meta name="viewport" content="width=device-width, initial-scale=1"><link rel="stylesheet" href="//cdn.datatables.net/plug-ins/1.10.16/integration/font-awesome/dataTables.fontAwesome.css"><link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css"><link rel="stylesheet" href="/libraryWeb/css/bootstrap.min.css"><link rel="stylesheet" href="/libraryWeb/css/dataTables.bootstrap.min.css"><link rel="stylesheet" href="/libraryWeb/css/library.css"><link rel="stylesheet" href="/libraryWeb/css/drawer.min.css"><script src="/libraryWeb/js/jquery-3.1.0.min.js"></script><script src="/libraryWeb/js/drawer.min.js"></script><script src="/libraryWeb/js/iscroll.js"></script><script type="text/javascript" src="/libraryWeb/js/jquery.dataTables.min.js"></script><script type="text/javascript" src="/libraryWeb/js/dataTables.bootstrap.min.js"></script><script type="text/javascript" src="/libraryWeb/js/bootstrap.min.js"></script><script type="text/javascript" src="/libraryWeb/js/library.js"></script></head><body class="drawer drawer--left"> <div class="container-fluid">  <jsp:include page="/common/responseBookMenu.jsp" />  <jsp:include page="/common/header.jsp" />  <div class="management-toggle">   <a href="ManagementMenu?submit=ユーザ一覧">    <button class="btn btn-primary" style="float: none">← ユーザ管理へ</button>   </a>  </div>  <% @SuppressWarnings("unchecked")  ArrayList<BookProcessBean> userList = (ArrayList<BookProcessBean>) request.getAttribute(Cnst.ATTR_BOOK_BEAN.strType());  JsonUtil j = new JsonUtil();  String displayInfo = (String) request.getAttribute(Cnst.ATTR_DISPLAY_INFO.strType());  %>  <h4 class="head-margin"></h4>  <jsp:include page="/common/bookMenu.jsp" />  <%    if ("lend".equals(request.getAttribute("book"))) {  %>  <h4 class="head-margin">貸し出しリスト</h4>  <%    }  %>  <%    if ("delete".equals(request.getAttribute("book"))) {  %>  <h4 class="head-margin">削除リスト</h4>  <%    }  %>  <%    if ("list_only".equals(request.getAttribute("book"))) {  %>  <h4 class="head-margin">図書リスト</h4>  <%    }  %>  <%    @SuppressWarnings("unchecked")ArrayList<BookProcessBean> bookList = (ArrayList<BookProcessBean>) request.getAttribute(Cnst.ATTR_BOOK_BEAN.strType());  %>  <div class="table-responsive">   <table class="table table-condensed display" id="table-sort">    <thead>     <tr>      <th>ID</th>      <th>タイトル</th>      <th>登録日</th>      <%        if (!"list_only".equals(request.getAttribute("book"))) {      %>      <th></th>      <%        }      %>     </tr>    </thead>    <tbody>     <%       for (BookProcessBean bean : bookList) {     %>     <%--貸し出し状態が１なら貸し出すボタンを表示する --%>     <%       if (bean.getBookLendStatus().equals("1")) {     %>     <tr>      <td><%=bean.getBookId()%></td>      <td><%=bean.getTitle()%></td>      <td><%=bean.getBookRegisteDate()%></td>      <%        } else {      %>     <tr class="disabled_tr">      <td><%=bean.getBookId()%></td>      <td><%=bean.getTitle()%></td>      <td><%=bean.getBookRegisteDate()%></td>      <%        }      %>      <%--list_onlyと一致したら、FALSEで図書リストのみ表示 --%>      <%        if (!"list_only".equals(request.getAttribute("book"))) {      %>      <%--lendと一致したら、TRUEで図書リスト貸し出しボタン表示 --%>      <%        if ("lend".equals(request.getAttribute("book"))) {      %>      <%--さらに条件で貸し出し状態が１なら貸し出すボタンを表示する --%>      <%        if (bean.getBookLendStatus().equals("1")) {      %>      <td>       <%-- アンカータグからIDの値を送る--%> <a href="./LendProcess?submit=貸し出す&bookId=<%=bean.getBookId()%>">        <button class="btn btn-primary">貸し出す</button>      </a>      </td>      <%        } else {      %>      <td>       <%-- 貸し出し中の無効のボタンの表示--%> <input class="btn btn-primary" type="submit" name="submit" value="貸出中" disabled />      </td>      <%        }      %>      <%--deleteと一致したら、TRUEで図書リストと削除ボタン表示 --%>      <%        } else if ("delete".equals(request.getAttribute("book"))) {      %>      <%        if (bean.getBookLendStatus().equals("1")) {      %>      <td>       <%-- フォームからIDの値を送る--%>       <form action="./BookProcess" method="get">        <input class="btn btn-primary" type="submit" name="submit" value="削除" /> <input type="hidden" name="submit"         value="<%=bean.getBookId()%>" />       </form>      </td>      <%        } else {      %>      <td>       <%-- 貸し出し中の無効のボタンの表示--%> <input class="btn btn-primary" type="submit" name="submit" value="貸出中" disabled />      </td>      <%        }      %>     </tr>     <%       }     %>     <%       }     %>     <%       }     %>    </tbody>   </table>  </div> </div> <script> $(document)  .ready(   function() {    $(".drawer").drawer();    $.extend($.fn.dataTable.defaults, {     language : {      url : "http://cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Japanese.json"     }    });    $("#table-sort").dataTable();   }); $(window).on('load resize', function() {  var w = $(window).width();  var x = 768;  if (w < x) {   //画面サイズが768px未満のときの処理   $(".management-toggle").css("float", "right");   $("#loginNow").hide();   $(".menu").hide();   $("button.drawer-toggle.drawer-hamburger").show();  } else {   //それ以外のときの処理   $("#loginNow").show();   $(".menu").show();   $("button.drawer-toggle.drawer-hamburger").hide();  } });</script></body></html>