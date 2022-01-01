<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerEvaluate.aspx.cs" Inherits="PostGrad_Web_App.ExaminerEvaluate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <asp:Label ID="PickDefenseL" runat="server" Text="Pick a Defense to Evaluate:"></asp:Label>
        </div>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="DefenseDateL" runat="server" Text="Defense Date: "></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="DefenseDateB" runat="server" type="datetime-local" Width="227px"></asp:TextBox>
        </p>
        <p>
        <asp:Label ID="DefenseNoL" runat="server" Text="Serial Number of the Thesis Defended:"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="DefenseNoB" runat="server" Width="227px"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="GradeDefenseL" runat="server" Text="Grade:"></asp:Label>
        </p>
        <p>
        <asp:TextBox ID="GradeDefenseB" runat="server" Width="125px"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="GradeDefense" runat="server" Text="Confirm Grade" OnClick="GradeDefense_Click" />
        </p>
        <p>
            <asp:Label ID="CommentDefenseL" runat="server" Text="Comments:"></asp:Label>
        </p>
        <p>
        <asp:TextBox ID="CommentDefenseB" runat="server" Height="95px" Width="743px"></asp:TextBox>
        </p>
        <asp:Button ID="CommentDefense" runat="server" Text="Confirm Comments" Width="175px" OnClick="CommentDefense_Click" />
        <p>
            <asp:Button ID="Back" runat="server" Text="Back" OnClick="Back_Click" />
        </p>
    </form>
</body>
</html>
