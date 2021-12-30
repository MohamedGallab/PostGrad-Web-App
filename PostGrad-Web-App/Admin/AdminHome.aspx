<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="PostGrad_Web_App.AdminHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
</head>
<body>
	<form id="form1" runat="server">
		<asp:Button ID="ListSupBtn" runat="server" Text="List All Supervisors" OnClick="ListSupBtn_Click" />
		<asp:GridView ID="ListSupGridView" runat="server"></asp:GridView>
		<br/>
		<asp:Button ID="ListTheses" runat="server" Text="List All Theses" OnClick="ListTheses_Click"/>
		<br/>
		<asp:Label ID="ThesesCountLabel" runat="server" Text=""></asp:Label>
		<asp:GridView ID="ListThesesGridView" runat="server"></asp:GridView>
	</form>
</body>
</html>

