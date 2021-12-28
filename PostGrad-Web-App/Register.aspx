<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="PostGrad_Web_App.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
</head>
<body>
	<form id="form1" runat="server">
		<div>
			<asp:Button ID="StudentRegister" runat="server" Text="Student" OnClick="StudentRegister_Click" />
			<asp:Button ID="SupervisorRegister" runat="server" Text="Supervisor" OnClick="SupervisorRegister_Click"/>
			<asp:Button ID="ExaminerRegister" runat="server" Text="Examiner" OnClick="ExaminerRegister_Click"/>
		</div>
	</form>
</body>
</html>
