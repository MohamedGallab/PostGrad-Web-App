<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerRegister.aspx.cs" Inherits="PostGrad_Web_App.ExaminerRegister" MasterPageFile="~/RegisterMaster.Master"%>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
    <title>Examiner Register</title>
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
         
        <asp:Label runat="server" Text="Name"></asp:Label>
        <asp:TextBox ID="name" class = "form-control" MaxLength="20" placeholder = "Name" runat="server"></asp:TextBox>
        
        <asp:Label runat="server" Text="Password"></asp:Label>
        <asp:TextBox ID="password" class = "form-control" MaxLength="30" placeholder = "Password" runat="server"></asp:TextBox>

        <div>
            <asp:Label runat="server" Text="Is National?"></asp:Label>
            <asp:CheckBox ID="isNational" class = "checkboxSpan" runat="server" />
        </div>

        <asp:Label runat="server" Text="Email"></asp:Label>  
        <asp:TextBox ID="email" class = "form-control" MaxLength="50" placeholder = "Email" runat="server"></asp:TextBox>
        

        <asp:Label runat="server" Text="Field Of Work"></asp:Label>
        <asp:TextBox ID="fieldOfWork" class = "form-control" placeholder = "Field Of Work"  MaxLength="100" runat="server"></asp:TextBox>
        
         <asp:Label ID="RegisterMessage" runat="server" Text=""></asp:Label>

    	<asp:Button ID="RegisterBtn" class = "btn btn-dark align-self-center" runat="server" Text="Register" OnClick="RegisterBtn_Click" />
</asp:Content>
