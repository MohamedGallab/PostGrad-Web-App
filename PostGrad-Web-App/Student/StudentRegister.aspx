<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentRegister.aspx.cs" Inherits="PostGrad_Web_App.StudentRegister" MasterPageFile="~/RegisterMaster.Master"%>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
    <title>Student Register</title>
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

        <asp:Label runat="server" Text="First Name"></asp:Label>
        <asp:TextBox ID="first_name"  class = "form-control" placeholder = "First Name" MaxLength="20" runat="server"></asp:TextBox>
        

        <asp:Label runat="server" Text="Last Name"></asp:Label>
        <asp:TextBox ID="last_name" class = "form-control" placeholder = "Last Name" MaxLength="20" runat="server"></asp:TextBox>
        

        <asp:Label runat="server" Text="Password"></asp:Label>
        <asp:TextBox ID="password" class = "form-control" placeholder = "Password" MaxLength="20" runat="server"></asp:TextBox>
        

        <asp:Label runat="server" Text="Faculty" MaxLength="20"></asp:Label>
        <asp:TextBox ID="faculty" class = "form-control" placeholder = "Faculty" MaxLength="20" runat="server"></asp:TextBox>
        
        <div>
            <asp:Label runat="server" Text="Are you a Gucian?"></asp:Label>
            <asp:CheckBox ID="Gucian" class = "checkboxSpan" runat="server" />
        </div>

        <asp:Label runat="server" Text="Email"></asp:Label>
        <asp:TextBox ID="email" class = "form-control" placeholder = "Email" MaxLength="50" runat="server"></asp:TextBox>
        

        <asp:Label runat="server" Text="Address"></asp:Label>
        <asp:TextBox ID="address" class = "form-control" placeholder = "Address" runat="server"  MaxLength="50"></asp:TextBox>
        
        <asp:Label ID="RegisterMessage" runat="server" Text=""></asp:Label>

    	<asp:Button ID="RegisterBtn" class = "btn btn-dark align-self-center" runat="server" Text="Register" OnClick="RegisterBtnClicked" />
</asp:Content>
