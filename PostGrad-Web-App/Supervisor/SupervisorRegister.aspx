<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupervisorRegister.aspx.cs" Inherits="PostGrad_Web_App.SupervisorRegister" MasterPageFile="~/RegisterMaster.Master"%>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
    <title>Supervisor Register</title>
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
        
        <asp:Label runat="server" Text="First Name"></asp:Label>
        <asp:TextBox class = "form-control" ID="first_name" placeholder = "First Name" MaxLength="20" runat="server"></asp:TextBox>
        
        <asp:Label runat="server" Text="Last Name"></asp:Label>
        <asp:TextBox class = "form-control" ID="last_name" placeholder = "Name" MaxLength="20" runat="server"></asp:TextBox>
        

        <asp:Label runat="server" Text="Password"></asp:Label>
        <asp:TextBox class = "form-control" ID="password" placeholder = "Password" MaxLength="20" runat="server"></asp:TextBox>
        
        <asp:Label runat="server" Text="Faculty"></asp:Label>
        <asp:TextBox class = "form-control" ID="faculty" placeholder = "Faculty" MaxLength="20" runat="server"></asp:TextBox>

        <asp:Label runat="server" Text="Email"></asp:Label>
        <asp:TextBox class = "form-control" ID="email" placeholder = "Email" MaxLength="50" runat="server"></asp:TextBox>
        
        <asp:Label ID="RegisterMessage" class = "align-self-center" runat="server" Text=""></asp:Label>

    	<asp:Button ID="RegisterBtn" class = "btn btn-dark align-self-center" runat="server" Text="Register" OnClick="RegisterBtn_Click" />
</asp:Content>
