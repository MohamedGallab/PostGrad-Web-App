<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerRegister.aspx.cs" Inherits="PostGrad_Web_App.ExaminerRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {
            background-color : black;
            color : white;
            margin : 5px;
        }
    </style>
</head>
<body>
    <form id="RegisterationForm" runat="server">
        <asp:Label runat="server" Text="name"></asp:Label>
        <br/>
        <asp:TextBox ID="name" runat="server"></asp:TextBox>
        <br/>

        <asp:Label runat="server" Text="password"></asp:Label>
        <br/>
        <asp:TextBox ID="password" runat="server"></asp:TextBox>
        <br/>

        <asp:Label runat="server" Text="isNational"></asp:Label>
        <br/>
        <asp:CheckBox ID="isNational" runat="server" />
        <br/>

        <asp:Label runat="server" Text="email"></asp:Label>
        <br/>
        <asp:TextBox ID="email" runat="server"></asp:TextBox>
        <br/>

        <asp:Label runat="server" Text="fieldOfWork"></asp:Label>
        <br/>
        <asp:TextBox ID="fieldOfWork" runat="server"></asp:TextBox>
        <br/>

    	<asp:Button ID="RegisterBtn" runat="server" Text="Register" OnClick="RegisterBtn_Click" />
    </form>
</body>
</html>
