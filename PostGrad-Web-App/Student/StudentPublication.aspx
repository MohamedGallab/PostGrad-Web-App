<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentPublication.aspx.cs" Inherits="PostGrad_Web_App.Student.StudentPublication" MasterPageFile="~/MainMaster.Master" %>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
	<title></title>
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
	<div>
		<asp:Label ID="addTitle" runat="server" Font-Underline="true" Text="add your publication"></asp:Label>
		<br />
		<br />
		<asp:Label ID="ThesisSerialNumberLabel" runat="server" Text="Thesis serial number"></asp:Label><br />
		<asp:TextBox ID="ThesisSerialNumberText" runat="server" Width="373px"></asp:TextBox>
		<br />
		<asp:Label ID="TitleLabel" runat="server" Text="Title"></asp:Label><br />
		<asp:TextBox ID="TitleText" runat="server" Width="373px"></asp:TextBox>
		<br />
		<br />
		<asp:Label ID="PublicationDateLabel" runat="server" Text="Publication date"></asp:Label><br />
		<asp:Calendar ID="PublicationDateValue" runat="server"></asp:Calendar>
		<br />

		<asp:Label ID="HostLabel" runat="server" Text="host"></asp:Label><br />
		<asp:TextBox ID="HostText" runat="server" Width="373px"></asp:TextBox>
		<br />

		<asp:Label ID="placeLabel" runat="server" Text="place"></asp:Label><br />
		<asp:TextBox ID="placeText" runat="server" Width="373px"></asp:TextBox>
		<br />

		<asp:Label ID="acceptedLabel" runat="server" Text="accepted"></asp:Label>
		<asp:CheckBox ID="isAccepted" runat="server" />
		<br />

		<asp:Panel ID="addLinkPubSuccess" runat="server"></asp:Panel>
		<asp:Button ID="addPublicationBtn" runat="server" Text="add and link publication" OnClick="addPublicationBtn_Click" />
	</div>
	<br />
	<hr />
</asp:Content>
