<%@ Page Language="VB" AutoEventWireup="false   " CodeFile="cardpage.aspx.vb" Inherits="Patient_Registration_cardpage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Card</title>
    <link rel="stylesheet" href="//fonts.googleapis.com/earlyaccess/notonastaliqurdudraft.css"/>
    <style type="text/css">
        @font-face {
            font-family: IDAutomationHC39M;
            src: url('../css_hacims/fonts/IDAutomationHC39M.ttf');
        }

        #urdufont {
            font-family: 'Noto Nastaliq Urdu Draft', serif;
        }

        p {
            font-size: 12px;
        }
    </style>
</head>
<body>
    <form runat="server" id="form1">
          <h2>Front</h2>
        <asp:DataList ID="dlcard" runat="server">
          
            <ItemTemplate>
                <div style="border:1px solid black;width:435px">
                <table style="width:85%">
                    <tr>
                        <td rowspan="3"><img src="../images_hacims/red.png" / width="100px" height="40px" style="margin-left:20px" alt="logo"></td>
                        <td align="center"><span style="font-size:larger;font-weight:700">Alkhidmat Raazi Hospital Rawalpindi</span><br />
                            Ph : (051)4906401
                            <br />
                            Email:alkhidmatfyhospital.org
                        </td>
                    </tr>
                   

                </table>
                    <br />
                <table style="width:110%">
                    <tr>

                        <td style="width:100%;">&nbsp; &nbsp; &nbsp;M.R NO
                           <asp:Label ID="lblMrNo" runat="server" Text='<%#Eval("RegNo") %>'></asp:Label> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; CNIC: 
                           <asp:Label ID="lblCnic" runat="server" Text='<%#Eval("CNIC") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="left"><b>
                            <asp:Label ID="lblName" runat="server" Text='<%#Eval("PatientName") %>' Font-Bold="true" style="margin-left:20px"></asp:Label></b></td>
                        
                    </tr>
                    <tr>
                        <td align="center">
                            <div style="width:165px;margin-right:-35px"> Reg Date:
                            <asp:Label ID="lblRegDate" runat="server" Text='<%#Eval("RegDateTime") %>'></asp:Label>
                                </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            
                            <div style="width:250px;margin-left:-20px">
                            <asp:Label ID="lblBarCode" Font-Names="IDAutomationHC39M" runat="server" Text='<%#Eval("RegNo") %>'></asp:Label>
                                </div>
                        </td>
                    </tr>
                </table>
                    </div>
            </ItemTemplate>
        </asp:DataList>

        <h2>Back</h2>
        
                <div style="border:1px solid black;width:430px;padding:5px" id="urdufont" >
                    <p style="width:100%;text-align:center">ہدایات  </p>
               <p style="text-align:right">یہ اندراج ایک مریض کے لئے تاحیات کار آمد ہے . برائےمہربانی اس مریض کے لئے دوسرا نمبر نہ لیں. </p><p style="text-align:right">
یہ کارڈ نمبر اپنے پاس نوٹ کر لیں.گم ہونے کی صورت میں جرمانہ ہو گا اور نیا کارڈ بنایا جائے گا.</p>
                    <p style="text-align:right">
ہسپتال آتے وقت یہ کارڈ ضرور ساته لائیں.</p><p style="text-align:right">
ٹیلی فون نمبریا پتہ تبدیل ہونے کی صورت میں رجسٹریشن آفس کو مطلعح کریں.</p>
                    </div>

    </form>
</body>
</html>
