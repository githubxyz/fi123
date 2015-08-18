<g:set var="gv1"/>
<%@page import="com.ims.utility.ISessionAttribute" %>
<%@page import="com.ims.dto.StockDetailDTO" %>
<%@page import="com.ims.utility.Messages" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<g:set var="gv1"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>


    <script type="text/javascript" src="js/jquery/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/jquery/jquery-ui-1.8.17.custom.min.js"></script>
    <script type="text/javascript" src="js/jquery/jquery.dataTables.js"></script>
    <script type="text/javascript" src="js/jquery/ColReorder.js"></script>
    <script type="text/javascript" src="js/jquery/ColReorderWithResize.js"></script>
    <script type="text/javascript" src="js/jquery/TableTools.js"></script>
    <link href="css/main.css" rel="stylesheet" type="text/css"/>
    <link media="all" rel="stylesheet" href="css/jquery-ui-1.8.9.custom/jquery-ui-1.8.9.custom.css"
          type="text/css"/>
    <link media="all" rel="stylesheet" href="css/ColReorder.css" type="text/css"/>

    <link media="all" rel="stylesheet" href="css/demo_table_jui.css" type="text/css"/>
    <link media="all" rel="stylesheet" href="../css/TableTools.css" type="text/css"/>
    <script type="text/javascript">

            $(document).ready(function () {
               /* alert("jj");*/
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

    <title>IMS</title>

</head>
<body>
<%--<div id="header">
    <h1>
        <a href="#"><%=Messages.getString("company_name")%>
        </a>
    </h1>
    <ul id="menu">
        <li class="active"><a href="#">about application</a></li>
        <li><a href="#">register</a></li>
        <li><a href="#">demo</a></li>
        <li><a href="#">help</a></li>
        <li><a href="#">contact</a></li>
    </ul>
</div>--%>

<div id="bar">
    <div class="wrap">
        <span class="step"><a>1</a> sharing</span> <span class="step"><a>2</a>
				data management</span> <span class="step"><a>3</a> collaboration</span>
    </div>
</div>
<div class="wrap">
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
                Unit Of Mesure
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
                Branch Id
            </th>
            <th align="center"
                style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;">
                K & P
            </th>
        </tr>
        </thead>

        <tbody>

        <% List<StockDetailDTO> stockList = (List<StockDetailDTO>) request.getAttribute(ISessionAttribute.STOCK_LIST);
            if (stockList != null) {
                for (Iterator it = stockList.iterator(); it.hasNext(); ) {
                    StockDetailDTO sd = (StockDetailDTO) it.next();%>
        <tr style="border:1px solid #ccc!important;">
            <td align="center"><%=sd.getId() %>
            </td>
            <td align="center"><%=sd.getProductName() %>
            </td>
            <td align="center"><%=sd.getProductCode() %>
            </td>
            <td align="center"><%=sd.getUnitOfMesure() %>
            </td>
            <td align="center"><%=sd.getWeight() %>
            </td>
            <td align="center"><%=sd.getQuantity() %>
            </td>
            <td align="center"><%=sd.getBranchId() %>
            </td>
            <%--<td><%=sd.getProductMaster().getId() %></td>--%>
            <td align="center"><%=sd.getKndP() %>
            </td>
        </tr>
        <%
                }
            }
        %>


        </tbody>

        <tfoot>

        <tr>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col1" name="col1" value="Search ID" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col2" name="col2" value="Search Product Name" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col3" name="col3" value="Search Product Code" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col4" name="col4" value="Search Unit Of Measure" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col5" name="col5" value="Search Weight" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col6" name="col6" value="Search Quantity" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col7" name="col7" value="Search Branch ID" class="search_init"/></th>
            <th style=" background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x;color: #555555;font-size:11px!important;">
                <input type="text" id="col9" name="col9" value="Search K and P" class="search_init"/></th>

        </tr>
        </tfoot>
        <%--</table>--%>
        <%--</ul>--%>
    </table>

</div>
<%--
		<div class="col2 ">
			<h3>
				About <span class="red">Web Application</span>
			</h3>
			<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
				Integer porta, ipsum sit amet ultricies congue, ante pede congue
				pede, id venenatis ante elit et nulla. Ut lectus nisi, convallis in,
				eleifend vitae, blandit non, orci.</p>
			<p class="info">If you liked this template, you might like some
				other Free or Commercial CSS templates from Solucija.</p>
				
				
			<form action="getAllStockDetail" method="post">
				&lt;%&ndash;Product Name :<input type="text" name="productName" value="" ><br>
				Product Code :<input type="text"  name="productCode"  value="">
				Unit of Mesure :<select name="unitOfMesure">
					<option value="1">Weight</option>
					<option value="2">Quantity</option>
				</select> &ndash;%&gt;
				<input type="submit" name="submit" value="submit">                            
			</form>

		</div>--%>
</div>
<div id="footer">
    <div align=center>
        <p>Copyright&copy; insonera.com &middot; All Rights Reserved</p>
    </div>
    <p>
        Copyright&copy; insonera.com <a href="http://www.insonera.com">Web Application</a> &middot; All Rights Reserved
    </p>
</div>

</body>
</html>
