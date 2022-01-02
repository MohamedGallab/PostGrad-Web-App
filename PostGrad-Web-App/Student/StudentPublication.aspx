<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentPublication.aspx.cs" Inherits="PostGrad_Web_App.Student.StudentPublication" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="addTitle" runat="server" Font-Underline="true" Text="add your publication"></asp:Label>
            <br />
            <br />
            <asp:Label ID="TitleLabel" runat="server" Text="Title"></asp:Label><br />
            <asp:TextBox ID="TitleText" runat="server" Width="373px"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="PublicationDateLabel" runat="server" Text="Publication date"></asp:Label><br />
            <asp:Calendar ID="PublicationDateValue" runat="server" ></asp:Calendar>
            <br />

            <asp:Label ID="HostLabel" runat="server" Text="host"></asp:Label><br />
            <asp:TextBox ID="HostText" runat="server" Width="373px"></asp:TextBox>
            <br />

            <asp:Label ID="placeLabel" runat="server" Text="place"></asp:Label><br />
            <asp:TextBox ID="placeText" runat="server" Width="373px"></asp:TextBox>
            <br />
            
            <asp:Label ID="acceptedLabel" runat="server" Text="accepted"></asp:Label>
            <asp:CheckBox ID="isAccepted" runat="server" />
            <br />

            <asp:Button ID="addPublicationBtn" runat="server" Text="add publication" OnClick ="addPublicationBtn_Click" />
        </div>
        <br />
        <hr />
        <br />
        <div>
            <asp:Label ID="Label1" runat="server" Font-Underline="true" Text="link your publication"></asp:Label>
            <br />
            <br />
            <asp:Label ID="pubIdLabel" runat="server" Text="Publication ID"></asp:Label><br />
            <asp:TextBox ID="pubIdText" runat="server" ></asp:TextBox>
            <br />
        
            <asp:Label ID="ThesisSerialNumLabel" runat="server" Text="Thesis serial number"></asp:Label><br />
            <asp:TextBox ID="ThesisSerialNumText" runat="server"></asp:TextBox>
            <br />


            <asp:Button ID="LinkPubBtn" runat="server" Text="Link publication" OnClick ="LinkPubBtn_Click" />
        </div>
    </form>
</body>
</html>
