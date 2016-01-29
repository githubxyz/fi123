<%@page import="com.ims.utility.ISessionAttribute"%>
<%@page import="com.ims.utility.Messages"%>
<%@page import="com.ims.dto.UserDTO"%>
<%
	UserDTO dto1 = null;
	dto1 = (UserDTO) (session.getAttribute(ISessionAttribute.LOGGEDINUSER));
%>
<div id="cssmenu">

	<!-- <h3>Menu</h3> -->

	<ul>
		<li id="selectpage"><a href="login" id="dashboard"><b><%=Messages.getString("company_dashboard")%></b></a></li>
		<!-- <li><a href="#"><b><%=Messages.getString("company_user_Profile")%></b></a></li> -->
		<%
			if (dto1.getUsertype() != 3 && dto1.getUsertype() != 4) {
		%>
		<li class='active has-sub'><a href='#' id="companyproduct"><%=Messages.getString("company_product")%></a>
			<ul>
				<li><a href="SaveStockAlart" id="itemconfig"><%=Messages.getString("company_item_configuration")%></a></li>
				<li><a href="saveProduct" id="masterproduct"><%=Messages.getString("company_master_entry")%></a></li>
				<li id="selectpage"><a href="saveStock" id="purchaseentry"><%=Messages.getString("company_purchase_entry")%></a></li>
				<li><a href="vendorInfo"><%=Messages.getString("vendor_payment_menu")%></a>
				</li>
			</ul></li>
		<%
			}
		%>
		<%
			if (dto1.getUsertype() != 2 && dto1.getUsertype() != 4) {
		%>
		<li class='active has-sub'><a href="#" id="companysales"><%=Messages.getString("company_sales")%></a>
			<ul>
				<li><a href="#" id="customerentry"><%=Messages.getString("company_customer_entry")%></a>
				</li>
				<li><a href="SalesProduct" id="productsales"><%=Messages.getString("company_product_sales")%></a>
				</li>
				<li><a href="#" id="editsales"><%=Messages.getString("company_edit_sales")%></a>
				</li>
				<li><a href="#" id="pendingpayment"><%=Messages.getString("company_pending_payment")%></a>
				</li>

			</ul></li>
		<%
			}
		%>

		<li class='active has-sub'><a href="#" id="companyreport"><%=Messages.getString("company_report")%></a>
			<ul>
				<li><a href="ViewStock" id="stockview"><%=Messages.getString("company_stock_view")%></a>
				</li>
				<li><a href="ViewPurchase" id="purchaseview"><%=Messages.getString("company_purchase_view")%></a></li>
				<li><a href="#" id="salesview"><%=Messages.getString("company_sales_view")%></a>
				</li>
				<li><a href="#" id="profitnloss"><%=Messages.getString("company_profitnloss")%></a>
				</li>
				<li><a href="#" id="salesuser"><%=Messages.getString("company_sales_user")%></a>
				</li>
				<!--<li><a href="billing" id="billing"><%=Messages.getString("company_billing")%></a>
				</li>-->

			</ul></li>
	</ul>
</div>