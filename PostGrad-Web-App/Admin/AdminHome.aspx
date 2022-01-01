<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="PostGrad_Web_App.AdminHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Admin Homepage</title>
	<style>
		#ThesesCountLabel {
			color : crimson;
		}
	</style>
</head>
<body>
	<form id="form1" runat="server">

		<asp:Panel ID="ListSupPanel" runat="server">
			<asp:Button ID="ListSupBtn" runat="server" Text="List All Supervisors" OnClick="ListSupBtn_Click" />
			<asp:GridView ID="ListSupGridView" runat="server"></asp:GridView>
		</asp:Panel>

		<br/>

		<asp:Panel ID="ListThesesPanel" runat="server">
			<asp:Button ID="ListTheses" runat="server" Text="List All Theses" OnClick="ListTheses_Click"/>
			<br/>
			<asp:Label ID="ThesesCountLabel" runat="server" Text=""></asp:Label>
			<asp:GridView ID="ListThesesGridView" runat="server"></asp:GridView>
		</asp:Panel>
		
		<br/>

		<asp:Panel ID="ExtendThesisPanel" runat="server">
			<asp:Button ID="ExtendThesisBtn" runat="server" Text="Extend a Thesis" OnClick="ExtendThesisBtn_Click" />
			<br/>
			<asp:TextBox ID="ExtendThesisTxt" runat="server" placeholder="Enter Thesis Serial Number" TextMode="Number"></asp:TextBox>
			<asp:Label ID="ExtendThesislabel" runat="server" Text=""></asp:Label>
		</asp:Panel>
		
		<br/>

		<asp:Panel ID="IssueThesisPaymentPanel" runat="server">
			<asp:Button ID="IssueThesisPaymentBtn" runat="server" Text="Issue a thesis payment." OnClick="IssueThesisPaymentBtn_Click"  />
			<br/>
			<asp:TextBox ID="IssueThesisPaymentThesisSerialNo" runat="server" placeholder="Enter Thesis Serial Number" TextMode="Number"></asp:TextBox>
			<asp:TextBox ID="IssueThesisPaymentamount" runat="server" placeholder="Enter payment amount" TextMode="Number"></asp:TextBox>
			<asp:TextBox ID="IssueThesisPaymentnoOfInstallments" runat="server" placeholder="Enter number of installments" TextMode="Number"></asp:TextBox>
			<asp:TextBox ID="IssueThesisPaymentfundPercentage" runat="server" placeholder="Enter fund percentage" TextMode="Number"></asp:TextBox>
			<asp:Label ID="IssueThesisPaymentLabel" runat="server" Text=""></asp:Label>
			<br />
		</asp:Panel>

		<br/>

		<asp:Panel ID="IssueInstallPaymentPanel" runat="server">
			<br />
			<asp:Button ID="IssueInstallPayment" runat="server" Text=" Issue installments for a payment." OnClick="IssueInstallPayment_Click"  />
			<br/>
			<asp:TextBox ID="IssueInstallPaymentpaymentID" runat="server" placeholder="Enter payment ID" TextMode="Number"></asp:TextBox>
			<asp:Label ID="IssueInstallPaymentMessage" runat="server"></asp:Label>
			<br/>
			<asp:Label ID="IssueInstallPaymentInstallDateLabel" runat="server" Text="Choose Installment Start date"></asp:Label>
			<asp:Calendar ID="IssueInstallPaymentInstallStartDate" runat="server" ></asp:Calendar>
		</asp:Panel>
		
	</form>
</body>
</html>

