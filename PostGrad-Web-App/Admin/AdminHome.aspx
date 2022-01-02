<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="PostGrad_Web_App.AdminHome" MasterPageFile="~/MainMaster.Master" %>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
	<title>Admin Homepage</title>
	<link href="Css/main.css" rel="stylesheet" type="text/css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />

	<style>
		span {
			color: crimson;
		}

		#BodyPlaceHolder_IssueInstallPaymentInstallDateLabel {
			color: dimgray;
		}
	</style>
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">

	<div id="adminMainDiv" class="container-fluid h-100 mb-2">
		<div class="d-flex justify-content-start align-items-start m-3">

			<asp:Panel ID="ExtendThesisPanel" class="componentsAdmin col-2" runat="server">
				<asp:TextBox ID="ExtendThesisTxt" class="form-control" runat="server" placeholder="Thesis Serial Number" TextMode="Number" ></asp:TextBox>
				<asp:Panel ID="ExtendThesisSuccess" runat="server"></asp:Panel>
				<asp:Button ID="ExtendThesisBtn" class="btn btn-dark" runat="server" Text="Extend a Thesis" OnClick="ExtendThesisBtn_Click" />
			</asp:Panel>

			<asp:Panel ID="IssueThesisPaymentPanel" class="componentsAdmin col-3" runat="server">

				<asp:TextBox ID="IssueThesisPaymentThesisSerialNo" class="form-control" runat="server" placeholder="Thesis Serial Number" TextMode="Number"></asp:TextBox>
				<asp:TextBox ID="IssueThesisPaymentamount" class="form-control" runat="server" placeholder="payment amount" TextMode="Number" step="0.01" min="0" max="99999.99"></asp:TextBox>
				<asp:TextBox ID="IssueThesisPaymentnoOfInstallments" class="form-control" runat="server" placeholder="number of installments" TextMode="Number"></asp:TextBox>
				<asp:TextBox ID="IssueThesisPaymentfundPercentage" class="form-control" runat="server" placeholder="fund percentage" TextMode="Number" step="0.01" min="0" max="99.99"></asp:TextBox>

				<asp:Panel ID="IssueThesisPaymentSuccess" runat="server"></asp:Panel>
				<asp:Button ID="IssueThesisPaymentBtn" class="btn btn-dark" runat="server" Text="Issue a thesis payment." OnClick="IssueThesisPaymentBtn_Click" />


			</asp:Panel>

			<asp:Panel ID="IssueInstallPaymentPanel" class="componentsAdmin col-3" runat="server">


				<asp:TextBox ID="IssueInstallPaymentpaymentID" class="form-control" runat="server" placeholder="payment ID" TextMode="Number"></asp:TextBox>
				<asp:Label ID="IssueInstallPaymentInstallDateLabel" runat="server" Text="Choose Installment Start date"></asp:Label>
				<asp:Calendar ID="IssueInstallPaymentInstallStartDate" runat="server"></asp:Calendar>

				<asp:Panel ID="IssueInstallPaymentSuccess" runat="server"></asp:Panel>
				<asp:Button ID="IssueInstallPayment" class="btn btn-dark" runat="server" Text=" Issue installments for a payment." OnClick="IssueInstallPayment_Click" />

			</asp:Panel>
		</div>

		<asp:Panel ID="ListSupPanel" class="m-3" runat="server">

			<asp:Button ID="ListSupBtn" runat="server" Text="List All Supervisors" OnClick="ListSupBtn_Click" />
			<asp:Panel ID="ListSupGridViewPanel" runat="server"></asp:Panel>

		</asp:Panel>

		<asp:Panel ID="ListThesesPanel" runat="server">

			<div class="d-flex m-3">
				<asp:Button ID="ListTheses" runat="server" Text="List All Theses" OnClick="ListTheses_Click" />
				<asp:Panel ID="ThesesCountPanel" class="align-self-center ms-3" runat="server"></asp:Panel>
			</div>


			<asp:Panel ID="ListThesesGridPanel" runat="server">

			</asp:Panel>

		</asp:Panel>
	</div>
	<br/>

</asp:Content>

