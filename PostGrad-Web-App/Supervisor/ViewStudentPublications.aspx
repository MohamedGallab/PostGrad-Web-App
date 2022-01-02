<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewStudentPublications.aspx.cs" Inherits="PostGrad_Web_App.Supervisor.ViewStudentPublications" MasterPageFile="~/MainMaster.Master"%>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
    <title></title>
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
        <div>
            <asp:GridView ID="PublicationsGrid" runat="server"></asp:GridView>
        </div>
</asp:Content>
