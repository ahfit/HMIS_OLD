<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_Create_Resume, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <style type="text/css">
        .LinkStyle
        {
            padding-right: 10px;
            padding-left: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
      <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>


    <div class="bxmain inner_content">
        <h2>
            <span>Applicant Information</span></h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                 <tr>
                <td align="right">First Name :&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="txtAFName" runat="server" CssClass="input_txt"></asp:TextBox>
                    <span style="color: #ff0000">*</span>
                  
                </td>

                       <td width="17%" rowspan="13" align="center" valign="top">
                                <asp:Image ID="ImageButton1" runat="server" Style="margin-right: 10px;" BorderStyle="Inset"  Height="100px" Width="85px"   ImageUrl="Images/PictureFrame.png" />
                            </td>
            </tr>
            <tr>
                <td align="right">Middle Name :&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="txtEMName" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Last Name :&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="TxtELName" runat="server" CssClass="input_txt"></asp:TextBox>
                    <span style="color: #ff0000">* </span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TxtELName"
                        ErrorMessage="*">*</asp:RequiredFieldValidator>
                </td>

                
      
            </tr>
              



          <tr>
                <td align="right">Attach Picture :&nbsp;
                </td>
               <td>
                                <asp:FileUpload ID="fuCnadidateImage" runat="server" Width="200px"  />
                       <asp:Button ID="btnUpload"  CausesValidation="false" runat="server" Text="Upload" CssClass="btn1"  />   
                               <%-- <asp:RegularExpressionValidator ID="fuCnadidateImageValidator" Display="Dynamic"
                                    ValidationGroup="validate" ValidationExpression="(.*png$)|(.*PNG$)|(.*jpg$)|(.*JPG$)|(.*jpeg$)|(.*JPEG$)"
                                    ControlToValidate="fuCnadidateImage" runat="server" ForeColor="Red" ErrorMessage="Select Only JPEG or PNG file." />--%>
                            </td>

             



         <%--       <td>
                    <asp:FileUpload ID="FileUpload_image" runat="server" Width="200px" />
                    <asp:Button ID="Button_attach_pic" runat="server" CausesValidation="False" Text="Attach"
                        CssClass="btn1" />
                    <asp:HiddenField ID="HiddenField_ImageAttached" runat="server" Value="0" />
                </td>--%>
            </tr>
         <%--   <tr>
                <td align="right">&nbsp;
                </td>
                <td>&nbsp;
                </td>
            </tr>--%>
            <tr>
                <td align="right">Gender :&nbsp;
                </td>
                <td>
                 <asp:DropDownList runat="server" ID="ddlGender" TabIndex="14">
                     <asp:ListItem Value="1" Selected="True" > Male</asp:ListItem>
                      <asp:ListItem Value="2" > Female</asp:ListItem>
                                </asp:DropDownList>
                    </td>
            </tr>
         
            <tr>
                <td align="right">Father  Name :&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="TextBoxFatherName" CssClass="input_txt" runat="server"></asp:TextBox>
                   
                </td>
            </tr>
            <tr>
                <td width="38%" align="right">Date Of Birth :
                </td>
                <td width="62%">
                   <asp:DropDownList ID="ddlYear" runat="server"> </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">Marital Status :
                </td>
                <td>
                    <asp:RadioButtonList CssClass="radlist" ID="RadioButtonList2" RepeatDirection="Horizontal"
                        RepeatLayout="Flow" runat="server" TabIndex="9">
                        <asp:ListItem Selected="True">Single</asp:ListItem>
                        <asp:ListItem>Married</asp:ListItem>
                        <%-- <asp:ListItem>Widow</asp:ListItem>
          <asp:ListItem>Divorced</asp:ListItem>--%>
                    </asp:RadioButtonList>
                </td>
            </tr>

       
            <tr>
                <td width="38%" align="right">CNIC No. :
                </td>
              <td>
                                <asp:UpdatePanel runat="server" ID="forCnic">
                                    <ContentTemplate>
                                        <asp:TextBox TabIndex="2" placeholder="" runat="server" ID="txtCandidateCnicNo" MaxLength="13"
                                            ></asp:TextBox>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
            </tr>
            <tr>
                <td align="right">Email Address :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_email" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Mobile No :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_mobile_No" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Address :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_present_address" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td align="right">Country :
                </td>
                <td>
                    <asp:TextBox ID="TextCountry" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td align="right">State :
                </td>
                <td>
                    <asp:TextBox ID="TextState" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td align="right">City :
                </td>
                <td>
                    <asp:TextBox ID="TextCity" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>

            </tr>
            <tr>
                 <td align="right">Industry :
                </td>
                 <td >
                    <asp:DropDownList runat="server" ID="ddlIndustry">
                        <asp:ListItem Value="1">Accounting</asp:ListItem>
                        <asp:ListItem Value="2">Airlines/Aviation</asp:ListItem>
                        <asp:ListItem Value="3">Alternative Dispute Resolution</asp:ListItem>
                        <asp:ListItem Value="4">Alternative Medicine</asp:ListItem>
                        <asp:ListItem Value="5">Animation</asp:ListItem>
                        <asp:ListItem Value="6">Apparel &amp; Fashion</asp:ListItem>
                        <asp:ListItem Value="7">Architecture &amp; Planning</asp:ListItem>
                        <asp:ListItem Value="8">Arts and Crafts</asp:ListItem>
                        <asp:ListItem Value="9">Automotive</asp:ListItem>
                        <asp:ListItem Value="10">Aviation &amp; Aerospace</asp:ListItem>
                        <asp:ListItem Value="11">Banking</asp:ListItem>
                        <asp:ListItem Value="12">Biotechnology</asp:ListItem>
                        <asp:ListItem Value="13">Broadcast Media</asp:ListItem>
                        <asp:ListItem Value="14">Building Materials</asp:ListItem>
                        <asp:ListItem Value="15">Business Supplies and Equipment</asp:ListItem>
                        <asp:ListItem Value="16">Capital Markets</asp:ListItem>
                        <asp:ListItem Value="17">Chemicals</asp:ListItem>
                        <asp:ListItem Value="18">Civic &amp; Social Organization</asp:ListItem>
                        <asp:ListItem Value="19">Civil Engineering</asp:ListItem>
                        <asp:ListItem Value="20">Commercial Real Estate</asp:ListItem>
                        <asp:ListItem Value="21">Computer &amp; Network Security</asp:ListItem>
                        <asp:ListItem Value="22">Computer Games</asp:ListItem>
                        <asp:ListItem Value="23">Computer Hardware</asp:ListItem>
                        <asp:ListItem Value="24">Computer Networking</asp:ListItem>
                        <asp:ListItem Value="25">Computer Software</asp:ListItem>
                        <asp:ListItem Value="26">Construction</asp:ListItem>
                        <asp:ListItem Value="27">Consumer Electronics</asp:ListItem>
                        <asp:ListItem Value="28">Consumer Goods</asp:ListItem>
                        <asp:ListItem Value="29">Consumer Services</asp:ListItem>
                        <asp:ListItem Value="30">Cosmetics</asp:ListItem>
                        <asp:ListItem Value="31">Dairy</asp:ListItem>
                        <asp:ListItem Value="32">Defense &amp; Space</asp:ListItem>
                        <asp:ListItem Value="33">Design</asp:ListItem>
                        <asp:ListItem Value="34">Education Management</asp:ListItem>
                        <asp:ListItem Value="35">E-Learning</asp:ListItem>
                        <asp:ListItem Value="36">Electrical/Electronic Manufacturing</asp:ListItem>
                        <asp:ListItem Value="37">Entertainment</asp:ListItem>
                        <asp:ListItem Value="38">Environmental Services</asp:ListItem>
                        <asp:ListItem Value="39">Events Services</asp:ListItem>
                        <asp:ListItem Value="40">Executive Office</asp:ListItem>
                        <asp:ListItem Value="41">Facilities Services</asp:ListItem>
                        <asp:ListItem Value="42">Farming</asp:ListItem>
                        <asp:ListItem Value="43">Financial Services</asp:ListItem>
                        <asp:ListItem Value="44">Fine Art</asp:ListItem>
                        <asp:ListItem Value="45">Fishery</asp:ListItem>
                        <asp:ListItem Value="46">Food &amp; Beverages</asp:ListItem>
                        <asp:ListItem Value="47">Food Production</asp:ListItem>
                        <asp:ListItem Value="48">Fund-Raising</asp:ListItem>
                        <asp:ListItem Value="49">Furniture</asp:ListItem>
                        <asp:ListItem Value="50">Gambling &amp; Casinos</asp:ListItem>
                        <asp:ListItem Value="51">Glass, Ceramics &amp; Concrete</asp:ListItem>
                        <asp:ListItem Value="52">Government Administration</asp:ListItem>
                        <asp:ListItem Value="53">Government Relations</asp:ListItem>
                        <asp:ListItem Value="54">Graphic Design</asp:ListItem>
                        <asp:ListItem Value="55">Health, Wellness and Fitness</asp:ListItem>
                        <asp:ListItem Value="56">Higher Education</asp:ListItem>
                        <asp:ListItem Value="57">Hospital &amp; Health Care</asp:ListItem>
                        <asp:ListItem Value="58">Hospitality</asp:ListItem>
                        <asp:ListItem Value="59">Human Resources</asp:ListItem>
                        <asp:ListItem Value="60">Import and Export</asp:ListItem>
                        <asp:ListItem Value="61">Individual &amp; Family Services</asp:ListItem>
                        <asp:ListItem Value="62">Industrial Automation</asp:ListItem>
                        <asp:ListItem Value="63">Information Services</asp:ListItem>
                        <asp:ListItem Value="64">Information Technology and Services</asp:ListItem>
                        <asp:ListItem Value="65">Insurance</asp:ListItem>
                        <asp:ListItem Value="66">International Affairs</asp:ListItem>
                        <asp:ListItem Value="67">International Trade and Development</asp:ListItem>
                        <asp:ListItem Value="68">Internet</asp:ListItem>
                        <asp:ListItem Value="69">Investment Banking</asp:ListItem>
                        <asp:ListItem Value="70">Investment Management</asp:ListItem>
                        <asp:ListItem Value="71">Judiciary</asp:ListItem>
                        <asp:ListItem Value="72">Law Enforcement</asp:ListItem>
                        <asp:ListItem Value="73">Law Practice</asp:ListItem>
                        <asp:ListItem Value="74">Legal Services</asp:ListItem>
                        <asp:ListItem Value="75">Legislative Office</asp:ListItem>
                        <asp:ListItem Value="76">Leisure, Travel &amp; Tourism</asp:ListItem>
                        <asp:ListItem Value="77">Libraries</asp:ListItem>
                        <asp:ListItem Value="78">Logistics and Supply Chain</asp:ListItem>
                        <asp:ListItem Value="79">Luxury Goods &amp; Jewelry</asp:ListItem>
                        <asp:ListItem Value="80">Machinery</asp:ListItem>
                        <asp:ListItem Value="81">Management Consulting</asp:ListItem>
                        <asp:ListItem Value="82">Maritime</asp:ListItem>
                        <asp:ListItem Value="83">Marketing and Advertising</asp:ListItem>
                        <asp:ListItem Value="84">Market Research</asp:ListItem>
                        <asp:ListItem Value="85">Mechanical or Industrial Engineering</asp:ListItem>
                        <asp:ListItem Value="86">Media Production</asp:ListItem>
                        <asp:ListItem Value="87">Medical Devices</asp:ListItem>
                        <asp:ListItem Value="88">Medical Practice</asp:ListItem>
                        <asp:ListItem Value="89">Mental Health Care</asp:ListItem>
                        <asp:ListItem Value="90">Military</asp:ListItem>
                        <asp:ListItem Value="91">Mining &amp; Metals</asp:ListItem>
                        <asp:ListItem Value="92">Motion Pictures and Film</asp:ListItem>
                        <asp:ListItem Value="93">Museums and Institutions</asp:ListItem>
                        <asp:ListItem Value="94">Music</asp:ListItem>
                        <asp:ListItem Value="95">Nanotechnology</asp:ListItem>
                        <asp:ListItem Value="96">Newspapers</asp:ListItem>
                        <asp:ListItem Value="97">Non-Profit Organization Management</asp:ListItem>
                        <asp:ListItem Value="98">Oil &amp; Energy</asp:ListItem>
                        <asp:ListItem Value="99">Online Media</asp:ListItem>
                        <asp:ListItem Value="100">Outsourcing/Offshoring</asp:ListItem>
                        <asp:ListItem Value="101">Package/Freight Delivery</asp:ListItem>
                        <asp:ListItem Value="102">Packaging and Containers</asp:ListItem>
                        <asp:ListItem Value="103">Paper &amp; Forest Products</asp:ListItem>
                        <asp:ListItem Value="104">Performing Arts</asp:ListItem>
                        <asp:ListItem Value="105">Pharmaceuticals</asp:ListItem>
                        <asp:ListItem Value="106">Philanthropy</asp:ListItem>
                        <asp:ListItem Value="107">Photography</asp:ListItem>
                        <asp:ListItem Value="108">Plastics</asp:ListItem>
                        <asp:ListItem Value="109">Political Organization</asp:ListItem>
                        <asp:ListItem Value="110">Primary/Secondary Education</asp:ListItem>
                        <asp:ListItem Value="111">Printing</asp:ListItem>
                        <asp:ListItem Value="112">Professional Training &amp; Coaching</asp:ListItem>
                        <asp:ListItem Value="113">Program Development</asp:ListItem>
                        <asp:ListItem Value="114">Public Policy</asp:ListItem>
                        <asp:ListItem Value="115">Public Relations and Communications</asp:ListItem>
                        <asp:ListItem Value="116">Public Safety</asp:ListItem>
                        <asp:ListItem Value="117">Publishing</asp:ListItem>
                        <asp:ListItem Value="118">Railroad Manufacture</asp:ListItem>
                        <asp:ListItem Value="119">Ranching</asp:ListItem>
                        <asp:ListItem Value="120">Real Estate</asp:ListItem>
                        <asp:ListItem Value="121">Recreational Facilities and Services</asp:ListItem>
                        <asp:ListItem Value="122">Religious Institutions</asp:ListItem>
                        <asp:ListItem Value="123">Renewables &amp; Environment</asp:ListItem>
                        <asp:ListItem Value="124">Research</asp:ListItem>
                        <asp:ListItem Value="125">Restaurants</asp:ListItem>
                        <asp:ListItem Value="126">Retail</asp:ListItem>
                        <asp:ListItem Value="127">Security and Investigations</asp:ListItem>
                        <asp:ListItem Value="128">Semiconductors</asp:ListItem>
                        <asp:ListItem Value="129">Shipbuilding</asp:ListItem>
                        <asp:ListItem Value="130">Sporting Goods</asp:ListItem>
                        <asp:ListItem Value="131">Sports</asp:ListItem>
                        <asp:ListItem Value="132">Staffing and Recruiting</asp:ListItem>
                        <asp:ListItem Value="133">Supermarkets</asp:ListItem>
                        <asp:ListItem Value="134">Telecommunications</asp:ListItem>
                        <asp:ListItem Value="135">Textiles</asp:ListItem>
                        <asp:ListItem Value="136">Think Tanks</asp:ListItem>
                        <asp:ListItem Value="137">Tobacco</asp:ListItem>
                        <asp:ListItem Value="138">Translation and Localization</asp:ListItem>
                        <asp:ListItem Value="139">Transportation/Trucking/Railroad</asp:ListItem>
                        <asp:ListItem Value="140">Utilities</asp:ListItem>
                        <asp:ListItem Value="141">Venture Capital &amp; Private Equity</asp:ListItem>
                        <asp:ListItem Value="142">Veterinary</asp:ListItem>
                        <asp:ListItem Value="143">Warehousing</asp:ListItem>
                        <asp:ListItem Value="144">Wholesale</asp:ListItem>
                        <asp:ListItem Value="145">Wine and Spirits</asp:ListItem>
                        <asp:ListItem Value="146">Wireless</asp:ListItem>
                        <asp:ListItem Value="147">Writing and Editing</asp:ListItem>
                    </asp:DropDownList>





                </td>
            </tr>

             <tr>
                <td align="right">Experience :
                </td>
                <td>
                   <asp:DropDownList runat="server" ID="ddlExperience">
                       <asp:ListItem value="-2">Internee</asp:ListItem><asp:ListItem value="-1">Fresh Graduate</asp:ListItem><asp:ListItem value="0">&lt; 1 Year</asp:ListItem><asp:ListItem value="1">1 Year</asp:ListItem><asp:ListItem value="2">2 Years</asp:ListItem><asp:ListItem value="3">3 Years</asp:ListItem><asp:ListItem value="4">4 Years</asp:ListItem><asp:ListItem value="5">5 Years</asp:ListItem><asp:ListItem value="6">6 Years</asp:ListItem><asp:ListItem value="7">7 Years</asp:ListItem><asp:ListItem value="8">8 Years</asp:ListItem><asp:ListItem value="9">9 Years</asp:ListItem><asp:ListItem value="10">10 Years</asp:ListItem><asp:ListItem value="11">11 Years</asp:ListItem><asp:ListItem value="12">12 Years</asp:ListItem><asp:ListItem value="13">13 Years</asp:ListItem><asp:ListItem value="14">14 Years</asp:ListItem><asp:ListItem value="15">15 Years</asp:ListItem><asp:ListItem value="16">16 Years</asp:ListItem><asp:ListItem value="17">17 Years</asp:ListItem><asp:ListItem value="18">18 Years</asp:ListItem><asp:ListItem value="19">19 Years</asp:ListItem><asp:ListItem value="20">20 Years</asp:ListItem><asp:ListItem value="21">21 Years</asp:ListItem><asp:ListItem value="22">22 Years</asp:ListItem><asp:ListItem value="23">23 Years</asp:ListItem><asp:ListItem value="24">24 Years</asp:ListItem><asp:ListItem value="25">25 Years</asp:ListItem><asp:ListItem value="26">&gt; 25 Years</asp:ListItem>
                   </asp:DropDownList>



                   
        



                </td>

            </tr>

              <tr>
                <td align="right">Current Salary :
                </td>
                <td>
                    <asp:TextBox ID="TextSalary" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>

              <tr>
                <td align="right">Expected Salary :
                </td>
                <td>
                    <asp:TextBox ID="TextExpSalary" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>

              <tr>
                <td align="right">Professional Summary :
                </td>
                <td>
                   <asp:TextBox ID="TextPRoSmry" runat="server" ></asp:TextBox>
                </td>
            </tr>
            <tr>
             <td align="right">Upload CV :
                </td>
                <td>
                    <asp:FileUpload Width="205px" ID="fuCv" runat="server" TabIndex="51" />
                    <asp:Button ID="ButtonCv" runat="server" Text="Upload"  />
                    </td>
                    </tr>



            <tr>
                 <td align="right"> &nbsp; &nbsp;
                </td>
           <td >
                <asp:Button ID="btnSave" Text="Save" OnClick="btnSave_Click" runat="server" />
           </td></tr>
            </table>




    </div>


</asp:Content>


