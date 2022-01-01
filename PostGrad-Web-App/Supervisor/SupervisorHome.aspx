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
            <asp:Button ID="Button1" runat="server" Text="See list" OnClick = "OnListStudents"/>
        </div>
        <br /> 
        <div>
            <asp:Label ID="Label2" runat="server" Text="View all publications of a student"></asp:Label>
            <br />
            <asp:TextBox ID="PublicationsID" runat="server" placeholder = "Student ID"></asp:TextBox>
            <br />
            <asp:Button ID="Button2" runat="server" Text="View list" OnClick ="OnViewPublications"/>
        </div>
        <br />
        <div>
            <asp:Label ID="Label3" runat="server" Text="Add a defense for a thesis"></asp:Label>
            <br />

            <asp:TextBox ID="DefenseThesisSerialNumber" runat="server" placeholder = "Thesis Serial Number"></asp:TextBox>
            <br />

            <asp:Label ID="Label5" runat="server" Text="Defense Date"></asp:Label>
            <asp:Calendar ID="DefenseDateCalendar" runat="server" OnSelectionChanged="DateChange"></asp:Calendar>
            <asp:TextBox ID="DefenseDate" runat="server" placeholder = "Defense Date"></asp:TextBox>
            <br />

            <asp:TextBox ID="DefenseLocation" runat="server" placeholder = "Defense Location"></asp:TextBox>
            
            <asp:Panel ID="AddDefenseSuccess" runat="server"> </asp:Panel>
            
            <br />
            <asp:Button ID="Button3" runat="server" Text="Add Defense" OnClick = "OnAddDefense" />
        </div>
        <br />
        <div>
            <asp:Label ID="Label7" runat="server" Text="Add Examiner for a Defense"></asp:Label>
            <br />

            <asp:TextBox ID="ExaminerName" runat="server" placeholder = "Examiner Name"></asp:TextBox>
            <br />

            
            <asp:TextBox ID="Password" runat="server" placeholder = "Password"></asp:TextBox>
            <br />

            <asp:TextBox ID="National" runat="server" placeholder = "National"></asp:TextBox>
            <br />

            <asp:TextBox ID="FieldOfWork" runat="server" placeholder = "Field Of Work"></asp:TextBox>
            <br />

            <asp:Button ID="Button4" runat="server" Text="Add New Examiner" OnClick ="OnAddExaminer" />
        </div>

        <asp:Panel ID="Panel1" runat="server">
                <asp:TextBox ID="ExaminerID" runat="server" placeholder = "Examiner ID"></asp:TextBox>
                <br />
                <asp:Panel ID="ExistingExaminerSuccess" runat="server"></asp:Panel>
                <asp:Button ID="Button8" runat="server" Text="Add Existing Examiner" OnClick = "OnAddExistingExaminer" />
        </asp:Panel>

        <br />

        <div>
            <asp:Label ID="Label14" runat="server" Text="Evaluate a progress report of a student"></asp:Label>
            <br />

            <asp:TextBox ID="ThesisSerialNo" runat="server" placeholder = "Thesis Serial Number"></asp:TextBox>
            <br />

            <asp:TextBox ID="ProgressReportNo" runat="server" placeholder = "Progress Report Number"></asp:TextBox>
            <br />

            <asp:TextBox ID="Eval" runat="server" placeholder = "Evaluation"></asp:TextBox>
            <br />        
            <asp:Panel ID="evaluateSuccess" runat="server"></asp:Panel>
          
            <asp:Button ID="Button6" runat="server" Text="Evaluate Progress Report" OnClick ="OnEvaluate" />
        </div>

        <br />
        <div>
            <asp:TextBox ID="CancelThesisSerialNo" runat="server" placeholder = "Thesis Serial Number"></asp:TextBox>
            <br />

            <asp:Panel ID="CancelSuccess" runat="server"></asp:Panel>
            <asp:Button ID="Button7" runat="server" Text="Cancel Thesis" OnClick ="OnCancelThesis" />
        </div>
    </form>
</body>
</html>
