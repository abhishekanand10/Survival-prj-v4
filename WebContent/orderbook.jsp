<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page
	import="java.sql.Connection, java.sql.Date, java.sql.PreparedStatement,java.sql.ResultSet, java.sql.SQLException, java.util.ArrayList,java.util.List, com.sapient.pm.db.MySQLConnectorFactory, com.sapient.pm.model.Trader,com.sapient.pm.model.Stock  "%>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Portfolio Manager</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" media="screen" href="main.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link href="./style.css" rel="stylesheet">


</head>
<body>


<img src="./logo.jpg" width="15%" height="7.5%"style="float:left">
<br>
<br>
<br>


	<div class="container">
		<h2>Welcome Portfolio Manager | Equity Simulation</h2>
		<button type="button" class="btn btn-danger"
						style="position: absolute; top: 2%; right: 2%; border: 0;">
						<a href="index.html" style="text-decoration: none;">Log Out!</a>
					</button>
		<ul class="nav nav-tabs">
			<li ><a data-toggle="tab" href="#portfolio">Holdings</a>
			</li>
			<li  class="active"><a data-toggle="tab" href="#order-Book">Order Book</a></li>
			<li><a data-toggle="tab" href="#order">Order</a></li>
		</ul>
		<div class="tab-content">
			<div id="portfolio" class="tab-pane fade">

				<div class="container">
					<a href="load-portfolio"><h2>Portfolio</h2></a>
					<button type="button" class="btn btn-danger"
						style="position: absolute; top: 2%; right: 2%; border: 0;">
						<a href="index.html" style="text-decoration: none;">Log Out!</a>
					</button>
					<p>View Your Portfolio:</p>
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>Ticker</th>
								<th>Price ($)</th>
								<th>Quantity</th>




							</tr>
						</thead>
						<tbody>
							<%
								List<Trader> traders = (List<Trader>) request.getAttribute("traders");
							%>
							<%
								if (traders != null) {
									for (Trader trader : traders) {
							%>

							<tr>
								<td><%=trader.getTicker()%></td>
								<td><%=trader.getQuantity()%></td>
								<td><%=trader.getPrice()%></td>



							</tr>
							<%
								}
								}
							%>
						</tbody>
					</table>
				</div>

			</div>

			<div id="order-Book" class="tab-pane fade in active" >
				
				


				<h1>Welcome to Your Orderbook</h1>
	<div class="tab-content">

		<form action="PageControl2">





			<div class="form-inline">
				<div class="form-group">
					<div class="col-3">
						Trader: <select class="form-control" style="width: 200px"
							name="trader" selected="0">
							<option name="trader" value="0">All</option>
							<option name="trader" value="1">Trader 1</option>
							<option name="trader" value="2">Trader 2</option>
							<option name="trader" value="3">Trader 3</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-3">
						Status: <select class="form-control" style="width: 200px"
							name="selected">
							<option name="selected" value="all">All</option>
							<option name="selected" value="filled">Filled</option>
							<option name="selected" value="partial">Partial</option>
							<option name="selected" value="open">Open</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-3">
						Stock: <select class="form-control" style="width: 200px"
							name="stock" selected="0">
							<option name="stock" value="0">All</option>
							<option name="stock" value="SBI">SBIN</option>
							<option name="stock" value="SBB">SBBJ</option>
							<option name="stock" value="BANKINDIA">BANKINDIA</option>
							<option name="stock" value="GLITTEKG">GLITTEKG</option>
							<option name="stock" value="SRIVAJRA">SRIVAJRA</option>
							<option name="stock" value="SOLIDSTON">SOLIDSTON</option>
							<option name="stock" value="NESTLEIND">NESTLEIND</option>
							<option name="stock" value="MODAIRY">MODAIRY</option>
							<option name="stock" value="MLKFOOD">MLKFOOD</option>
							<option name="stock" value="NCCBLUE">NCCBLUE</option>
						</select>
					</div>
				</div>
			</div>
			</br>
			<button class="btn btn-primary">Get Data</button>

		</form>







		<display:table class="table table-striped table-condensed"
			name="results">
			<table class="table table-striped" id="orderbook-table">
				<thead>

					<tr>

						<td>TICKER</td>
						<td>QUANTITY</td>
						<td>STATUS</td>
						<td>TRADERID</td>
						
					</tr>
				</thead>
				<tbody>
					<%
						List<Stock> stockList = (List) request.getAttribute("stockList");
					%>
					<%
						if (stockList != null && !stockList.isEmpty()) {
								System.out.println(stockList);
								for (Stock stock : stockList) {
					%>




					<tr>

						<td><%=stock.getTicker()%></td>
						<td><%=stock.getQuantity()%></td>
						<td><%=stock.getStatus()%></td>
						<td><%=stock.getTraderId()%></td>
					</tr>
					<%
						}
							}
					%>
				</tbody>
			</table>
		</display:table>
		<div class="settle-button">
			<button class="btn-primary">Settle</button>
		</div>
	</div>
	</div>
			<div id="order" class="tab-pane fade" >
				<div class="container">
					<h3>Order Form</h3>
					<p>Please fill in all the necessary options to place a trade</p>
					<button type="button" class="btn btn-danger"
						style="position: absolute; top: 2%; right: 2%; border: 0;">
						<a href="index.html" style="text-decoration: none;">Log Out!</a>
					</button>
					<form action="load-trader" method="post">
						<h1>Order Form</h1>
						<div class="row">
							<div class="col-25">
								<label for="SideType">Side Type</label>
							</div>
							<div class="col-75">
								<select id="sideV" class="btn btn-default dropdown-toggle"
									id="menu1" name="side">

									<option value="none">--Choose--</option>
									<option value="buy">Buy</option>
									<option value="sell">Sell</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-25">
								<label for="">Ticker</label>
							</div>
							<div class="col-75">
								<select id="tickerV" class="btn btn-default dropdown-toggle"
									name="ticker">

									<option value="none">--Select--</option>

									<option name="stock" value="SBI">SBIN</option>
									<option name="stock" value="SBB">SBBJ</option>
									<option name="stock" value="BAN">BANKINDIA</option>
									<option name="stock" value="GLI">GLITTEKG</option>
									<option name="stock" value="SRI">SRIVAJRA</option>
									<option name="stock" value="SOL">SOLIDSTON</option>
									<option name="stock" value="NES">NESTLEIND</option>
									<option name="stock" value="MOD">MODAIRY</option>
									<option name="stock" value="MLK">MLKFOOD</option>
									<option name="stock" value="NCC">NCCBLUE</option>


								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-25">
								<label for="Quantity">Quantity</label>
							</div>
							<div class="col-75">
								<input id="quantity" class="fill" type="text" name="quantity"><font
									color="red"><label id="errorText"></label></font>
							</div>
						</div>
						<div class="row">
							<div class="col-25">
								<label for="Trader">Trader Name</label>
							</div>
							<div class="col-75">
								<select id="trader" class="btn btn-default dropdown-toggle"
									name="traderId">

									<option value="none">--Select--</option>
									<option value="1">John Peters</option>
									<option value="2">Anny Sebastian</option>
									<option value="3">Harsh Awasthi</option>
								</select>
							</div>
						</div>
						<div class="row">
							<button class="btn btn-danger">submit</button>
						</div>
					</form>

				</div>



			</div>
		</div>


	</div>
	<div id="menu2" class="tab-pane fade"></div>

	</div>
	</div>
	
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<script src="./validation.js" type="text/javascript"></script>
</body>
</html>