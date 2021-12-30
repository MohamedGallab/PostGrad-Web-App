<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentProgressReport.aspx.cs" Inherits="PostGrad_Web_App.Student.StudentProgressReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align:center">
            <asp:Label ID="Label14" runat="server" Font-Underline="true" Text="add and fill your progress report"></asp:Label>
            <br />

            <asp:Label ID="ThesisSerialNoLabel" runat="server" Text="Thesis Serial Number"></asp:Label>
            <asp:TextBox ID="ThesisSerialNo" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="ProgressReportNoLabel" runat="server" Text="Progress Report Number"></asp:Label>
            <asp:TextBox ID="ProgressReportNo" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="EvalLabel" runat="server" Text="Evaluation"></asp:Label>
            <asp:TextBox ID="Eval" runat="server"></asp:TextBox>
            <br />

            <asp:Button ID="Button6" runat="server" Text="Evaluate Progress Report" OnClick ="OnEvaluate" />
        </div>
    </form>
</body>
</html>
