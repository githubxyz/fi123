<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
                    <td><div id="date">December 15, 2009</div></td>
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
		      <th>Item</th>
		      <th>Description</th>
		      <th>Unit Cost</th>
		      <th>Quantity</th>
		      <th>Price</th>
		  </tr>
		  
		  <tr class="item-row">
		      <td class="item-name"><div class="delete-wpr"><div>Web Updates</div><a class="delete" href="javascript:;" title="Remove row">X</a></div></td>
		      <td class="description"><div>Monthly web updates for http://widgetcorp.com (Nov. 1 - Nov. 30, 2009)</div></td>
		      <td><div class="cost">$650.00</div></td>
		      <td><div class="qty">1</div></td>
		      <td><span class="price">$650.00</span></td>
		  </tr>
		  
		  <tr class="item-row">
		      <td class="item-name"><div class="delete-wpr"><div>SSL Renewals</div><a class="delete" href="javascript:;" title="Remove row">X</a></div></td>

		      <td class="description"><div>Yearly renewals of SSL certificates on main domain and several subdomains</div></td>
		      <td><div class="cost">$75.00</div></td>
		      <td><div class="qty">3</div></td>
		      <td><span class="price">$225.00</span></td>
		  </tr>
		  
		  <tr id="hiderow">
		    <td colspan="5"><a id="addrow" href="javascript:;" title="Add a row">Add a row</a></td>
		  </tr>
		  
		  <tr>
		      <td colspan="2" class="blank"> </td>
		      <td colspan="2" class="total-line">Subtotal</td>
		      <td class="total-value"><div id="subtotal">$875.00</div></td>
		  </tr>
		  <tr>

		      <td colspan="2" class="blank"> </td>
		      <td colspan="2" class="total-line">Total</td>
		      <td class="total-value"><div id="total">$875.00</div></td>
		  </tr>
		  <tr>
		      <td colspan="2" class="blank"> </td>
		      <td colspan="2" class="total-line">Amount Paid</td>

		      <td class="total-value"><div id="paid">$0.00</div></td>
		  </tr>
		  <tr>
		      <td colspan="2" class="blank"> </td>
		      <td colspan="2" class="total-line balance">Balance Due</td>
		      <td class="total-value balance"><div class="due">$875.00</div></td>
		  </tr>
		
		</table>
		
		<div id="terms">
		  <h5>Terms</h5>
		  <div>NET 30 Days. Finance Charge of 1.5% will be made on unpaid balances after 30 days.</div>
		</div>
	
	</div>
	
</body>

</html>