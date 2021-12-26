<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentRegister.aspx.cs" Inherits="PostGrad_Web_App.StudentRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <form id="form3331" runat="server">
                <asp:Label runat="server" Text="first_name"></asp:Label>
                <asp:TextBox runat="server" ID="first_name" type="text"></asp:TextBox>
                <br />
                <asp:Label runat="server" Text="last_name"></asp:Label>
                <asp:TextBox runat="server" ID="last_name" type="text"></asp:TextBox>
                <br />
                <asp:Label runat="server" Text="password"></asp:Label>
                <asp:TextBox runat="server" ID="password" type="text"></asp:TextBox>
                <br />
                <asp:Label runat="server" Text="faculty"></asp:Label>
                <asp:TextBox runat="server" ID="faculty" type="text"></asp:TextBox>
                <br />
                <asp:Label runat="server" Text="Gucian"></asp:Label>
                <asp:TextBox runat="server" ID="Gucian" type="text"></asp:TextBox>
                <br />
                <asp:Label runat="server" Text="email"></asp:Label>
                <asp:TextBox runat="server" ID="email" type="text"></asp:TextBox>
                <br />
                <asp:Label runat="server" Text="address"></asp:Label>
                <asp:TextBox runat="server" ID="address" type="text"></asp:TextBox>
                <br />
                <asp:Button ID="registerButton" runat="server" Text="Register" OnClick="register" />
            </form>
        </div>
    </form>
</body>
</html>
