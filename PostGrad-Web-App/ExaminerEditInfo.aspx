﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerEditInfo.aspx.cs" Inherits="PostGrad_Web_App.ExaminerEditInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Edit your Info:<br />
            <br />
            <br />
        <asp:Label ID="EditNameL" runat="server" Text="Edit Your Name:"></asp:Label>
            </div>
        <p>
        <asp:TextBox ID="EditNameB" runat="server" Height="33px" style="margin-top: 0px; margin-bottom: 0px" Width="348px"></asp:TextBox>
            <asp:Button ID="ConfirmName" runat="server" OnClick="ConfirmName_Click" style="margin-left: 48px; margin-top: 0px; margin-bottom: 1px;" Text="Confirm New Name" Width="194px" Height="36px" />
        </p>
        <asp:Label ID="EditPasswordL" runat="server" Text="Edit Your Password:"></asp:Label>
        <p>
        <asp:TextBox ID="EditPasswordB" runat="server" Height="33px" style="margin-top: 0px; margin-bottom: 0px" Width="351px"></asp:TextBox>
            <asp:Button ID="ConfirmPassword" runat="server" style="margin-left: 39px; margin-top: 2px;" Text="Confirm New Password" Height="37px" OnClick="ConfirmPassword_Click" Width="196px" />
            </p>
        <asp:Label ID="EditNationalL" runat="server" Text="Edit whether You Are National:"></asp:Label>
        <p>
            <asp:CheckBox ID="NationalC" runat="server" />
            <asp:Button ID="ConfirmNational" runat="server" style="margin-left: 285px" Text="Confirm National" Width="197px" OnClick="ConfirmNational_Click" Height="34px" />
        </p>
        <asp:Label ID="EditEmailL" runat="server" Text="Edit Email:"></asp:Label>
        <p>
            <asp:TextBox ID="EditEmailB" runat="server" Height="30px" style="margin-bottom: 0px" Width="351px"></asp:TextBox>
            <asp:Button ID="ConfirmEmail" runat="server" style="margin-left: 42px; margin-top: 0px" Text="Confirm New Email" Width="193px" OnClick="ConfirmEmail_Click" Height="35px" />
        </p>
        <asp:Label ID="EditFieldOfWorkL" runat="server" Text="Edit Your Field of Work:"></asp:Label>
        <p>
            <asp:TextBox ID="EditFieldOfWorkB" runat="server" Height="27px" Width="353px"></asp:TextBox>
            <asp:Button ID="ConfirmFieldOfWork" runat="server" style="margin-left: 45px; margin-top: 0px" Text="Confirm Field Of Work" Width="185px" OnClick="ConfirmFieldOfWork_Click" Height="36px" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="BackFromEditInfoB" runat="server" Height="32px" style="margin-top: 0px" Text="Back" Width="113px" OnClick="BackFromEditInfoB_Click" />
        </p>
    </form>
</body>
</html>
