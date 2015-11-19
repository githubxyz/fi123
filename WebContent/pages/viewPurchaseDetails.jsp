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

<title>FriendsInterior</title>
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
			<%@ include file="./include/sidemenu.htm"%>
				
        </div>
   
         
		<div id="content">
                
       
        <div id="content_main">
        <div class="heading">
					<font size="4px" color="#67a0f5"><b><%=Messages.getString("company_purchase_view") %></b></font>
					<br>
					</div><br>
    <table id="example" cellpadding="0" cellspacing="0" border="1" class="display dataTable">
        <thead>
        <tr>
            <th align="center"
                style="background: #e6e6e6 url("images/ui-bg_glass_75_e6e6e6_1x400.png") 50% 50% repeat-x;color: #555555;">
                Sl No
            </th>
            <th align="center"
                style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;">
                Product Name
            </th>
            <th align="center"
                style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;">
                Product Code
            </th>
            <th align="center"
                style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;">
                Unit Of Measure
            </th>
            <th align="center"
                style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;">
                Weight
            </th>
            <th align="center"
                style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;">
                Quantity
            </th>
            <th align="center"
                style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;">
                Type
            </th>
            <th align="center"
                style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;">
                Purchase Date
            </th>
            <th align="center"
                style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;">
                Vat Amount
            </th>
            <th align="center"
                style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;">
                Branch Id
            </th>
            <th align="center"
                style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;">
                User Name
            </th>
           <!--  <th align="center"
                style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;">
                Sales Quantity
            </th> -->
            <th align="center"
                style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;">
                K & P
            </th>
        </tr>
        </thead>

        <tbody>

    <% List<ProductDetailDTO> purchoseList = (List<ProductDetailDTO>) request.getAttribute(ISessionAttribute.PURCHASE_LIST);
            if (purchoseList != null) {
                for (Iterator it = purchoseList.iterator(); it.hasNext(); ) {
                    ProductDetailDTO sd = (ProductDetailDTO) it.next();%>
        <tr style="border:1px solid #ccc!important;">
            <td align="center"><%=sd.getId() %>
            </td>
            <td align="center"><%=sd.getProductMaster().getProductName() %>
            </td>
            <td align="center"><%=sd.getProductMaster().getProductCode() %></td>
            
            <td align="center"></td>
            <td align="center"><%=sd.getWeight() %></td>
            <td align="center"><%=sd.getQuantity()%></td>
            <td align="center"><%=sd.getType()==0? "":(sd.getType()==1?"Light":(sd.getType()==2?"Medium":"Heavy")) %></td>
            
           <%DateFormat shortDF = DateFormat.getDateInstance();%>
            <td align="center"><%= shortDF.format(sd.getPurchaseDate()) %></td>
            <td align="center"><%=sd.getVat()%></td>
            <td align="center"><%=sd.getBranch()%></td>
           <td align="center"><%=sd.getUser().getFirstName().concat(" ").concat(sd.getUser().getLastName()) %></td>
            <%-- <td align="center"><%=sd.getSaleQuantity()%></td> --%>
            <td align="center"><%=sd.getkAndP()==null?"":sd.getkAndP()%></td>
        </tr>
        <%
                }
            }
        %>


        </tbody>

        <tfoot>

        <tr>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col1" name="col1" value="Type to search" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col2" name="col2" value="Type to search" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col3" name="col3" value="Type to search" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col4" name="col4" value="Type to search" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col5" name="col5" value="Type to search" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col6" name="col6" value="Type to search" class="search_init"/></th>
      <!--       <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col7" name="col7" value="Type to search" class="search_init"/></th>
       -->      <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col9" name="col9" value="Type to search" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col4" name="col4" value="Type to search" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col5" name="col5" value="Type to search" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col6" name="col6" value="Type to search" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col7" name="col7" value="Type to search" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col9" name="col9" value="Type to search" class="search_init"/></th>
        </tr>
        </tfoot>
        <%--</table>--%>
        <%--</ul>--%>
    </table>

        </div>
<div id="content_bottom"></div>
            
            <div id="footer">
			<%@ include file="include/footer.jsp"%>
			</div>
      </div>
	  
   </div> 
   	  <script type="text/javascript">

           
                //alert("jj");
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
                        "aiOrder": [0, 1, 2, 3,4,5,6,7,8,9,10,11,12]
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
            
    </script>
   
</body>
</html>
