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
		<asp:Button ID="ListSupBtn" runat="server" Text="List All Supervisors" OnClick="ListSupBtn_Click" />
		<asp:GridView ID="ListSupGridView" runat="server"></asp:GridView>
		<br/>
		<asp:Button ID="ListTheses" runat="server" Text="List All Theses" OnClick="ListTheses_Click"/>
		<br/>
		<asp:Label ID="ThesesCountLabel" runat="server" Text=""></asp:Label>
		<asp:GridView ID="ListThesesGridView" runat="server"></asp:GridView>
		<br/>
		<asp:Button ID="ExtendThesisBtn" runat="server" Text="Extend a Thesis" OnClick="ExtendThesisBtn_Click" />
		<br/>
		<asp:TextBox ID="ExtendThesisTxt" runat="server" placeholder="Enter Thesis Serial Number"></asp:TextBox>
		<asp:Label ID="ExtendThesislabel" runat="server" Text=""></asp:Label>
		<br/>
		<br/>
		<asp:Button ID="IssueThesisPaymentBtn" runat="server" Text="Issue a thesis payment." OnClick="IssueThesisPaymentBtn_Click"  />
		<br/>
		<asp:TextBox ID="IssueThesisPaymentThesisSerialNo" runat="server" placeholder="Enter Thesis Serial Number"></asp:TextBox>
		<asp:TextBox ID="IssueThesisPaymentamount" runat="server" placeholder="Enter payment amount"></asp:TextBox>
		<asp:TextBox ID="IssueThesisPaymentnoOfInstallments" runat="server" placeholder="Enter number of installments"></asp:TextBox>
		<asp:TextBox ID="IssueThesisPaymentfundPercentage" runat="server" placeholder="Enter fund percentage"></asp:TextBox>
		<asp:Label ID="IssueThesisPaymentLabel" runat="server" Text=""></asp:Label>
		<br />
		<br />
		<asp:Button ID="IssueInstallPayment" runat="server" Text=" Issue installments for a payment." OnClick="IssueInstallPayment_Click"  />
		<br/>
		<asp:TextBox ID="IssueInstallPaymentpaymentID" runat="server" placeholder="Enter payment ID"></asp:TextBox>
		<br/>
		<asp:Label ID="IssueInstallPaymentInstallDateLabel" runat="server" Text="Choose Installment Start date"></asp:Label>
		<asp:Calendar ID="IssueInstallPaymentInstallStartDate" runat="server"></asp:Calendar>
		<%--<asp:TextBox ID="IssueInstallPaymentInstallStartDateTxt" runat="server" placeholder="Enter Installment Start date"></asp:TextBox>--%>
	</form>
</body>
</html>

