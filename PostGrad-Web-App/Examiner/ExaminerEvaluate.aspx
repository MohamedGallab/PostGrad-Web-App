<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerEvaluate.aspx.cs" Inherits="PostGrad_Web_App.ExaminerEvaluate" MasterPageFile="~/MainMaster.Master"%>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
    <title></title>
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
        <div>
        <asp:Label ID="PickDefenseL" runat="server" Text="Pick a Defense to Evaluate:"></asp:Label>
        </div>
        <p>
            <asp:Label ID="responseL" runat="server"></asp:Label>
        </p>
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
            <asp:TextBox ID="DefenseNoB" runat="server" type="number" Width="227px"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="GradeDefenseL" runat="server" Text="Grade:"></asp:Label>
        </p>
        <p>
        <asp:TextBox ID="GradeDefenseB" runat="server" type="number" step="0.01" Width="125px"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="GradeDefense" runat="server" Text="Confirm Grade" OnClick="GradeDefense_Click" />
        </p>
        <p>
            <asp:Label ID="CommentDefenseL" runat="server" Text="Comments:"></asp:Label>
        </p>
        <p>
        <asp:TextBox ID="CommentDefenseB" runat="server" Height="95px" MaxLength="300" Width="743px"></asp:TextBox>
        </p>
        <asp:Button ID="CommentDefense" runat="server" Text="Confirm Comments" Width="175px" OnClick="CommentDefense_Click" />
        <p>
            <asp:Button ID="Back" runat="server" Text="Back" OnClick="Back_Click" />
        </p>
</asp:Content>
