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
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <p>
            <asp:Label ID="responseL" runat="server"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="lookUpB" runat="server" Width="289px"></asp:TextBox>
        <asp:Button ID="lookUpConfirm" runat="server" Text="Confirm" OnClick="lookUpConfirm_Click" style="margin-left: 48px" />
        </p>
        <asp:GridView ID="ThesisView" runat="server">
        </asp:GridView>
        <p>
        <asp:Button ID="backBB" runat="server" Text="Back" OnClick="backBB_Click" />
        </p>
    </form>
</body>
</html>
