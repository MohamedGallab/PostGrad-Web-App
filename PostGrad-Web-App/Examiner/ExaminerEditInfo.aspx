<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerEditInfo.aspx.cs" Inherits="PostGrad_Web_App.ExaminerEditInfo" MasterPageFile="~/MainMaster.Master"%>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
    <title></title>
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
        <div>
            Edit your Info:<br />
            <br />
            <asp:Label ID="responseL" runat="server"></asp:Label>
            <br />
        <asp:Label ID="EditNameL" runat="server" Text="Edit Your Name:"></asp:Label>
            </div>
        <p>
        <asp:TextBox ID="EditNameB" runat="server" Height="33px" MaxLength="20" style="margin-top: 0px; margin-bottom: 0px" Width="348px"></asp:TextBox>
            <asp:Button ID="ConfirmName" runat="server" OnClick="ConfirmName_Click" style="margin-left: 396px; margin-top: 4px; margin-bottom: 0px;" Text="Confirm New Name" Width="194px" Height="36px" />
        </p>
        <asp:Label ID="EditPasswordL" runat="server" Text="Edit Your Password:"></asp:Label>
        <p>
        <asp:TextBox ID="EditPasswordB" runat="server" MaxLength="30" Height="33px" style="margin-top: 0px; margin-bottom: 0px" Width="351px"></asp:TextBox>
            <asp:Button ID="ConfirmPassword" runat="server" style="margin-left: 390px; margin-top: 2px;" Text="Confirm New Password" Height="37px" OnClick="ConfirmPassword_Click" Width="196px" />
            </p>
        <asp:Label ID="EditNationalL" runat="server" Text="Edit whether You Are National:"></asp:Label>
        <p>
            <asp:CheckBox ID="NationalC" runat="server" />
            <asp:Button ID="ConfirmNational" runat="server" style="margin-left: 633px; margin-top: 0px;" Text="Confirm National" Width="189px" OnClick="ConfirmNational_Click" Height="34px" />
        </p>
        <asp:Label ID="EditEmailL" runat="server" Text="Edit Email:"></asp:Label>
        <p>
            <asp:TextBox ID="EditEmailB" runat="server" MaxLength="50" Height="30px" style="margin-bottom: 0px" Width="365px"></asp:TextBox>
            <asp:Button ID="ConfirmEmail" runat="server" style="margin-left: 373px; margin-top: 0px" Text="Confirm New Email" Width="193px" OnClick="ConfirmEmail_Click" Height="35px" />
        </p>
        <asp:Label ID="EditFieldOfWorkL" runat="server" Text="Edit Your Field of Work:"></asp:Label>
        <p>
            <asp:TextBox ID="EditFieldOfWorkB" runat="server" MaxLength="100" Height="27px" Width="690px"></asp:TextBox>
            <asp:Button ID="ConfirmFieldOfWork" runat="server" style="margin-left: 45px; margin-top: 0px" Text="Confirm Field Of Work" Width="197px" OnClick="ConfirmFieldOfWork_Click" Height="36px" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="BackFromEditInfoB" runat="server" Height="32px" style="margin-top: 0px" Text="Back" Width="113px" OnClick="BackFromEditInfoB_Click" />
        </p>
</asp:Content>
