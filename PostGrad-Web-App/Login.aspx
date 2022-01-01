<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PostGrad_Web_App.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Login page</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />
	<link href="Css/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="container-fluid h-100">
		<div class="row justify-content-center align-items-center h-100">
			<div class="col col-sm-6 col-md-6 col-lg-4 col-xl-3">
				<form id="form1" runat="server">
				   <div id = "mainDiv" class = "d-flex flex-column align-items-start m-auto">
						<asp:Label runat="server" Text="Email"></asp:Label>

						<asp:TextBox class="form-control" ID="Email" runat="server" placeholder="name@example.com"></asp:TextBox>

						<asp:Label runat="server" Text="Password"></asp:Label>

						<asp:TextBox class="form-control" ID="Password" runat="server"></asp:TextBox>

						<asp:Button ID = "LoginBtn" class = "btn btn-dark" runat="server" Text="Login" OnClick="LoginBtn_Click"/>

						<asp:HyperLink ID="RegisterLink" runat="server" NavigateUrl="~/Register.aspx">Register A New Account</asp:HyperLink>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
