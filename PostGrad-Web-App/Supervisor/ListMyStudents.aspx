<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListMyStudents.aspx.cs" Inherits="PostGrad_Web_App.Supervisor.ListMyStudents" MasterPageFile="~/MainMaster.Master"%>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
    <title></title>
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
        <div>
            <asp:Table ID="StudentsList" runat="server">

            </asp:Table>
             <asp:DataGrid ID="DataGrid1" runat="server"></asp:DataGrid> 
        </div>
</asp:Content>
    