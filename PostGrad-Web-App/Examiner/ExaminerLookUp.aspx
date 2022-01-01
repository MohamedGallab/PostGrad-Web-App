<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerLookUp.aspx.cs" Inherits="PostGrad_Web_App.ExaminerLookUp" MasterPageFile="~/MainMaster.Master"%>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
    <title></title>
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
        <div>
        </div>
        <asp:Label ID="headerL" runat="server" Text="Look up a specific thesis:"></asp:Label>
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
</asp:Content>
