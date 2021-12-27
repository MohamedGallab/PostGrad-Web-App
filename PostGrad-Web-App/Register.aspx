<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="PostGrad_Web_App.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
</head>
<body>
	<form id="form1" runat="server">
		<div>
			<asp:Button ID="Button1" runat="server" Text="Student" OnClick="Button1_Click" />
			<asp:Button ID="Button2" runat="server" Text="Supervisor" OnClick="Button2_Click"/>
			<asp:Button ID="Button3" runat="server" Text="Examiner" OnClick="Button3_Click"/>
		</div>
	</form>
</body>
</html>
