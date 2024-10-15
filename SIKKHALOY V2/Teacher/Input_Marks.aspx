﻿<%@ Page Language="C#" MasterPageFile="~/Basic_Teacher.Master" AutoEventWireup="true" CodeBehind="Input_Marks.aspx.cs" Inherits="EDUCATION.COM.Teacher.Teacher_input" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/Input_Marks.css?v=3.1" rel="stylesheet" />
    <style>
        .floating {
            float: left;
            overflow: hidden;
        }
        .form-control {
  min-width: 80px;
  text-align: center;
}
           .EmptyRows { background-color: #f9d122; }

   .hide_Cont { color: #fff; margin-bottom: 15px; }
   .FullM { background-color: #0094ff; padding: 4px 0; }
   .PassM { background-color: #00bb93; padding: 4px 0; }
   .PassP { background-color: #efb700; padding: 4px 0; }

   .EroorSummer { font-size: 15px; }
   .SuccessMsg { font-size: 15px; color: #32b000; }
   .mGrid tr:nth-child(even) { background: #eee; }
   .mGrid tr:nth-child(odd) { background: #fff; }
   .blockmsg{
       background-color:bisque;
       color:red;
       padding:10px;
       

   }
        .fmpmp {
            font-size:10px;
            font-style:italic;
        }
.mGrid td {
  padding-top:0 !important;
  border: 1px solid #dee2e6;
  color: #000;
  font-size: .9rem;
  font-weight: 300;
}    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel ID="ContainUpdatePanel" runat="server">
        <ContentTemplate>
            
            <h3>Student's Exam Marks (Input/Modify) TotalStudent : <asp:Label runat="server" ID="totalStudent"></asp:Label></h3>
           
            <div id="lockmsgId" runat="server" class="blockmsg">
                <asp:Label runat="server" ID="lockedMessage"></asp:Label>
            </div>
            <br />
            <div class=" form-inline d-print-none">
                <div class="form-group">
                    <asp:DropDownList ID="ExamDropDownList" runat="server" AutoPostBack="True" CssClass="form-control" DataSourceID="ExamSQL" DataTextField="ExamName" DataValueField="ExamID" OnSelectedIndexChanged="ExamDropDownList_SelectedIndexChanged" AppendDataBoundItems="True">
                        <asp:ListItem Value="0">[ SELECT ]</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="ExamSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT ExamID, ExamName FROM Exam_Name WHERE (SchoolID = @SchoolID) AND (EducationYearID = @EducationYearID)">
                        <SelectParameters>
                            <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
                            <asp:SessionParameter Name="EducationYearID" SessionField="Edu_Year" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ExamDropDownList" CssClass="EroorSummer" ErrorMessage="Select Exam" InitialValue="0" ValidationGroup="1">*</asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:DropDownList ID="ClassDropDownList" runat="server" CssClass="form-control" AutoPostBack="True" DataSourceID="ClassNameSQL" DataTextField="Class" DataValueField="ClassID" OnSelectedIndexChanged="ClassDropDownList_SelectedIndexChanged" OnDataBound="ClassDropDownList_DataBound">
                        <asp:ListItem Value="0">[ SELECT CLASS ]</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="ClassNameSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT DISTINCT CreateClass.Class, CreateClass.SN, CreateClass.ClassID FROM CreateClass INNER JOIN Exam_Full_Marks ON CreateClass.ClassID = Exam_Full_Marks.ClassID INNER JOIN TecherSubject ON CreateClass.ClassID = TecherSubject.ClassID WHERE (CreateClass.SchoolID = @SchoolID) AND (Exam_Full_Marks.EducationYearID = @EducationYearID) AND (Exam_Full_Marks.ExamID = @ExamID) AND (TecherSubject.TeacherID = @TeacherID) ORDER BY CreateClass.SN">
                        <SelectParameters>
                            <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
                            <asp:SessionParameter Name="EducationYearID" SessionField="Edu_Year" />
                            <asp:ControlParameter ControlID="ExamDropDownList" Name="ExamID" PropertyName="SelectedValue" />
                            <asp:SessionParameter Name="TeacherID" SessionField="TeacherID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ClassDropDownList" CssClass="EroorStar" ErrorMessage="Select class" Text="*" InitialValue="0" ValidationGroup="In_Exm">*</asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <asp:DropDownList ID="GroupDropDownList" runat="server" CssClass="form-control" AutoPostBack="True" DataSourceID="GroupSQL" DataTextField="SubjectGroup" DataValueField="SubjectGroupID" OnDataBound="GroupDropDownList_DataBound" OnSelectedIndexChanged="GroupDropDownList_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="GroupSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT DISTINCT [Join].SubjectGroupID, CreateSubjectGroup.SubjectGroup FROM [Join] INNER JOIN CreateSubjectGroup ON [Join].SubjectGroupID = CreateSubjectGroup.SubjectGroupID WHERE ([Join].ClassID = @ClassID) AND ([Join].SectionID LIKE @SectionID) AND ([Join].ShiftID LIKE  @ShiftID) ">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ClassDropDownList" Name="ClassID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="SectionDropDownList" Name="SectionID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ShiftDropDownList" Name="ShiftID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>

                <div class="form-group">
                    <asp:DropDownList ID="SectionDropDownList" runat="server" CssClass="form-control" DataSourceID="SectionSQL" DataTextField="Section" DataValueField="SectionID" AutoPostBack="True" OnDataBound="SectionDropDownList_DataBound" OnSelectedIndexChanged="SectionDropDownList_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SectionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT DISTINCT [Join].SectionID, CreateSection.Section FROM [Join] INNER JOIN CreateSection ON [Join].SectionID = CreateSection.SectionID WHERE ([Join].ClassID = @ClassID) AND ([Join].SubjectGroupID LIKE @SubjectGroupID) AND ([Join].ShiftID LIKE @ShiftID) ">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ClassDropDownList" Name="ClassID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GroupDropDownList" Name="SubjectGroupID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ShiftDropDownList" Name="ShiftID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>

                <div class="form-group">
                    <asp:DropDownList ID="ShiftDropDownList" runat="server" AutoPostBack="True" CssClass="form-control" DataSourceID="ShiftSQL" DataTextField="Shift" DataValueField="ShiftID" OnDataBound="ShiftDropDownList_DataBound" OnSelectedIndexChanged="ShiftDropDownList_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="ShiftSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT DISTINCT [Join].ShiftID, CreateShift.Shift FROM [Join] INNER JOIN CreateShift ON [Join].ShiftID = CreateShift.ShiftID WHERE ([Join].SubjectGroupID LIKE @SubjectGroupID) AND ([Join].SectionID LIKE  @SectionID) AND ([Join].ClassID = @ClassID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="GroupDropDownList" Name="SubjectGroupID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="SectionDropDownList" Name="SectionID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ClassDropDownList" Name="ClassID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>

                <div class="form-group">
                    <asp:DropDownList ID="SubjectDropDownList" runat="server" AutoPostBack="True" CssClass="form-control" DataSourceID="SubjectSQL" DataTextField="SubjectName" DataValueField="SubjectID" OnDataBound="SubjectDropDownList_DataBound" OnSelectedIndexChanged="SubjectDropDownList_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SubjectSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT DISTINCT Subject.SubjectID, Subject.SubjectName FROM Subject INNER JOIN StudentRecord ON Subject.SubjectID = StudentRecord.SubjectID INNER JOIN StudentsClass ON StudentRecord.StudentClassID = StudentsClass.StudentClassID INNER JOIN Student ON StudentsClass.StudentID = Student.StudentID INNER JOIN TecherSubject ON Subject.SubjectID = TecherSubject.SubjectID AND StudentsClass.ClassID = TecherSubject.ClassID WHERE (StudentsClass.EducationYearID = @EducationYearID) AND (StudentsClass.ClassID = @ClassID) AND (StudentsClass.SchoolID = @SchoolID) AND (Student.Status = N'Active') AND (StudentsClass.SubjectGroupID LIKE @SubjectGroupID) AND (TecherSubject.TeacherID = @TeacherID)">
                        <SelectParameters>
                            <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
                            <asp:SessionParameter Name="EducationYearID" SessionField="Edu_Year" />
                            <asp:ControlParameter ControlID="ClassDropDownList" Name="ClassID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GroupDropDownList" Name="SubjectGroupID" PropertyName="SelectedValue" />
                            <asp:SessionParameter Name="TeacherID" SessionField="TeacherID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="SubjectDropDownList" CssClass="EroorStar" ErrorMessage="Select subject" InitialValue="0" ValidationGroup="1">*</asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <asp:DropDownList ID="SubExamDownList" runat="server" AutoPostBack="True" CssClass="form-control" DataSourceID="SubExamSQL" DataTextField="SubExamName" DataValueField="SubExamID" OnDataBound="SubExamDownList_DataBound" Visible="False" OnSelectedIndexChanged="SubExamDownList_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SubExamSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT Exam_SubExam_Name.SubExamID, Exam_SubExam_Name.SubExamName FROM Exam_SubExam_Name INNER JOIN Exam_Full_Marks ON Exam_SubExam_Name.SubExamID = Exam_Full_Marks.SubExamID WHERE (Exam_Full_Marks.SubjectID = @SubjectID) AND (Exam_Full_Marks.ClassID = @ClassID) AND (Exam_SubExam_Name.SchoolID = @SchoolID) AND (Exam_Full_Marks.ExamID = @ExamID) AND (Exam_Full_Marks.EducationYearID = @EducationYearID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="SubjectDropDownList" Name="SubjectID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ClassDropDownList" Name="ClassID" PropertyName="SelectedValue" />
                            <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
                            <asp:SessionParameter Name="EducationYearID" SessionField="Edu_Year" />
                            <asp:ControlParameter ControlID="ExamDropDownList" Name="ExamID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>                    
                </div>
                  <div class="form-group">
                    <asp:Button ID="ShowStudentButton" runat="server" CssClass="btn btn-primary" OnClick="ShowStudentButton_Click" Text="Show Student" ValidationGroup="1" />
                </div>
               
            </div>

            <asp:FormView ID="FmPmFormView" CssClass="hide_Cont" runat="server" DataKeyNames="FullMark,PassMark,PassPercentage" DataSourceID="PassMarkFullMarkSQL" Width="100%" Visible="False">
                <ItemTemplate>
                    <div class="row no-gutters text-center">
                        <div class="col-sm-4">
                            <div class="FullM">
                                Full Mark: <%# Eval("FullMark") %>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="PassM">
                                Pass Mark: <%# Eval("PassMark") %>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="PassP">
                                Pass Percentage: <%# Eval("PassPercentage") %> %
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="PassMarkFullMarkSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT Sub_PassMarks AS PassMark, FullMarks AS FullMark, ROUND(Sub_PassMarks * 100 / FullMarks, 2, 0) AS PassPercentage FROM Exam_Full_Marks WHERE (SchoolID = @SchoolID) AND (SubjectID = @SubjectID) AND (ExamID = @ExamID) AND (ClassID = @ClassID) AND (SubExamID = @SubExamID OR @SubExamID = 0) AND (EducationYearID = @EducationYearID)">
                <SelectParameters>
                    <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
                    <asp:ControlParameter ControlID="SubjectDropDownList" DefaultValue="" Name="SubjectID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="ExamDropDownList" DefaultValue="" Name="ExamID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="ClassDropDownList" DefaultValue="" Name="ClassID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter DefaultValue="" Name="SubExamID" Type="Int32" />
                    <asp:SessionParameter Name="EducationYearID" SessionField="Edu_Year" />
                </SelectParameters>
            </asp:SqlDataSource>

            <div class="table-responsive mb-3">
                <asp:CheckBox CssClass="showHideName" ID="StudentsNameCheckbox" Text="Hide Student Name" runat="server" AutoPostBack="True" OnCheckedChanged="StudentsNameCheckbox_CheckedChanged" />
                <asp:GridView ID="StudentsGridView" runat="server" AlternatingRowStyle-CssClass="alt" AutoGenerateColumns="false" CssClass="mGrid" DataSourceID="ShowStudentClassSQL" DataKeyNames="StudentID,StudentClassID" OnRowDataBound="StudentsGridView_RowDataBound" Visible="False" AllowSorting="True" Width="100%">
                    <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
                        <asp:BoundField DataField="StudentsName" HeaderText="Name" SortExpression="StudentsName" />
                        <%--<asp:BoundField DataField="FathersName" HeaderText="Father's Name" SortExpression="FathersName" />--%>
                        <asp:BoundField DataField="RollNo" HeaderText="Roll No." SortExpression="RollNo" />

                        <asp:TemplateField HeaderText="Obtain Marks">
                            <ItemTemplate>

                                <!-------Data list-------->

                                <table style="width: 100%; padding: 0">
                                    <tr>
                                        <asp:DataList ID="SubExamlDataList" runat="server" DataSourceID="SubExamSQL1" RepeatDirection="Horizontal" RepeatLayout="Flow"
                                            Width="100%">
                                            <ItemTemplate>
                                                <td>
                                                    <table style="width:100%;padding:0">
                                                        <tr style="background-color: #d6e1f4;padding:0">
                                                            <td colspan="2" style="border-bottom: solid 1px brown;padding:0"><b style="font-size: 16px; color: brown;"><%# Eval("SubExamName") %></b>

                                                                <br />


                                                                <b style="color: brown;font-size: 10px;">FM:</b><asp:Label ID="lblFullMarks" Text='<%# Eval("FullMarks ") %>' runat="server" CssClass="fmpmp"></asp:Label>
                                                                <b style="color: brown;font-size: 10px; padding-left:10px;">PM:</b><asp:Label ID="labelPassMark" Text='<%# Eval("Sub_PassMarks ") %>' runat="server" CssClass="fmpmp"></asp:Label>
                                                                <b style="color: brown; padding-left:10px;font-size: 10px;">Pass %:</b><asp:Label ID="labelParcentage" Text='<%# Eval("PassPercentage ") %>' runat="server" CssClass="fmpmp"></asp:Label>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td>
                                                                <asp:TextBox Type="number" step="any" ID="MarksTextBox" runat="server" CssClass="InputVibl form-control" autocomplete="off" onDrop="blur();return false;" onpaste="return false" onkeypress="return isNumberKey(event)"></asp:TextBox></td>
                                                            <td>
                                                                <asp:CheckBox ID="AbsenceCheckBox" runat="server" Text="Abs" /></td>
                                                        </tr>

                                                    </table>
                                                    <%--<asp:Label runat="server" ID="subexamID" Text='<%# Eval("SubExamID") %>'></asp:Label>--%>

                                                    <asp:HiddenField ID="subexamID" runat="server" Value='<%# Eval("SubExamID") %>' />

                                                </td>
                                                <td>
     
                                                </td>

                                            </ItemTemplate>
                                        </asp:DataList>
                                    </tr>
                                </table>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Obtain Marks">
                            <ItemTemplate>
                                <asp:TextBox Type="number" step="any" ID="MarksTextBox" runat="server" CssClass="InputVibl form-control" autocomplete="off" onDrop="blur();return false;" onpaste="return false" onkeypress="return isNumberKey(event)"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Absence">
                            <ItemTemplate>
                                <asp:CheckBox ID="AbsenceCheckBox" runat="server" Text=" " />
                            </ItemTemplate>
                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle CssClass="pgr" />
                </asp:GridView>
                <asp:SqlDataSource ID="ShowStudentClassSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT Student.StudentsName, Student.FathersName, StudentsClass.StudentID, StudentsClass.StudentClassID, Student.ID, StudentsClass.RollNo FROM StudentsClass INNER JOIN Student ON StudentsClass.StudentID = Student.StudentID INNER JOIN StudentRecord ON StudentsClass.StudentClassID = StudentRecord.StudentClassID WHERE (StudentsClass.ClassID = @ClassID) AND (StudentsClass.SectionID LIKE @SectionID) AND (StudentsClass.SubjectGroupID LIKE @SubjectGroupID) AND (StudentsClass.EducationYearID = @EducationYearID) AND (StudentRecord.SubjectID = @SubjectID) AND (StudentsClass.ShiftID LIKE @ShiftID) AND (StudentsClass.SchoolID = @SchoolID) AND (Student.Status = N'Active')  
                ORDER BY CASE WHEN ISNUMERIC(StudentsClass.RollNo) = 1 THEN CAST(REPLACE(REPLACE(StudentsClass.RollNo, '$', ''), ',', '') AS INT) ELSE 0 END">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ClassDropDownList" Name="ClassID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="SectionDropDownList" Name="SectionID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="GroupDropDownList" Name="SubjectGroupID" PropertyName="SelectedValue" />
                        <asp:SessionParameter Name="EducationYearID" SessionField="Edu_Year" />
                        <asp:ControlParameter ControlID="SubjectDropDownList" Name="SubjectID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="ShiftDropDownList" Name="ShiftID" PropertyName="SelectedValue" />
                        <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="SubExamSQL1" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT Exam_SubExam_Name.SubExamID, Exam_SubExam_Name.SubExamName,Exam_Full_Marks.FullMarks,Exam_Full_Marks.Sub_PassMarks, ROUND(Exam_Full_Marks.Sub_PassMarks * 100 / Exam_Full_Marks.FullMarks, 2, 0) AS PassPercentage FROM Exam_SubExam_Name INNER JOIN Exam_Full_Marks ON Exam_SubExam_Name.SubExamID = Exam_Full_Marks.SubExamID WHERE (Exam_Full_Marks.SubjectID = @SubjectID) AND (Exam_Full_Marks.ClassID = @ClassID) AND (Exam_SubExam_Name.SchoolID = @SchoolID) AND (Exam_Full_Marks.ExamID = @ExamID) AND (Exam_Full_Marks.EducationYearID = @EducationYearID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="SubjectDropDownList" Name="SubjectID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="ClassDropDownList" Name="ClassID" PropertyName="SelectedValue" />
                        <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
                        <asp:SessionParameter Name="EducationYearID" SessionField="Edu_Year" />
                        <asp:ControlParameter ControlID="ExamDropDownList" Name="ExamID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="FullMarksSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT Sub_PassMarks AS PassMark, FullMarks AS FullMark, ROUND(Sub_PassMarks * 100 / FullMarks, 2, 0) AS PassPercentage FROM Exam_Full_Marks WHERE (SchoolID = @SchoolID) AND (SubjectID = @SubjectID) AND (ExamID = @ExamID) AND (ClassID = @ClassID)  AND (EducationYearID = @EducationYearID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
                        <asp:ControlParameter ControlID="SubjectDropDownList" DefaultValue="" Name="SubjectID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ExamDropDownList" DefaultValue="" Name="ExamID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ClassDropDownList" DefaultValue="" Name="ClassID" PropertyName="SelectedValue" Type="Int32" />
                        <%--<asp:Parameter DefaultValue="" Name="SubExamID" Type="Int32" />--%>
                        <asp:SessionParameter Name="EducationYearID" SessionField="Edu_Year" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </div>
            <div class="hide_Cont">
                <div class="alert alert-warning NoPrint">After Marks Input Or Existing Marks Change, You have to Publish Result</div>
                <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" OnClick="SubmitButton_Click" Text="Submit" ValidationGroup="1" Visible="False" />
                <label id="ErMsg" class="EroorSummer"></label>
                <label id="SuccMsg" class="SuccessMsg"></label>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="1" />
            </div>

            <asp:SqlDataSource ID="Exam_Result_of_StudentSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" InsertCommand="Exam_Mark_Submit" SelectCommand="SELECT * FROM [Exam_Result_of_Student]" InsertCommandType="StoredProcedure">
                <InsertParameters>
                    <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
                    <asp:SessionParameter Name="EducationYearID" SessionField="Edu_Year" />
                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" />
                    <asp:ControlParameter ControlID="ClassDropDownList" Name="ClassID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="ExamDropDownList" Name="ExamID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="SubjectDropDownList" Name="SubjectID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter Name="StudentID" Type="Int32" />
                    <asp:Parameter Name="SubExamID" Type="Int32" />
                    <asp:Parameter Name="MarksObtained" Type="Double" />
                    <asp:Parameter Name="AbsenceStatus" Type="String" />
                    <asp:Parameter Name="FullMark" Type="Double" />
                    <asp:Parameter Name="PassPercentage" Type="Double" />
                    <asp:Parameter Name="PassMark" Type="Double" />
                </InsertParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdateProgress ID="UpdateProgress" runat="server">
        <ProgressTemplate>
            <div id="progress_BG"></div>
            <div id="progress">
                <img src="../CSS/loading.gif" alt="Loading..." />
                <br />
                <b>Loading...</b>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <script type="text/javascript">
        //GridView is empty
        $("#locked > label").remove();

        if (!$('[id*=StudentsGridView] tr').length) {
            $(".hide_Cont").hide();
            $(".showHideName").hide();
        }

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (a, b) {
            //show hide name click
            $("[id*=StudentsNameCheckbox]").click(function () {
                var isChecked = $(this).is(":checked");
                 
            });

            //On load
            var tr = $("[id*=StudentsGridView] tr").hasClass("aspNetDisabled");
            if (!tr) {
                $(":checkbox").each(function () {
                    $(this).parents("tr:eq(0)").find(".InputVibl").prop("disabled", this.checked);
                });
            } else {
                $("#locked").append('<label class="alert alert-danger m-0 d-block">Marks Input Locked</label>');
            }

         /*   on checked*/
            //var isChecked = $("[id*=StudentsNameCheckbox]").is(":checked");
            //if (isChecked) {
            //    var tr = $("[id*=StudentsGridView] th:contains('Name')");
            //    th.css("display", isChecked ? "none" : "");
            //    $("[id*=StudentsGridView] tr").each(function () {
            //        $(this).find("td").eq(tr.index()).css("display", isChecked ? "none" : "");
            //    });
            //}


            if ($('[id*=StudentsGridView] tr').length) {
                //Count Student

                /*$('#Total_Student').text("Total Student: " + $("[id*=StudentsGridView]").closest("tr").length);*/

               

                //On load
                $(":checkbox").each(function () {
                    $(this).parents("tr:eq(0)").find(".InputVibl").prop("disabled", this.checked);
                });

                //On click
                $(":checkbox").on('click', function () {
                    $(this).parents("tr:eq(0)").find(".InputVibl").prop("disabled", this.checked).val('');
                });
            }
            else {
                $(".hide_Cont").hide();
                $(".showHideName").hide();
            }

            window.onbeforeunload = DisableButton;
        });

        function checkchanged(obj) {
            alert(obj.checked)
        }

        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };

        function DisableButton() {
            $('[id*=SubmitButton]').disabled = !0;
        }

        function Success() {
            var e = $('#SuccMsg');
            e.text("Exam Marks inputed successfully!!");
            e.fadeIn();
            e.queue(function () { setTimeout(function () { e.dequeue() }, 4000) });
            e.fadeOut('slow');
        }

    
    </script>
</asp:Content>