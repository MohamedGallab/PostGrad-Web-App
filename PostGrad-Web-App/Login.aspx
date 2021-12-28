<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PostGrad_Web_App.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
</head>
<body>
	<form id="form1" runat="server">
		<div>
			<asp:Label runat="server" Text="Email"></asp:Label>
			<br />
			<asp:TextBox ID="Email" runat="server"></asp:TextBox>
			<br />
			<asp:Label runat="server" Text="Password"></asp:Label>
			<br />
			<asp:TextBox ID="Password" runat="server"></asp:TextBox>
			<br />
			<asp:Button ID="LoginBtn" runat="server" Text="Login" OnClick="LoginBtn_Click"/>
			<br />
			<asp:HyperLink ID="RegisterLink" runat="server" NavigateUrl="~/Register.aspx">Register A New Account</asp:HyperLink>
		</div>
	</form>
</body>
</html>
