<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentProgressReport.aspx.cs" Inherits="PostGrad_Web_App.Student.StudentProgressReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div >
            <asp:Label ID="addTitle" runat="server" Font-Underline="true" Text="add your progress report"></asp:Label>
            <br />
            <br />
            <asp:Label ID="ThesisSerialNoLabel" runat="server" Text="Thesis Serial Number"></asp:Label>
            <asp:TextBox ID="ThesisSerialNo" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="ProgressReportDateLabel" runat="server" Text="Progress Report date"></asp:Label>
            <asp:Calendar ID="ProgressReportDate" runat="server" ></asp:Calendar>
            <br />

            <asp:Label ID="ProgressReportNoLabel" runat="server" Text="progress report number"></asp:Label>
            <asp:TextBox ID="ProgressReportNoText" runat="server"></asp:TextBox>
            <br />

            <asp:Button ID="addReportBtn" runat="server" Text="add progress report" OnClick ="addReportBtn_Click" />
        </div>
        <br />
        <hr />
        <br />
        <div>
            <asp:Label ID="fillTitle" runat="server" Font-Underline="true" Text="fill your progress report"></asp:Label>
            <br />

            <asp:Label ID="SerialNumLabel" runat="server" Text="Thesis Serial Number"></asp:Label>
            <asp:TextBox ID="SerialNumText" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="ReportNOLabel" runat="server" Text="Progress Report Number"></asp:Label>
            <asp:TextBox ID="ProgressReportNumText" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="StateLabel" runat="server" Text="State"></asp:Label>
            <asp:TextBox ID="StateText" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="descriptionLabel" runat="server" Text="Description"></asp:Label>
            <br />
            <asp:TextBox ID="DescriptionText" runat="server" Height="143px" Width="224px"></asp:TextBox>
            <br />

            <asp:Button ID="fillReportBtn" runat="server" Text="fill progress report" OnClick ="fillReportBtn_Click" />
        </div>
    </form>
</body>
</html>
