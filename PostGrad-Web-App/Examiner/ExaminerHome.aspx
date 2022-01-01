<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerHome.aspx.cs" Inherits="PostGrad_Web_App.ExaminerHome" MasterPageFile="~/MainMaster.Master"%>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
    <title></title>
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
        <div>
            Welcome,<br />
            <br />
            <br />
        </div>
        <p>
            <asp:Label ID="ExaminerProfile" runat="server"></asp:Label>
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
        <asp:Button ID="EditInfo" runat="server" Text="Edit Your Personal Info" Width="335px" OnClick="EditInfo_Click" />
        </p>
        <p>
            <asp:Button ID="ViewInfo" runat="server" Text="View Related Information" Width="335px" OnClick="ViewInfo_Click" />
        </p>
        <p>
            <asp:Button ID="evaluate" runat="server" Text="Add Evaluation" Width="333px" OnClick="evaluate_Click" />
        </p>
        <p>
            <asp:Button ID="lookUpThesis" runat="server" Text="Search for a Specific Thesis" OnClick="lookUpThesis_Click" Height="31px" Width="333px" />
        </p>
        <p>
            <asp:Button ID="ExaminerLogOut" runat="server" Text="Log Out" OnClick="ExaminerLogOut_Click" Width="333px" />
        </p>
</asp:Content>
