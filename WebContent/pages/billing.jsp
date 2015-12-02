<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ims.dto.SaleItemDTO"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ims.dto.SaleMasterDTO"%>
<%@page import="com.ims.utility.IRequestAttribute"%>
<%@page import="com.ims.utility.Messages"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
	
	<title>Friends Interior</title>
	
	<link rel='stylesheet' type='text/css' href='css/billingstyle.css' />
	<link rel='stylesheet' type='text/css' href='css/print.css' media="print" />
	<script type='text/javascript' src='js/jquery-1.3.2.min.js'></script>
	<script type='text/javascript' src='js/example.js'></script>

</head>

<body>
<%
SaleMasterDTO saleMasterDTO=(SaleMasterDTO)request.getAttribute(IRequestAttribute.SALE_ITEM_DETAIL);
%>
	<div id="page-wrap">

		<div id="header"><%=Messages.getString("billing_header")%></div>
		
		<div id="identity">
		
            <div id="address">
            <%=Messages.getString("company_address1")%><br>
<%=Messages.getString("company_address2")%><br>
<%=Messages.getString("company_district")%><br>
<%=Messages.getString("company_pin")%><br>
<%=Messages.getString("company_mobile")%>: <%=Messages.getString("company_mobile_no")%>  <br>
<%=Messages.getString("company_email")%>: <%=Messages.getString("company_email_id")%>  <br>
<b><%=Messages.getString("company_buyer")%></b><br>
<%=Messages.getString("company_buyer_name")%><br>
<%=Messages.getString("company_buyer_address")%><br>
            
            </div>

            <div id="logo">

              <div id="logoctr">
                <a href="javascript:;" id="change-logo" title="Change logo">Change Logo</a>
                <a href="javascript:;" id="save-logo" title="Save changes">Save</a>
                |
                <a href="javascript:;" id="delete-logo" title="Delete logo">Delete Logo</a>
                <a href="javascript:;" id="cancel-logo" title="Cancel changes">Cancel</a>
              </div>

              <div id="logohelp">
                <input id="imageloc" type="text" size="50" value="" /><br />
                (max width: 540px, max height: 100px)
              </div>
              <img id="image" src="images/logo.png" alt="logo" />
            </div>
		
		</div>
		
		<div style="clear:both"></div>
		
		<div id="customer">

            <!-- <div id="customer-title">Widget Corp.
c/o Steve Widget</div> -->

            <table id="meta">
                <tr>
                    <td class="meta-head"><%=Messages.getString("invoice_no")%></td>
                    <td><div>000123</div></td>
                </tr>
                <tr>
                    <td class="meta-head"><%=Messages.getString("invoice_date")%></td>
                    <td><div id="date">
                    <%String newstring = new SimpleDateFormat("dd/MM/yyyy").format(saleMasterDTO.getBillDate()); %>
                    <%=newstring %></div></td>
                </tr>
                <tr>
                    <td class="meta-head"><%=Messages.getString("invoice_delivery_note")%></td>
                    <td><div id="date">Mode/Terms of Payment</div></td>
                </tr>
                <tr>
                    <td class="meta-head"><%=Messages.getString("invoice_supplier_ref")%></td>
                    <td><div class="due">Other Reference(s)</div></td>
                </tr>
                <tr>
                    <td class="meta-head"><%=Messages.getString("invoice_buyer_orderno")%></td>
                    <td><div>Dated</div></td>
                </tr>
                <tr>
                    <td class="meta-head"><%=Messages.getString("invoice_despatch_no")%></td>
                    <td><div id="date">Dated</div></td>
                </tr>
                <tr>
                    <td class="meta-head"><%=Messages.getString("invoice_despatch")%></td>
                    <td><div class="due">Destination</div></td>
                </tr>
                <tr>

                    <td class="meta-head"><%=Messages.getString("invoice_termas")%></td>
                    <td><div id="date"></div></td>
                </tr>
                

            </table>
		
		</div>
		
		<table id="items">
		
		  <tr>
		      <th><%=Messages.getString("invoice_des_goods")%></th>
		      <th><%=Messages.getString("invoice_quantity")%></th>
		      <th><%=Messages.getString("invoice_rate")%></th>
		      <th><%=Messages.getString("invoice_unit")%></th>
		      <th>Vat %</th>
		      <th><%=Messages.getString("invoice_amount")%></th>
		  </tr>
		  <%if(saleMasterDTO!=null){ 
			  for (Iterator it = saleMasterDTO.getItems().iterator(); it.hasNext();) {
				  SaleItemDTO saleItemDTO=(SaleItemDTO)it.next();
		  %>
		  
		  <tr class="item-row">
		      <td class="item-name"><div class="delete-wpr"><div><%=saleItemDTO.getProductMaster().getProductName() %></div><!-- <a class="delete" href="javascript:;" title="Remove row">X</a> --></div></td>
		      <% 
		      double mesure=0.0;
		      boolean quantityUnit=true;
		      if(saleItemDTO.getMesure()==null||saleItemDTO.getMesure()==0.0){
		    	  mesure= saleItemDTO.getQuantity();
		      }else{
		    	  mesure=saleItemDTO.getMesure();
		    	  quantityUnit=false;
		      }
		      %>
		      <td class="qty"><div><%=saleItemDTO.getMesure()==null||saleItemDTO.getMesure()==0.0?saleItemDTO.getQuantity():saleItemDTO.getMesure() %></div></td>
		      <td><div class="cost">&#x20B9;<%=saleItemDTO.getUnitPrice() %></div></td>
		      <td><div class="description"><%=quantityUnit?saleItemDTO.getProductMaster().getQty_unit():saleItemDTO.getProductMaster().getWeight_unit() %></div></td>
		      <td><%=saleItemDTO.getVatPercentage() %></td>
		      <td><span class="price">&#x20B9;<%=(mesure*saleItemDTO.getUnitPrice())+saleItemDTO.getVatAmount() %></span></td>
		  </tr>
		  <%}} %>
		  <!-- <tr class="item-row">
		      <td class="item-name"><div class="delete-wpr"><div>Web Updates</div><a class="delete" href="javascript:;" title="Remove row">X</a></div></td>
		      <td class="qty"><div>100</div></td>
		      <td><div class="cost">&#x20B9;650.00</div></td>
		      <td><div class="description">Pcs.</div></td>
		      <td><span class="price">&#x20B9;650.00</span></td>
		  </tr>
		  <tr class="item-row">
		      <td class="item-name"><div class="delete-wpr"><div>Item2</div><a class="delete" href="javascript:;" title="Remove row">X</a></div></td>
		      <td class="qty"><div>10</div></td>
		      <td><div class="cost">&#x20B9;14.50</div></td>
		      <td><div class="description">KG</div></td>
		      <td><span class="price">&#x20B9;120</span></td>
		  </tr> -->
		  
		   <!-- <tr class="item-row">
		      <td class="item-name"><div class="delete-wpr"><div>SSL Renewals</div><a class="delete" href="javascript:;" title="Remove row">X</a></div></td>

		      <td class="description"><div>Yearly renewals of SSL certificates on main domain and several subdomains</div></td>
		      <td><div class="cost">$75.00</div></td>
		      <td><div class="qty">3</div></td>
		      <td><span class="price">$225.00</span></td>
		  </tr>
		  
		  <tr id="hiderow">
		    <td colspan="5"><a id="addrow" href="javascript:;" title="Add a row">Add a row</a></td>
		  </tr> --> 
		  <tr id="hiderow">
		    <td colspan="5"><%=Messages.getString("invoice_subtotal")%></td>
		    <td colspan="1">Sum of item amount</td>
		  </tr>
		  <tr class="item-row">
		      <td class="item-name"><div class="delete-wpr"><div>Output Vat @14.5% Round Off</div><!-- <a class="delete" href="javascript:;" title="Remove row">X</a> --></div></td>
		      <td class="qty"><div></div></td>
		      <td><div class="cost">14.50</div></td>
		      <td></td>
		      <td><div class="">%</div></td>
		      <td><span class="price">&#x20B9;(650.00+120)*14.50/100</span></td>
		  </tr>
		   <tr id="hiderow">
		    <td colspan="5"><%=Messages.getString("invoice_total")%></td>
		    <td colspan="1">&#x20B9;15,218</td>
		  </tr>
		  <tr id="hiderow">
		    <td colspan="6"><%=Messages.getString("invoice_amount_txt")%><br>&#x20B9; Fifteen thousand two hundred eighteen only </td>
		    
		  </tr>
		  
		  <tr>
		      <td colspan="3" class="blank"> </td>
		      <td colspan="2" class="total-line"><%=Messages.getString("invoice_amount_paid")%></td>

		      <td class="total-value"><div id="paid">&#x20B9;0.00</div></td>
		  </tr>
		  <tr>
		      <td colspan="3" class="blank"> </td>
		      <td colspan="2" class="total-line balance"><%=Messages.getString("invoice_balance_due")%></td>
		      <td class="total-value balance"><div class="due">&#x20B9;875.00</div></td>
		  </tr>
		
		</table>
		
		<div id="terms1">
		  
		  	Company's VAT TIN : 19808181045<br>
			Company's CST No. : 19808181045<br>
			Buyer's VAT TIN/Sales Tax No. : 19781977077
		  <table border="0">
		  <tr>
		  <td>
		  Declaration
		  </td>
		  <td>
		  <b>for FRIENDS INTERIOR</b>
		  </td>
		  </tr>
		  <tr>
		  <td>
		  We declare that this invoice shows the actual price of the goods described and that all particulars are true and correct.
		  </td>
		  <td>
		  </td>
		  </tr>
		  <tr>
		  <td>
		  </td>
		  <td>
		  Authorised Signatory
		  </td>
		  </tr>
		  </table>
		  </div>
		  <div id="terms" align="left">
		  
		  <div>This is a Computer Geenerated Invoice</div>
		  <input type="button" name="submit" value="Print" onclick="">
		  &nbsp;&nbsp;&nbsp;&nbsp;
		 <a href="./login"> Back to Dashboard </a>
		</div>
	<br></br>
	</div>
	
</body>

</html>