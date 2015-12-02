<%@page import="java.text.DateFormat"%>
<%@page import="javax.xml.crypto.KeySelector.Purpose"%>
<%@page import="com.ims.dto.ProductDetailDTO"%>
<g:set var="gv1"/>
<%@page import="com.ims.utility.ISessionAttribute" %>
<%@page import="com.ims.dto.StockDetailDTO" %>
<%@page import="com.ims.utility.Messages" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.List" %>
<%@page import="java.text.DateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<g:set var="gv1"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="js/jquery/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/jquery/jquery-ui-1.8.17.custom.min.js"></script>
    <script type="text/javascript" src="js/jquery/jquery.dataTables.js"></script>
    <script type="text/javascript" src="js/jquery/ColReorder.js"></script>
    <script type="text/javascript" src="js/jquery/ColReorderWithResize.js"></script>
    <script type="text/javascript" src="js/jquery/TableTools.js"></script>
    <link media="all" rel="stylesheet" href="css/jquery-ui-1.8.9.custom/jquery-ui-1.8.9.custom.css"
          type="text/css"/>
    <link media="all" rel="stylesheet" href="css/ColReorder.css" type="text/css"/>

    <link media="all" rel="stylesheet" href="css/demo_table_jui.css" type="text/css"/>
    <link media="all" rel="stylesheet" href="css/TableTools.css" type="text/css"/>
    <!--  <link rel="stylesheet" href="/resources/demos/style.css"> -->
  <script src="./js/jquery-2.0.3.min.js"></script>
  <link rel="stylesheet" href="./css/styles.css">
   <script src="./js/script.js"></script>
   <script>
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js";
		</script>
    <script type="text/javascript">

            $(document).ready(function () {
               /* alert("jj");*/
               $("#purchaseview").css("background-color", "#f78900");
                var asInitVals = new Array();


                var oTable = $('#example').dataTable({
                    "bJQueryUI": true,
                    bRetrieve: true,
                    "sPaginationType": "full_numbers",
                    "oLanguage": {
                        "sSearch": "Search all columns:"
                    },
                    "sDom": 'R<"H"lfr>t<"F"ip>',
                    // "sDom": '<"H"Tfr>t<"F"ip>',
                    // "sDom": 'Rlfrtip',
                    "bStateSave": true,
                    // "bDestroy":true,

                    "oColReorder": {
                        "aiOrder": [0, 1, 2, 3]
                    },
                    sScrollY: "",
                    "bPaginate": true


                });

                $("#example tfoot input").keyup(function () {

                    oTable.fnFilter(this.value, $("#example tfoot input").index(this));
                });

                $("#example tfoot input").each(function (i) {
                    var id = $(this).attr("id").split("-")[1];
                    asInitVals[id] = this.value;
                });

                $("#example tfoot input").focus(function () {
                    if (this.className == "search_init") {
                        this.className = "";
                        this.value = "";
                    }
                });

                $("#example tfoot input").blur(function (i) {
                    var id = $(this).attr("id").split("-")[1];
                    if (this.value == "") {
                        this.className = "search_init";
                        /*alert("jj");*/
                        // this.value = asInitVals[$("#example tfoot input").index(this)];
                        this.value = asInitVals[id];
                    }
                });
            });
    </script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/include-style.css" type="text/css" media="all">

<title>Friends Interior</title>
</head>

<body>
<div id="container">
		<div id="header">
        	<%@ include file="./include/header.jsp"%>
        </div>   
        
        <div id="menu">
        	<%@ include file="./include/settingBar.jsp"%>
        </div>
        
        <div id="leftmenu">
			<%@ include file="./include/sidemenu.jsp"%>
				
        </div>
   
         
		<div id="content">
                
       
        <div id="content_main">
        <div class="heading">
					<font size="4px" color="#67a0f5"><b><%=Messages.getString("company_purchase_view") %></b></font>
					<br>
					</div><br>
    
    	<div style="margin-bottom: 20px;" id="PurchaseDetailsDiv">
								<jsp:include page="PurchaseDetailsList.jsp" />
							</div>
    
    
    
        </div>
<div id="content_bottom"></div>
            
            <div id="footer">
			<%@ include file="include/footer.jsp"%>
			</div>
      </div>
	  
   </div> 
   	
</body>
</html>
