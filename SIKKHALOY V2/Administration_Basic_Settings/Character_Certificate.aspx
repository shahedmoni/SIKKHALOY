<%@ Page Title="Character Certificate" Language="C#" MasterPageFile="~/BASIC.Master" AutoEventWireup="true" CodeBehind="Character_Certificate.aspx.cs" Inherits="EDUCATION.COM.Administration_Basic_Settings.Character_Certificate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .C-title {
            font-size: 1.5rem;
            font-weight: 700;
            width: 290px;
            margin: auto;
            margin-top: 3rem;
            border-bottom: 2px solid #000;
            color: #333;
        }

        .C-title2 {
            font-size: 1.1rem;
            color: #000;
            text-align: center;
            margin-bottom: 2rem;
            margin-top: 0.5rem;
        }

        .c-body {
            padding: 4rem;
            color: #000;
            font-size: 1.05rem;
            line-height: 32px;
            text-align: justify;
        }

        .c-footer {
            padding: 0 4rem;
            font-size: 1.05rem;
            color: #000;
        }

        .c-sign {
            position: absolute;
            padding: 0 4rem;
            bottom: 4rem;
            font-size: 1.05rem;
            color: #000;
        }

        .c-sign2 {
            position: absolute;
            padding: 0 4rem;
            right: 0;
            bottom: 4rem;
            font-size: 1.05rem;
            color: #000;
        }

        .link-design {
            padding: 3rem;
            border-radius: .25rem;
            margin-top: 3px;
            text-transform: uppercase;
            color: #3e4551;
            font-size: 1rem;
            font-weight: 400;
            background-color: #f0f0f0;
            box-shadow: 0 2px 5px 0 rgba(0,0,0,.16),0 2px 10px 0 rgba(0,0,0,.12);
            margin-bottom: 1.5rem !important;
            margin-left:20px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="form-inline">

        <div class="link-design">

            <a href="../Administration_Basic_Settings/AllCertificate/CharecterCertificate_English.aspx">Charecter Cerificate (English)</a>
        </div>
        <div class="link-design">

            <a href="../Administration_Basic_Settings/AllCertificate/CharecterCertificate_Bangla.aspx">চারিত্রিক সনদ (বাংলা)</a>
        </div>
        <div class="link-design">

            <a href="../Administration_Basic_Settings/AllCertificate/Testimonial_English.aspx">Testimonial (English)</a>
        </div>
        <div class="link-design">

            <a href="../Administration_Basic_Settings/AllCertificate/Testimonial_Bangla.aspx">প্রশংসা পত্র (বাংলা)</a>
        </div>
    </div>

 


</asp:Content>
