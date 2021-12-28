<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupervisorHome.aspx.cs" Inherits="PostGrad_Web_App.SupervisorHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="height: 229px">
    <form id="form2" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="List my students"></asp:Label>
            <br />
            <asp:Button ID="Button1" runat="server" Text="See list" />
        </div>
        <br />
        <div>
            <asp:Label ID="Label2" runat="server" Text="View all publications of a student"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button2" runat="server" Text="View list" />
        </div>
        <br />
        <div>
            <asp:Label ID="Label3" runat="server" Text="Add a defense for a thesis"></asp:Label>
            <br />

            <asp:Label ID="Label4" runat="server" Text="Thesis Serial Number"></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="Label5" runat="server" Text="Defense Date"></asp:Label>
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="Label6" runat="server" Text="Defense Location"></asp:Label>
            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
            
            <br />
            <asp:Button ID="Button3" runat="server" Text="Add Defense" />
        </div>
        <br />
        <div>
            <asp:Label ID="Label7" runat="server" Text="Add Examiner for a Defense"></asp:Label>
            <br />

            <asp:Label ID="Label8" runat="server" Text="Thesis Serial Number"></asp:Label>
            <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="Label9" runat="server" Text="Defense Date"></asp:Label>
            <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="Label10" runat="server" Text="Examiner Name"></asp:Label>
            <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="Label11" runat="server" Text="Password"></asp:Label>
            <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="Label12" runat="server" Text="National"></asp:Label>
            <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="Label13" runat="server" Text="Field of Work"></asp:Label>
            <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox>
            <br />

            <asp:Button ID="Button4" runat="server" Text="Add Examiner" />
        </div>
        <br />

        <div>
            <asp:Label ID="Label14" runat="server" Text="Evaluate a progress report of a student"></asp:Label>
            <br />

            <asp:Label ID="ThesisSerialNoLabel" runat="server" Text="Thesis Serial Number"></asp:Label>
            <asp:TextBox ID="ThesisSerialNo" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="ProgressReportNoLabel" runat="server" Text="Progress Report Number"></asp:Label>
            <asp:TextBox ID="ProgressReportNo" runat="server"></asp:TextBox>
            <br />

            <asp:Label ID="EvalLabel" runat="server" Text="Evaluation"></asp:Label>
            <asp:TextBox ID="Eval" runat="server"></asp:TextBox>
            <br />

            <asp:Button ID="Button6" runat="server" Text="Evaluate Progress Report" OnClick ="OnEvaluate" />
        </div>

        <br />
        <div>
            <asp:Label ID="Label18" runat="server" Text="Thesis Serial Number"></asp:Label>
            <asp:TextBox ID="TextBox14" runat="server"></asp:TextBox>
            <br />

            <asp:Button ID="Button7" runat="server" Text="Cancel Thesis" />
        </div>
    </form>
</body>
</html>
