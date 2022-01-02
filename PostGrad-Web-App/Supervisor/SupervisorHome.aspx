<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupervisorHome.aspx.cs" Inherits="PostGrad_Web_App.SupervisorHome" MasterPageFile="~/MainMaster.Master"%>

<asp:Content ID="childHead" ContentPlaceHolderID="head" runat="server">
    <title>Supervisor Home</title> 
    <link href="SupervisorHome.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />
</asp:Content>
<asp:Content ID="childBody" ContentPlaceHolderID="BodyPlaceHolder" runat="server">
        <div class = "d-flex justify-content-start align-items-start mb-3">
            <div class = "components">
                <asp:Label runat="server" Text="List my students"></asp:Label>
               
                <asp:Button class = "btn btn-dark" ID="Button1" runat="server" Text="See list" OnClick = "OnListStudents"/>
            </div>

          

            <div class = "components">
                <asp:Label runat="server" Text="View all publications of a student"></asp:Label>
                
                <asp:TextBox ID="PublicationsID" runat="server" placeholder = "Student ID"  TextMode = "Number"></asp:TextBox>
                <asp:Panel ID="PublicationsSuccess" runat="server"></asp:Panel>
                <asp:Button class = "btn btn-dark" ID="Button2" runat="server" Text="View list" OnClick ="OnViewPublications"/>
             </div>
            

            

            <div class = "components">
                <asp:Label runat="server" Text="Cancel Thesis"></asp:Label>
                <asp:TextBox ID="CancelThesisSerialNo" TextMode="Number" runat="server" placeholder = "Thesis Serial Number"></asp:TextBox>
               

                <asp:Panel ID="CancelSuccess" runat="server"></asp:Panel>
                <asp:Button class = "btn btn-dark" ID="Button7" runat="server" Text="Cancel Thesis" OnClick ="OnCancelThesis" />
            </div>
       </div>

        

        <div class = "d-flex justify-content-start">
            <div class = "components">
                <asp:Label runat="server" Text="Add a defense for a thesis"></asp:Label>
                
                <asp:TextBox ID="DefenseThesisSerialNumber" runat="server" placeholder = "Thesis Serial Number" TextMode = "Number"></asp:TextBox>
                
                <asp:Calendar ID="DefenseDateCalendar" runat="server"></asp:Calendar>

                <asp:TextBox ID="DefenseLocation" runat="server" placeholder = "Defense Location"></asp:TextBox>
            
                <asp:Panel ID="AddDefenseSuccess" runat="server"> </asp:Panel>
            
                
                <asp:Button class = "btn btn-dark" ID="Button3" runat="server" Text="Add Defense" OnClick = "OnAddDefense" />
            </div>

            

            <div class = "sections d-flex justify-content-center align-items-start">
                <div class = "d-flex flex-column h-auto components">
                    <asp:Label runat="server" Text="Add a new Examiner for the Defense"></asp:Label>

                    <asp:TextBox ID="ExaminerName" runat="server" placeholder = "Examiner Name"></asp:TextBox>
            
                    <asp:TextBox ID="Password" runat="server" placeholder = "Password"></asp:TextBox>

                    <div id = "isNationalDiv" class = "d-flex">
                        <asp:Label id = "isNationalSpan" runat="server" Text="isNational"></asp:Label>
                        <asp:CheckBox class = "checkboxSpan" ID="National" runat="server" />
                    </div>

                    <asp:TextBox ID="FieldOfWork" runat="server" placeholder = "Field Of Work"></asp:TextBox>
               
                    <asp:Panel ID="AddNewExaminerSuccess" runat="server"></asp:Panel>
                    <asp:Button class = "btn btn-dark" ID="Button4" runat="server" Text="Add New Examiner" OnClick ="OnAddExaminer" />
                </div>

                <asp:Panel class = "d-flex flex-column h-auto components" ID="Panel1" runat="server">
                    <asp:Label runat="server" Text="Add an Old Examiner for the Defense"></asp:Label>
                    <asp:TextBox ID="ExaminerID" runat="server" placeholder = "Examiner ID"  TextMode = "Number"></asp:TextBox>

                    <asp:Panel ID="ExistingExaminerSuccess" runat="server"></asp:Panel>
                    <asp:Button class = "btn btn-dark" ID="Button8" runat="server" Text="Add Existing Examiner" OnClick = "OnAddExistingExaminer" />
                </asp:Panel>
            </div>
        
             <div class = "components">
                <asp:Label runat="server" Text="Evaluate a progress report of a student"></asp:Label>
               

                <asp:TextBox ID="ThesisSerialNo" runat="server" TextMode="Number" placeholder = "Thesis Serial Number"></asp:TextBox>
              

                <asp:TextBox ID="ProgressReportNo" runat="server" TextMode="Number" placeholder = "Progress Report Number"></asp:TextBox>
            

                <asp:TextBox ID="Eval" runat="server" TextMode="Number" placeholder = "Evaluation"></asp:TextBox>
                   
                <asp:Panel ID="evaluateSuccess" runat="server"></asp:Panel>
          
                <asp:Button class = "btn btn-dark" ID="Button6" runat="server" Text="Evaluate Progress Report" OnClick ="OnEvaluate" />
            </div>
        </div>

        

</asp:Content>
