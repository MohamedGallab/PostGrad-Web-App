<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListMyStudents.aspx.cs" Inherits="PostGrad_Web_App.Supervisor.ListMyStudents" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="StudentsList" runat="server">

            </asp:Table>
             <asp:DataGrid ID="DataGrid1" runat="server"></asp:DataGrid> 
        </div>
    </form>
</body>
</html>
    