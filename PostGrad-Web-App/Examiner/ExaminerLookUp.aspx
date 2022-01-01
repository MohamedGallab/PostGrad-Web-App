<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerLookUp.aspx.cs" Inherits="PostGrad_Web_App.ExaminerLookUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Label ID="headerL" runat="server" Text="Look up a specific thesis:"></asp:Label>
        <p>
            <asp:TextBox ID="lookUpB" runat="server" Width="289px"></asp:TextBox>
        </p>
        <asp:Button ID="lookUpConfirm" runat="server" Text="Confirm" OnClick="lookUpConfirm_Click" />
        <asp:GridView ID="ThesisView" runat="server">
        </asp:GridView>
        <asp:Button ID="backBB" runat="server" Text="Back" OnClick="backBB_Click" />
    </form>
</body>
</html>
