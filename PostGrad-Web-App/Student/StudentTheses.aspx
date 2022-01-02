<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentTheses.aspx.cs" Inherits="PostGrad_Web_App.Student.studentTheses" MasterPageFile="~/MainMaster.Master" %>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
	<title></title>
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
	<div>
		<asp:GridView ID="StudentViewThesesGridview" runat="server"></asp:GridView>
	</div>
</asp:Content>
