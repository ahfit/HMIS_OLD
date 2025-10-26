<%@ Page Title="" Language="C#" MasterPageFile="~/HacimsBlankMaster.master" AutoEventWireup="true" CodeFile="PatientSearchReport.aspx.cs" Inherits="Pathology_Approved_Report_Status" %>
<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Fonts -->
    <link href="https://fonts.cdnfonts.com/css/aptos" rel="stylesheet">
    <style>
        @font-face {
            font-family: 'Jameel Noori Nastaleeq';
            src: url('/fonts/JameelNooriNastaleeq.woff2') format('woff2'),
                 url('/fonts/JameelNooriNastaleeq.woff') format('woff'),
                 url('/fonts/JameelNooriNastaleeq.ttf') format('truetype');
        }

        /* 🌄 Background */
        body {
            background: linear-gradient(135deg, rgba(240,248,255,0.95), rgba(255,255,255,0.95)),
                        url('../images_hacims/2.jpeg') center/cover no-repeat fixed;
            font-family: 'Aptos', 'Segoe UI', sans-serif;
            color: #333;
        }

        /* 🧊 Glass-style container */
        .container-custom {
            background: rgba(255, 255, 255, 0.88);
            backdrop-filter: blur(10px);
            padding: 45px;
            border-radius: 20px;
            margin-top: 60px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.5);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .container-custom:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.25);
        }

        /* 🏷️ Headings */
        h2 {
            font-size: 30px;
            font-weight: bold;
            text-align: center;
            color: #B22222;
            margin: 25px 0;
        }

        .urudhead {
            font-family: 'Jameel Noori Nastaleeq', serif;
            text-align: center;
            font-size: 36px;
            color: #b22222;
            margin-top: -10px;
            margin-bottom: 40px;
        }

        /* 🔘 Inputs and labels */
        .form-group label {
            font-weight: 600;
            color: #8B0000;
        }

        .form-control {
            border-radius: 12px;
            height: 42px;
            font-size: 16px;
            border: 1px solid #ccc;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-control:focus {
            border-color: #b22222;
            box-shadow: 0 0 6px rgba(178,34,34,0.4);
        }

        /* 🔍 Search Button */
        .btn-search {
            width: 180px;
            border-radius: 25px;
            background: linear-gradient(90deg, #b22222, #ff4d4d);
            border: none;
            color: #fff;
            font-weight: 600;
            font-size: 16px;
            padding: 10px;
            display: block;
            margin: 20px auto;
            transition: all 0.3s ease;
        }

        .btn-search:hover {
            background: linear-gradient(90deg, #a50000, #ff1a1a);
            box-shadow: 0 0 10px rgba(255,0,0,0.4);
        }

        /* 🧾 GridView styling */
        .table {
            border-collapse: separate;
            border-spacing: 0;
            overflow: hidden;
            border-radius: 14px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .table thead th {
            background: linear-gradient(90deg, #8B0000, #DC143C);
            color: white;
            font-weight: bold;
            text-align: center;
            border: none;
        }

        .table td, .table th {
            vertical-align: middle !important;
            border: 1px solid #eee;
            text-align: center;
        }

        /* 📍 Footer info */
        ul li {
            list-style: none;
            margin-bottom: 5px;
        }

        .list {
            font-weight: bold;
            color: #8B0000;
        }

        span {
            text-align: center;
            display: block;
        }

        .imglogo {
            border-radius: 50%;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        }
    </style>
</asp:Content>
