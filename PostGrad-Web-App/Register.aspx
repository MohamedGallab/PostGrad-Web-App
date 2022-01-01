<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="PostGrad_Web_App.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Register Page</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />

	<link href="Css/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="container-fluid h-100">
		<div class="row justify-content-center align-items-center h-100">
			<div class="col col-sm-6 col-md-6 col-lg-4 col-xl-4">
				<form id="form1" runat="server">
				   <div id = "mainDiv" class = "d-flex justify-content-evenly">
						<asp:Button class= "btn btn-dark RegisterButtons" ID="Button1" runat="server" Text="Student" OnClick="StudentRegister_Click" />
						<asp:Button class= "btn btn-dark RegisterButtons" ID="Button2" runat="server" Text="Supervisor" OnClick="SupervisorRegister_Click"/>
						<asp:Button class= "btn btn-dark RegisterButtons" ID="Button3" runat="server" Text="Examiner" OnClick="ExaminerRegister_Click"/>

					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>

