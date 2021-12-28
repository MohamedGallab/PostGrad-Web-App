<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentHome.aspx.cs" Inherits="PostGrad_Web_App.StudentHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
        <div>
            add a phone number
        </div>
        <p>
            <asp:TextBox ID="mobileNumber" runat="server"></asp:TextBox>
        <p>
         <asp:Button ID="addNumber" runat="server" Text="Add Number" OnClick="AddMobileClicked" />
        </p>
    </form>
</body>
</html>
