<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerViewInfo.aspx.cs" Inherits="PostGrad_Web_App.ExaminerViewInfo" MasterPageFile="~/MainMaster.Master"%>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 476px;
        }
    </style>
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
        <div>
        <asp:Label ID="headerLL" runat="server" Text="Welcome, These are all the titles, supervisors, and students names you've attended defenses for:"></asp:Label>
        </div>
        <asp:Label ID="gucianViewL" runat="server" Text="Done By Gucian Students:"></asp:Label>
        <asp:GridView ID="gucianView" runat="server">
        </asp:GridView>
        <asp:Label ID="nonGucianL" runat="server" Text="Done By Non Gucian Students:"></asp:Label>
        <asp:GridView ID="nonGucianView" runat="server">
        </asp:GridView>
        <asp:Button ID="backB" runat="server" Text="Back" OnClick="backB_Click" />
</asp:Content>
