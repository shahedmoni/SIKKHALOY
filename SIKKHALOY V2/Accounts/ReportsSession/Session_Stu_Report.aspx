﻿<%@ Page Title="Student based payorder" Language="C#" MasterPageFile="~/BASIC.Master" AutoEventWireup="true" CodeBehind="Session_Stu_Report.aspx.cs" Inherits="EDUCATION.COM.Accounts.ReportsSession.Session_Stu_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/Session_Student.css?v=2" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3 class="mb-2">Student based payorder report <small class="Date"></small></h3>
    <label class="Class_Section"></label>

    <div class="form-inline NoPrint">
        <div class="form-group">
            <asp:DropDownList ID="Session_DropDownList" CssClass="form-control" runat="server" DataSourceID="All_SessionSQL" DataTextField="EducationYear" DataValueField="EducationYearID" AutoPostBack="True">
            </asp:DropDownList>
            <asp:SqlDataSource ID="All_SessionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT * FROM [Education_Year] WHERE ([SchoolID] = @SchoolID)">
                <SelectParameters>
                    <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>

        <div class="form-group">
            <asp:DropDownList ID="ClassDropDownList" runat="server" AutoPostBack="True" CssClass="form-control" DataSourceID="ClassNameSQL" DataTextField="Class" DataValueField="ClassID" OnDataBound="ClassDropDownList_DataBound">
            </asp:DropDownList>
            <asp:SqlDataSource ID="ClassNameSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT DISTINCT CreateClass.ClassID, CreateClass.Class FROM CreateClass INNER JOIN Income_PayOrder ON CreateClass.ClassID = Income_PayOrder.ClassID WHERE (Income_PayOrder.SchoolID = @SchoolID) AND (Income_PayOrder.EducationYearID = @EducationYearID) ORDER BY CreateClass.ClassID">
                <SelectParameters>
                    <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
                    <asp:ControlParameter ControlID="Session_DropDownList" Name="EducationYearID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>

        <div class="form-group S_Show" style="display: none">
            <asp:DropDownList ID="SectionDropDownList" runat="server" AutoPostBack="True" CssClass="form-control" DataSourceID="SectionSQL" DataTextField="Section" DataValueField="SectionID" OnDataBound="SectionDropDownList_DataBound">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SectionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT DISTINCT CreateSection.Section, CreateSection.SectionID FROM StudentsClass INNER JOIN Income_PayOrder ON StudentsClass.StudentClassID = Income_PayOrder.StudentClassID INNER JOIN CreateSection ON StudentsClass.SectionID = CreateSection.SectionID WHERE (Income_PayOrder.Is_Active = 1) AND (StudentsClass.SchoolID = @SchoolID) AND (StudentsClass.EducationYearID = @EducationYearID) AND (StudentsClass.ClassID = @ClassID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ClassDropDownList" Name="ClassID" PropertyName="SelectedValue" />
                    <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
                    <asp:ControlParameter ControlID="Session_DropDownList" Name="EducationYearID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>

        <div class="form-group">
            <asp:DropDownList ID="RoleDropDownList" runat="server" DataSourceID="RoleSQL" DataTextField="Role" DataValueField="RoleID" CssClass="form-control" AutoPostBack="True" OnDataBound="RoleDropDownList_DataBound">
            </asp:DropDownList>
            <asp:SqlDataSource ID="RoleSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT DISTINCT Income_Roles.Role, Income_Roles.RoleID FROM Income_PayOrder INNER JOIN Income_Roles ON Income_PayOrder.RoleID = Income_Roles.RoleID WHERE (Income_PayOrder.SchoolID = @SchoolID) AND (Income_PayOrder.EducationYearID = @EducationYearID) AND (Income_PayOrder.ClassID =@ClassID OR @ClassID = 0 )" CancelSelectOnNullParameter="False">
                <SelectParameters>
                    <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
                    <asp:SessionParameter Name="EducationYearID" SessionField="Edu_Year" />
                    <asp:ControlParameter ControlID="ClassDropDownList" Name="ClassID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>

        <div class="form-group">
            <asp:TextBox ID="FromDateTextBox" placeholder="From Date" runat="server" autocomplete="off" CssClass="form-control datepicker" onDrop="blur();return false;" onkeypress="return isNumberKey(event)" onpaste="return false"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:TextBox ID="ToDateTextBox" placeholder="To Date" runat="server" CssClass="form-control datepicker" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" Text="Find" ValidationGroup="1" />
        </div>
    </div>

    <asp:FormView ID="Sessi_Student_FormView" runat="server" DataSourceID="Stu_P_SQL" Width="100%">
        <ItemTemplate>
            <div id="Print-Set" class="row">
                <div class="col-lg-2 col-md-4">
                    <div class="Fees-section Student-bg">
                        <div class="tile-description">Student</div>
                        <div class="tile-number"><%#Eval("Total_Stu") %></div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <div class="Fees-section Payorder-bg">
                        <div class="tile-description">Payorder</div>
                        <div class="tile-number"><%#Eval("TotalFee","{0:N0}") %> Tk</div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <div class="Fees-section Late-Fee-bg">
                        <div class="tile-description">Late Fee</div>
                        <div class="tile-number"><%#Eval("TotalLateFee","{0:N0}")%> Tk</div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <asp:LinkButton ID="ConcessionLinkButton" runat="server" OnClick="ConcessionLinkButton_Click">
                      <div class="Fees-section Concession-bg">
                     <div class="tile-description">Concession <i class="fa fa-caret-right"></i></div>
                     <div class="tile-number"><%#Eval("TotalDiscount","{0:N0}") %> Tk</div>
                  </div>
                    </asp:LinkButton>
                </div>
                <div class="col-lg-2 col-md-4">
                    <asp:LinkButton ID="PaidLinkButton" runat="server" OnClick="Paid_LB_Click">
                      <div class="Fees-section Paid-bg">
                     <div class="tile-description">Paid <i class="fa fa-caret-right"></i></div>
                     <div class="tile-number"><%#Eval("TotalPaid","{0:N0}") %> Tk</div>
                  </div>
                    </asp:LinkButton>
                </div>
                <div class="col-lg-2 col-md-4">
                    <asp:LinkButton ID="DueLinkButton" runat="server" OnClick="Unpaid_LB_Click">
                       <div class="Fees-section Unpaid-bg">
                     <div class="tile-description">Unpaid <i class="fa fa-caret-right"></i></div>
                     <div class="tile-number"><%#Eval("Unpaid","{0:N0}") %> Tk</div>
                  </div>
                    </asp:LinkButton>
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="Stu_P_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT        COUNT(DISTINCT Income_PayOrder.StudentID) AS Total_Stu, SUM(Income_PayOrder.Amount) AS TotalFee, SUM(Income_PayOrder.LateFeeCountable) AS TotalLateFee, 
                         SUM(Income_PayOrder.LateFeeCountable + ISNULL(Income_PayOrder.Discount, 0)) AS TotalDiscount, SUM(ISNULL(Income_PayOrder.PaidAmount, 0)) AS TotalPaid, SUM(Income_PayOrder.Receivable_Amount) 
                         AS Unpaid
FROM            Income_PayOrder INNER JOIN
                         StudentsClass ON Income_PayOrder.StudentClassID = StudentsClass.StudentClassID
WHERE        (Income_PayOrder.SchoolID = @SchoolID) AND 
             (Income_PayOrder.EducationYearID = @EducationYearID) AND 
			 (Income_PayOrder.Is_Active = 1) AND 
			 (Income_PayOrder.EndDate BETWEEN ISNULL(@From_Date, '1-1-1000') AND ISNULL(@To_Date, '1-1-3000')) and 
			 (Income_PayOrder.RoleID like @RoleID) AND 
			 (Income_PayOrder.ClassID = @ClassID or @ClassID = 0) AND 
			 (ISNULL(StudentsClass.SectionID, N'0')  LIKE @SectionID)"
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
            <asp:ControlParameter ControlID="Session_DropDownList" Name="EducationYearID" PropertyName="SelectedValue" />
            <asp:ControlParameter Name="From_Date" ControlID="FromDateTextBox" PropertyName="Text" />
            <asp:ControlParameter ControlID="ToDateTextBox" Name="To_Date" PropertyName="Text" />
            <asp:ControlParameter ControlID="ClassDropDownList" Name="ClassID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="SectionDropDownList" Name="SectionID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="RoleDropDownList" Name="RoleID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>


    <div class="table-responsive">
        <asp:GridView ID="StudentDetailsGV" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="StudentDetailsSQL" AllowSorting="True" AllowPaging="True" PageSize="100">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
                <asp:BoundField DataField="StudentsName" HeaderText="Name" SortExpression="StudentsName" />
                <asp:BoundField DataField="Class" HeaderText="Class" SortExpression="Class" />
                <asp:BoundField DataField="RollNo" HeaderText="Roll" SortExpression="RollNo" />
                <asp:BoundField DataField="TotalFee" HeaderText="Fee" ReadOnly="True" SortExpression="TotalFee" />
                <asp:BoundField DataField="TotalLateFee" HeaderText="Late Fee" ReadOnly="True" SortExpression="TotalLateFee" />
                <asp:BoundField DataField="TotalDiscount" HeaderText="Concession" ReadOnly="True" SortExpression="TotalDiscount" />
                <asp:BoundField DataField="TotalPaid" HeaderText="Paid" ReadOnly="True" SortExpression="TotalPaid" />
                <asp:BoundField DataField="Unpaid" HeaderText="Unpaid" ReadOnly="True" SortExpression="Unpaid" />
            </Columns>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
        <asp:SqlDataSource ID="StudentDetailsSQL" runat="server" ConnectionString="<%$ ConnectionStrings:EducationConnectionString %>" SelectCommand="SELECT        Income_PayOrder.StudentID, Income_PayOrder.ClassID, Student.ID, Student.StudentsName, CreateClass.Class, StudentsClass.RollNo, SUM(Income_PayOrder.Amount) AS TotalFee, 
                         SUM(Income_PayOrder.LateFeeCountable) AS TotalLateFee, SUM(Income_PayOrder.LateFeeCountable + ISNULL(Income_PayOrder.Discount, 0)) AS TotalDiscount, SUM(ISNULL(Income_PayOrder.PaidAmount, 0)) 
                         AS TotalPaid, SUM(Income_PayOrder.Receivable_Amount) AS Unpaid
FROM            Income_PayOrder INNER JOIN
                         StudentsClass ON Income_PayOrder.StudentClassID = StudentsClass.StudentClassID INNER JOIN
                         Student ON Income_PayOrder.StudentID = Student.StudentID INNER JOIN
                         CreateClass ON StudentsClass.ClassID = CreateClass.ClassID
WHERE        (Income_PayOrder.SchoolID = @SchoolID) AND (Income_PayOrder.EducationYearID = @EducationYearID) AND (Income_PayOrder.Is_Active = 1) AND (Income_PayOrder.EndDate BETWEEN ISNULL(@From_Date, 
                         '1-1-1000') AND ISNULL(@To_Date, '1-1-3000')) and Income_PayOrder.RoleID like @RoleID AND (Income_PayOrder.ClassID = @ClassID or @ClassID = 0) AND StudentsClass.SectionID LIKE @SectionID
GROUP BY CreateClass.Class, Student.StudentsName, Student.ID, Income_PayOrder.StudentID, Income_PayOrder.ClassID, StudentsClass.RollNo
ORDER BY Income_PayOrder.ClassID, StudentsClass.RollNo"
            CancelSelectOnNullParameter="False">
            <SelectParameters>
                <asp:SessionParameter Name="SchoolID" SessionField="SchoolID" />
                <asp:ControlParameter ControlID="Session_DropDownList" Name="EducationYearID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="FromDateTextBox" Name="From_Date" PropertyName="Text" />
                <asp:ControlParameter ControlID="ToDateTextBox" Name="To_Date" PropertyName="Text" />
                <asp:ControlParameter ControlID="RoleDropDownList" Name="RoleID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ClassDropDownList" Name="ClassID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="SectionDropDownList" Name="SectionID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>


    <script type="text/javascript">
        $(function () {
            $('.datepicker').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });


            var Class = "";
            if ($('[id*=ClassDropDownList] :selected').index() > 0) {
                Class = "Class: " + $('[id*=ClassDropDownList] :selected').text() + ".";
            }

            var Section = "";
            if ($('[id*=SectionDropDownList] :selected').index() > 0) {
                Section = " Section: " + $('[id*=SectionDropDownList] :selected').text() + ".";
            }

            var PaymentRole = "";
            if ($('[id*=RoleDropDownList] :selected').index() > 0) {
                PaymentRole = " Payment Role : " + $('[id*=RoleDropDownList] :selected').text() + ".";
            }


            if ($('[id*=SectionDropDownList]').find('option').length > 1) {
                $(".S_Show").show();
            }

            //get date in label
            var from = $("[id*=FromDateTextBox]").val();
            var To = $("[id*=ToDateTextBox]").val();

            var tt;
            var Brases1 = "";
            var Brases2 = "";
            var A = "";
            var B = "";
            var TODate = "";

            if (To == "" || from == "" || To == "" && from == "") {
                tt = "";
                A = "";
                B = "";
            }
            else {
                tt = " To ";
                Brases1 = "(";
                Brases2 = ")";
            }

            if (To == "" && from == "") { Brases1 = ""; }

            if (To == from) {
                TODate = "";
                tt = "";
                var Brases1 = "";
                var Brases2 = "";
            }
            else { TODate = To; }

            if (from == "" && To != "") {
                B = " Before ";
            }

            if (To == "" && from != "") {
                A = " After ";
            }

            if (from != "" && To != "") {
                A = "";
                B = "";
            }

            $(".Class_Section").text(Class + Section + PaymentRole);
            $(".Date").text(Brases1 + B + A + from + tt + TODate + Brases2);
        });

        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };

    </script>
</asp:Content>
