<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentHome.aspx.cs" Inherits="PostGrad_Web_App.StudentHome" MasterPageFile="~/MainMaster.Master" %>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
	<title></title>

</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
	<div style="text-align: center">
		<div>
			<asp:Label runat="server" Text="add mobile number"></asp:Label>
			<br />
			<asp:TextBox ID="mobileNumber" runat="server" MaxLength="20"></asp:TextBox>
			<br />
			<asp:Panel ID="MobileSuccess" runat="server"></asp:Panel>

			<asp:Button ID="addNumber" runat="server" Text="Add Number" OnClick="AddMobileClicked" />
		</div>
		<br />
		<div>
			<asp:Button ID="profile" runat="server" Text="view my profile" OnClick="profile_Click" />
		</div>
		<br />
		<div>
			<asp:Button ID="theses" runat="server" Text="view my theses" OnClick="theses_Click" />
		</div>
		<br />
		<div>
			<asp:Button ID="courses" runat="server" Text="view my courses and check grades" OnClick="courses_Click" />
		</div>
		<br />
		<div>
			<asp:Button ID="progressReport" runat="server" Text="add and fill a progress report for my thesis." OnClick="progressReport_Click" />
		</div>
		<br />
		<div>
			<asp:Button ID="publication" runat="server" Text="add and a publication to my thesis" OnClick="publication_Click" />
		</div>

	</div>
</asp:Content>
