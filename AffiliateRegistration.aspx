<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AffiliateRegistration.aspx.cs" Inherits="AffiliateRegistration" %>
<%@ Register src="Controls/privacy.ascx" tagname="privacy" tagprefix="uc2" %>
<%@ Register Assembly="skmValidators" Namespace="skmValidators" TagPrefix="skm" %>
<%@ Register src="Controls/Legal.ascx" tagname="Legal" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>PeaShake House: Real Time... Real People!</title>
<link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
<style type="text/css">
        body { background-image:url('images/bkgs/1.jpg'); }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="Scripts/login.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width:600px";">
            <div class="accordionHeader">
                PeaShake House Registration / Sign-Up
            </div>
            <div class="accordionContent">
                <div class="blackpaper">
                <center>
                <p>
                    <img src="Images/Bkgs/login-logo.gif" border="0" />
                </p>
                </center>
                <asp:CreateUserWizard ID="RegisterUser" title="Sign Up for Your New Account" runat="server" 
                    EnableViewState="false" OnNextButtonClick="RegisterUser_NextButtonClick" OnCreatedUser="RegisterUser_CreatedUser">
                    <LayoutTemplate>
                        <asp:PlaceHolder ID="wizardStepPlaceholder" runat="server"></asp:PlaceHolder>
                        <asp:PlaceHolder ID="navigationPlaceholder" runat="server"></asp:PlaceHolder>
                    </LayoutTemplate>
                    <WizardSteps>
                        <asp:WizardStep ID="RegisterUserWizardStep0" runat="server">
                            <span class="green">
                            <center>
                                <p>
                                    Create a user name for your new account
                                </p>
                                <p>
                                    You must be at least 14 years old.<br /><br />
                                </p>
                                <p>
                                    <asp:Label ID="AccountNameLabel" runat="server" AssociatedControlID="AccountName" CssClass="regLabel"> 
                                        User Name:</asp:Label>
                                    <asp:TextBox ID="AccountName" runat="server" CssClass="textEntryLogin" /><br />
                                    <asp:Label ID="SearchAccountMessage" runat="server" ForeColor="red" /><br />                                         
                                    Already registered? <a href="Login.aspx">Login here.</a>
                                </p>
                            </center>
                            </span>
                        </asp:WizardStep>
                        <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server">
                            <ContentTemplate>
                                <div class="accountInfo">
                                    <table width="100%" border="0" cellpadding="10" cellspacing="0">
                                        <tr>
                                            <td colspan="2" align="center" class="green">
                                                You must be at least 14 years old.<br />
                                                Already registered? <a href="Login.aspx">Login here.</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" CssClass="regLabel">User Name:</asp:Label>
                                                <asp:Label ID="displayUserName" runat="server" CssClass="green" />
                                                <asp:TextBox ID="UserName" runat="server" CssClass="textEntryLogin"/>
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                                                        CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required." 
                                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email" CssClass="regLabel">E-mail:</asp:Label>
                                                <asp:TextBox ID="Email" runat="server" CssClass="textEntryLogin"/>
                                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" 
                                                        CssClass="failureNotification" ErrorMessage="E-mail is required." ToolTip="E-mail is required." 
                                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <span class="green">Passwords must be a minimum of <%= Membership.MinRequiredPasswordLength %> characters in length.</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" CssClass="regLabel">Password:</asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="Password" runat="server" CssClass="textEntryLogin" TextMode="Password"/>
                                                        </td>
                                                        <td>
                                                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                                                                CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required." 
                                                                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword" CssClass="regLabel">Confirm Password:</asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="textEntryLogin" TextMode="Password"/>
                                                        </td>
                                                        <td>
                                                            <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword" 
                                                                CssClass="failureNotification" ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required." 
                                                                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6">
                                                            <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                                                                CssClass="failureNotification" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match."
                                                                ValidationGroup="RegisterUserValidationGroup">*</asp:CompareValidator>                                                                </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:DropDownList id="State" runat="server" CssClass="ddl">
                                                    <asp:ListItem Value="" selected="true">Select State</asp:ListItem>
                                                    <asp:ListItem Value="AL">Alabama</asp:ListItem>
                                                    <asp:ListItem Value="AK">Alaska</asp:ListItem>
                                                    <asp:ListItem Value="AZ">Arizona</asp:ListItem>
                                                    <asp:ListItem Value="AR">Arkansas</asp:ListItem>
                                                    <asp:ListItem Value="CA">California</asp:ListItem>
                                                    <asp:ListItem Value="CO">Colorado</asp:ListItem>
                                                    <asp:ListItem Value="CT">Connecticut</asp:ListItem>
                                                    <asp:ListItem Value="DC">District of Columbia</asp:ListItem>
                                                    <asp:ListItem Value="DE">Delaware</asp:ListItem>
                                                    <asp:ListItem Value="FL">Florida</asp:ListItem>
                                                    <asp:ListItem Value="GA">Georgia</asp:ListItem>
                                                    <asp:ListItem Value="HI">Hawaii</asp:ListItem>
                                                    <asp:ListItem Value="ID">Idaho</asp:ListItem>
                                                    <asp:ListItem Value="IL">Illinois</asp:ListItem>
                                                    <asp:ListItem Value="IN">Indiana</asp:ListItem>
                                                    <asp:ListItem Value="IA">Iowa</asp:ListItem>
                                                    <asp:ListItem Value="KS">Kansas</asp:ListItem>
                                                    <asp:ListItem Value="KY">Kentucky</asp:ListItem>
                                                    <asp:ListItem Value="LA">Louisiana</asp:ListItem>
                                                    <asp:ListItem Value="ME">Maine</asp:ListItem>
                                                    <asp:ListItem Value="MD">Maryland</asp:ListItem>
                                                    <asp:ListItem Value="MA">Massachusetts</asp:ListItem>
                                                    <asp:ListItem Value="MI">Michigan</asp:ListItem>
                                                    <asp:ListItem Value="MN">Minnesota</asp:ListItem>
                                                    <asp:ListItem Value="MS">Mississippi</asp:ListItem>
                                                    <asp:ListItem Value="MO">Missouri</asp:ListItem>
                                                    <asp:ListItem Value="MT">Montana</asp:ListItem>
                                                    <asp:ListItem Value="NE">Nebraska</asp:ListItem>
                                                    <asp:ListItem Value="NV">Nevada</asp:ListItem>
                                                    <asp:ListItem Value="NH">New Hampshire</asp:ListItem>
                                                    <asp:ListItem Value="NJ">New Jersey</asp:ListItem>
                                                    <asp:ListItem Value="NM">New Mexico</asp:ListItem>
                                                    <asp:ListItem Value="NY">New York</asp:ListItem>
                                                    <asp:ListItem Value="NC">North Carolina</asp:ListItem>
                                                    <asp:ListItem Value="ND">North Dakota</asp:ListItem>
                                                    <asp:ListItem Value="OH">Ohio</asp:ListItem>
                                                    <asp:ListItem Value="OK">Oklahoma</asp:ListItem>
                                                    <asp:ListItem Value="OR">Oregon</asp:ListItem>
                                                    <asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
                                                    <asp:ListItem Value="RI">Rhode Island</asp:ListItem>
                                                    <asp:ListItem Value="SC">South Carolina</asp:ListItem>
                                                    <asp:ListItem Value="SD">South Dakota</asp:ListItem>
                                                    <asp:ListItem Value="TN">Tennessee</asp:ListItem>
                                                    <asp:ListItem Value="TX">Texas</asp:ListItem>
                                                    <asp:ListItem Value="UT">Utah</asp:ListItem>
                                                    <asp:ListItem Value="VT">Vermont</asp:ListItem>
                                                    <asp:ListItem Value="VA">Virginia</asp:ListItem>
                                                    <asp:ListItem Value="WA">Washington</asp:ListItem>
                                                    <asp:ListItem Value="WV">West Virginia</asp:ListItem>
                                                    <asp:ListItem Value="WI">Wisconsin</asp:ListItem>
                                                    <asp:ListItem Value="WY">Wyoming</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:requiredfieldvalidator runat="server" controltovalidate="State" CssClass="failureNotification" tooltip="State is required."
                                                id="StateRequired" validationgroup="RegisterUserValidationGroup" errormessage="State is required.">*</asp:requiredfieldvalidator>
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList id="Country" runat="server" CssClass="ddl">
                                                        <asp:ListItem Value="">Select Country</asp:ListItem>
                                                        <asp:ListItem Value="225" selected="true">United States</asp:ListItem>
                                                        <asp:ListItem Value="224">United Kingdom</asp:ListItem>
                                                        <asp:ListItem Value="1">Afghanistan</asp:ListItem>
                                                        <asp:ListItem Value="2">Albania</asp:ListItem>
                                                        <asp:ListItem Value="3">Algeria</asp:ListItem>
                                                        <asp:ListItem Value="4">American Samoa</asp:ListItem>
                                                        <asp:ListItem Value="5">Andorra</asp:ListItem>
                                                        <asp:ListItem Value="6">Angola</asp:ListItem>
                                                        <asp:ListItem Value="7">Anguilla</asp:ListItem>
                                                        <asp:ListItem Value="8">Antarctica</asp:ListItem>
                                                        <asp:ListItem Value="9">Antigua &amp; Barbuda</asp:ListItem>
                                                        <asp:ListItem Value="10">Argentina</asp:ListItem>
                                                        <asp:ListItem Value="11">Armenia</asp:ListItem>
                                                        <asp:ListItem Value="12">Aruba</asp:ListItem>
                                                        <asp:ListItem Value="13">Australia</asp:ListItem>
                                                        <asp:ListItem Value="14">Austria</asp:ListItem>
                                                        <asp:ListItem Value="15">Azerbaidjan</asp:ListItem>
                                                        <asp:ListItem Value="16">Bahamas</asp:ListItem>
                                                        <asp:ListItem Value="17">Bahrain</asp:ListItem>
                                                        <asp:ListItem Value="18">Bangladesh</asp:ListItem>
                                                        <asp:ListItem Value="19">Barbados</asp:ListItem>
                                                        <asp:ListItem Value="20">Belarus</asp:ListItem>
                                                        <asp:ListItem Value="21">Belgium</asp:ListItem>
                                                        <asp:ListItem Value="22">Belize</asp:ListItem>
                                                        <asp:ListItem Value="23">Benin</asp:ListItem>
                                                        <asp:ListItem Value="24">Bermuda</asp:ListItem>
                                                        <asp:ListItem Value="25">Bolivia</asp:ListItem>
                                                        <asp:ListItem Value="26">Bosnia-Herzegovina</asp:ListItem>
                                                        <asp:ListItem Value="27">Botswana</asp:ListItem>
                                                        <asp:ListItem Value="28">Bouvet Island</asp:ListItem>
                                                        <asp:ListItem Value="29">Brazil</asp:ListItem>
                                                        <asp:ListItem Value="30">Brit. Indian O. Terr.</asp:ListItem>
                                                        <asp:ListItem Value="31">Brunei Darussalam</asp:ListItem>
                                                        <asp:ListItem Value="32">Bulgaria</asp:ListItem>
                                                        <asp:ListItem Value="33">Burkina Faso</asp:ListItem>
                                                        <asp:ListItem Value="36">Cambodia</asp:ListItem>
                                                        <asp:ListItem Value="37">Cameroon</asp:ListItem>
                                                        <asp:ListItem Value="38">Canada</asp:ListItem>
                                                        <asp:ListItem Value="39">Cape Verde</asp:ListItem>
                                                        <asp:ListItem Value="40">Cayman Islands</asp:ListItem>
                                                        <asp:ListItem Value="41">Central African Rep.</asp:ListItem>
                                                        <asp:ListItem Value="42">Chad</asp:ListItem>
                                                        <asp:ListItem Value="43">Chile</asp:ListItem>
                                                        <asp:ListItem Value="44">China</asp:ListItem>
                                                        <asp:ListItem Value="47">Colombia</asp:ListItem>
                                                        <asp:ListItem Value="48">Comoros</asp:ListItem>
                                                        <asp:ListItem Value="50">Cook Islands</asp:ListItem>
                                                        <asp:ListItem Value="51">Costa Rica</asp:ListItem>
                                                        <asp:ListItem Value="52">Croatia</asp:ListItem>
                                                        <asp:ListItem Value="53">Cuba</asp:ListItem>
                                                        <asp:ListItem Value="54">Cyprus</asp:ListItem>
                                                        <asp:ListItem Value="55">Czech Republic</asp:ListItem>
                                                        <asp:ListItem Value="56">Czechoslovakia</asp:ListItem>
                                                        <asp:ListItem Value="57">Denmark</asp:ListItem>
                                                        <asp:ListItem Value="59">Dominica</asp:ListItem>
                                                        <asp:ListItem Value="60">Dominican Rep.</asp:ListItem>
                                                        <asp:ListItem Value="61">East Timor</asp:ListItem>
                                                        <asp:ListItem Value="62">Ecuador</asp:ListItem>
                                                        <asp:ListItem Value="63">Egypt</asp:ListItem>
                                                        <asp:ListItem Value="64">El Salvador</asp:ListItem>
                                                        <asp:ListItem Value="66">Estonia</asp:ListItem>
                                                        <asp:ListItem Value="67">Ethiopia</asp:ListItem>
                                                        <asp:ListItem Value="69">Faroe Islands</asp:ListItem>
                                                        <asp:ListItem Value="70">Fiji</asp:ListItem>
                                                        <asp:ListItem Value="71">Finland</asp:ListItem>
                                                        <asp:ListItem Value="73">France</asp:ListItem>
                                                        <asp:ListItem Value="72">France (Euro Terr.)</asp:ListItem>
                                                        <asp:ListItem Value="74">French S. Terr.</asp:ListItem>
                                                        <asp:ListItem Value="76">Gambia</asp:ListItem>
                                                        <asp:ListItem Value="77">Georgia</asp:ListItem>
                                                        <asp:ListItem Value="78">Germany</asp:ListItem>
                                                        <asp:ListItem Value="79">Ghana</asp:ListItem>
                                                        <asp:ListItem Value="80">Gibraltar</asp:ListItem>
                                                        <asp:ListItem Value="82">Greece</asp:ListItem>
                                                        <asp:ListItem Value="83">Greenland</asp:ListItem>
                                                        <asp:ListItem Value="84">Grenada</asp:ListItem>
                                                        <asp:ListItem Value="85">Guadeloupe (Fr.)</asp:ListItem>
                                                        <asp:ListItem Value="86">Guam (US)</asp:ListItem>
                                                        <asp:ListItem Value="87">Guatemala</asp:ListItem>
                                                        <asp:ListItem Value="91">Guyana</asp:ListItem>
                                                        <asp:ListItem Value="92">Haiti</asp:ListItem>
                                                        <asp:ListItem Value="94">Honduras</asp:ListItem>
                                                        <asp:ListItem Value="95">Hong Kong</asp:ListItem>
                                                        <asp:ListItem Value="96">Hungary</asp:ListItem>
                                                        <asp:ListItem Value="97">Iceland</asp:ListItem>
                                                        <asp:ListItem Value="98">India</asp:ListItem>
                                                        <asp:ListItem Value="99">Indonesia</asp:ListItem>
                                                        <asp:ListItem Value="100">Iran</asp:ListItem>
                                                        <asp:ListItem Value="101">Iraq</asp:ListItem>
                                                        <asp:ListItem Value="102">Ireland</asp:ListItem>
                                                        <asp:ListItem Value="231">Islamabad</asp:ListItem>
                                                        <asp:ListItem Value="103">Israel</asp:ListItem>
                                                        <asp:ListItem Value="104">Italy</asp:ListItem>
                                                        <asp:ListItem Value="105">Ivory Coast</asp:ListItem>
                                                        <asp:ListItem Value="106">Jamaica</asp:ListItem>
                                                        <asp:ListItem Value="107">Japan</asp:ListItem>
                                                        <asp:ListItem Value="108">Jordan</asp:ListItem>
                                                        <asp:ListItem Value="109">Kazachstan</asp:ListItem>
                                                        <asp:ListItem Value="110">Kenya</asp:ListItem>
                                                        <asp:ListItem Value="111">Kirgistan</asp:ListItem>
                                                        <asp:ListItem Value="114">Korea (South)</asp:ListItem>
                                                        <asp:ListItem Value="115">Kuwait</asp:ListItem>
                                                        <asp:ListItem Value="116">Laos</asp:ListItem>
                                                        <asp:ListItem Value="117">Latvia</asp:ListItem>
                                                        <asp:ListItem Value="118">Lebanon</asp:ListItem>
                                                        <asp:ListItem Value="119">Lesotho</asp:ListItem>
                                                        <asp:ListItem Value="120">Liberia</asp:ListItem>
                                                        <asp:ListItem Value="122">Liechtenstein</asp:ListItem>
                                                        <asp:ListItem Value="123">Lithuania</asp:ListItem>
                                                        <asp:ListItem Value="124">Luxembourg</asp:ListItem>
                                                        <asp:ListItem Value="125">Macau</asp:ListItem>
                                                        <asp:ListItem Value="229">Macedonia</asp:ListItem>
                                                        <asp:ListItem Value="126">Madagascar</asp:ListItem>
                                                        <asp:ListItem Value="127">Malawi</asp:ListItem>
                                                        <asp:ListItem Value="128">Malaysia</asp:ListItem>
                                                        <asp:ListItem Value="129">Maldives</asp:ListItem>
                                                        <asp:ListItem Value="131">Malta</asp:ListItem>
                                                        <asp:ListItem Value="133">Martinique (Fr.)</asp:ListItem>
                                                        <asp:ListItem Value="135">Mauritius</asp:ListItem>
                                                        <asp:ListItem Value="136">Mexico</asp:ListItem>
                                                        <asp:ListItem Value="138">Moldavia</asp:ListItem>
                                                        <asp:ListItem Value="139">Monaco</asp:ListItem>
                                                        <asp:ListItem Value="140">Mongolia</asp:ListItem>
                                                        <asp:ListItem Value="228">Montenegro</asp:ListItem>
                                                        <asp:ListItem Value="142">Morocco</asp:ListItem>
                                                        <asp:ListItem Value="143">Mozambique</asp:ListItem>
                                                        <asp:ListItem Value="144">Myanmar</asp:ListItem>
                                                        <asp:ListItem Value="145">Namibia</asp:ListItem>
                                                        <asp:ListItem Value="147">Nepal</asp:ListItem>
                                                        <asp:ListItem Value="148">Netherland Antilles</asp:ListItem>
                                                        <asp:ListItem Value="149">Netherlands</asp:ListItem>
                                                        <asp:ListItem Value="151">New Caledonia (Fr.)</asp:ListItem>
                                                        <asp:ListItem Value="152">New Zealand</asp:ListItem>
                                                        <asp:ListItem Value="153">Nicaragua</asp:ListItem>
                                                        <asp:ListItem Value="155">Nigeria</asp:ListItem>
                                                        <asp:ListItem Value="156">Niue</asp:ListItem>
                                                        <asp:ListItem Value="157">Norfolk Island</asp:ListItem>
                                                        <asp:ListItem Value="158">N. Mariana Isl.</asp:ListItem>
                                                        <asp:ListItem Value="159">Norway</asp:ListItem>
                                                        <asp:ListItem Value="160">Oman</asp:ListItem>
                                                        <asp:ListItem Value="161">Pakistan</asp:ListItem>
                                                        <asp:ListItem Value="162">Palau</asp:ListItem>
                                                        <asp:ListItem Value="163">Panama</asp:ListItem>
                                                        <asp:ListItem Value="164">Papua New Guinea</asp:ListItem>
                                                        <asp:ListItem Value="165">Paraguay</asp:ListItem>
                                                        <asp:ListItem Value="166">Peru</asp:ListItem>
                                                        <asp:ListItem Value="167">Philippines</asp:ListItem>
                                                        <asp:ListItem Value="168">Pitcairn</asp:ListItem>
                                                        <asp:ListItem Value="169">Poland</asp:ListItem>
                                                        <asp:ListItem Value="170">Polynesia (Fr.)</asp:ListItem>
                                                        <asp:ListItem Value="171">Portugal</asp:ListItem>
                                                        <asp:ListItem Value="172">Puerto Rico (US)</asp:ListItem>
                                                        <asp:ListItem Value="173">Qatar</asp:ListItem>
                                                        <asp:ListItem Value="175">Romania</asp:ListItem>
                                                        <asp:ListItem Value="176">Russian Federation</asp:ListItem>
                                                        <asp:ListItem Value="178">Saint Lucia</asp:ListItem>
                                                        <asp:ListItem Value="181">Saudi Arabia</asp:ListItem>
                                                        <asp:ListItem Value="182">Senegal</asp:ListItem>
                                                        <asp:ListItem Value="227">Serbia</asp:ListItem>
                                                        <asp:ListItem Value="183">Seychelles</asp:ListItem>
                                                        <asp:ListItem Value="184">Sierra Leone</asp:ListItem>
                                                        <asp:ListItem Value="185">Singapore</asp:ListItem>
                                                        <asp:ListItem Value="186">Slovak Republic</asp:ListItem>
                                                        <asp:ListItem Value="187">Slovenia</asp:ListItem>
                                                        <asp:ListItem Value="189">Somalia</asp:ListItem>
                                                        <asp:ListItem Value="190">South Africa</asp:ListItem>
                                                        <asp:ListItem Value="191">South Korea</asp:ListItem>
                                                        <asp:ListItem Value="193">Spain</asp:ListItem>
                                                        <asp:ListItem Value="194">Sri Lanka</asp:ListItem>
                                                        <asp:ListItem Value="196">St. Pierre &amp; Miquelon</asp:ListItem>
                                                        <asp:ListItem Value="198">St.Kitts  Anguilla</asp:ListItem>
                                                        <asp:ListItem Value="199">St.Vinc. &amp; Grenadine</asp:ListItem>
                                                        <asp:ListItem Value="200">Sudan</asp:ListItem>
                                                        <asp:ListItem Value="201">Suriname</asp:ListItem>
                                                        <asp:ListItem Value="203">Swaziland</asp:ListItem>
                                                        <asp:ListItem Value="204">Sweden</asp:ListItem>
                                                        <asp:ListItem Value="205">Switzerland</asp:ListItem>
                                                        <asp:ListItem Value="206">Syria</asp:ListItem>
                                                        <asp:ListItem Value="207">Tadjikistan</asp:ListItem>
                                                        <asp:ListItem Value="208">Taiwan</asp:ListItem>
                                                        <asp:ListItem Value="209">Tanzania</asp:ListItem>
                                                        <asp:ListItem Value="210">Thailand</asp:ListItem>
                                                        <asp:ListItem Value="211">Togo</asp:ListItem>
                                                        <asp:ListItem Value="212">Tokelau</asp:ListItem>
                                                        <asp:ListItem Value="213">Tonga</asp:ListItem>
                                                        <asp:ListItem Value="214">Trinidad &amp; Tobago</asp:ListItem>
                                                        <asp:ListItem Value="215">Tunisia</asp:ListItem>
                                                        <asp:ListItem Value="216">Turkey</asp:ListItem>
                                                        <asp:ListItem Value="217">Turkmenistan</asp:ListItem>
                                                        <asp:ListItem Value="218">Turks &amp; Caicos Isles</asp:ListItem>
                                                        <asp:ListItem Value="221">Uganda</asp:ListItem>
                                                        <asp:ListItem Value="222">Ukraine</asp:ListItem>
                                                        <asp:ListItem Value="223">United Arab Emirates</asp:ListItem>
                                                        <asp:ListItem Value="220">US Minor outlying Isl.</asp:ListItem>
                                                        <asp:ListItem Value="230">Venezuela</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:requiredfieldvalidator runat="server" controltovalidate="Country" CssClass="failureNotification" tooltip="Country is required."
                                                id="CountryRequired" validationgroup="RegisterUserValidationGroup" errormessage="Country is required.">*</asp:requiredfieldvalidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:DropDownList id="BirthMonth" runat="server" CssClass="ddl">
                                                    <asp:ListItem Value="" selected="true">Birth Month</asp:ListItem>
                                                    <asp:ListItem Value="01">January</asp:ListItem> 
                                                    <asp:ListItem Value="02">February</asp:ListItem> 
                                                    <asp:ListItem Value="03">March</asp:ListItem> 
                                                    <asp:ListItem Value="04">April</asp:ListItem> 
                                                    <asp:ListItem Value="05">May</asp:ListItem> 
                                                    <asp:ListItem Value="06">June</asp:ListItem> 
                                                    <asp:ListItem Value="07">July</asp:ListItem> 
                                                    <asp:ListItem Value="08">August</asp:ListItem> 
                                                    <asp:ListItem Value="09">September</asp:ListItem> 
                                                    <asp:ListItem Value="10">October</asp:ListItem> 
                                                    <asp:ListItem Value="11">November</asp:ListItem> 
                                                    <asp:ListItem Value="12">December</asp:ListItem> 
                                                </asp:DropDownList>
                                                <asp:requiredfieldvalidator runat="server" controltovalidate="BirthMonth" CssClass="failureNotification" tooltip="Birth Month is required."
                                                id="BirthMonthRequired" validationgroup="RegisterUserValidationGroup" errormessage="Birth Month is required.">*</asp:requiredfieldvalidator>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:DropDownList id="BirthDay" runat="server" CssClass="ddl">
                                                    <asp:ListItem Value="" selected="true">Birth Day</asp:ListItem>
                                                    <asp:ListItem Value="01">1</asp:ListItem> 
                                                    <asp:ListItem Value="02">2</asp:ListItem> 
                                                    <asp:ListItem Value="03">3</asp:ListItem> 
                                                    <asp:ListItem Value="04">4</asp:ListItem> 
                                                    <asp:ListItem Value="05">5</asp:ListItem> 
                                                    <asp:ListItem Value="06">6</asp:ListItem> 
                                                    <asp:ListItem Value="07">7</asp:ListItem> 
                                                    <asp:ListItem Value="08">8</asp:ListItem> 
                                                    <asp:ListItem Value="09">9</asp:ListItem> 
                                                    <asp:ListItem Value="10">10</asp:ListItem> 
                                                    <asp:ListItem Value="11">11</asp:ListItem> 
                                                    <asp:ListItem Value="12">12</asp:ListItem> 
                                                    <asp:ListItem Value="13">13</asp:ListItem> 
                                                    <asp:ListItem Value="14">14</asp:ListItem> 
                                                    <asp:ListItem Value="15">15</asp:ListItem> 
                                                    <asp:ListItem Value="16">16</asp:ListItem> 
                                                    <asp:ListItem Value="17">17</asp:ListItem> 
                                                    <asp:ListItem Value="18">18</asp:ListItem> 
                                                    <asp:ListItem Value="19">19</asp:ListItem> 
                                                    <asp:ListItem Value="11">20</asp:ListItem> 
                                                    <asp:ListItem Value="21">21</asp:ListItem> 
                                                    <asp:ListItem Value="22">22</asp:ListItem> 
                                                    <asp:ListItem Value="23">23</asp:ListItem> 
                                                    <asp:ListItem Value="24">24</asp:ListItem> 
                                                    <asp:ListItem Value="25">25</asp:ListItem> 
                                                    <asp:ListItem Value="26">26</asp:ListItem> 
                                                    <asp:ListItem Value="27">27</asp:ListItem> 
                                                    <asp:ListItem Value="28">28</asp:ListItem> 
                                                    <asp:ListItem Value="29">29</asp:ListItem> 
                                                    <asp:ListItem Value="30">30</asp:ListItem> 
                                                    <asp:ListItem Value="31">31</asp:ListItem> 
                                                </asp:DropDownList>
                                                <asp:requiredfieldvalidator runat="server" controltovalidate="BirthDay" CssClass="failureNotification" tooltip="Birth Day is required."
                                                id="BirthDayRequired" validationgroup="RegisterUserValidationGroup" errormessage="Birth Day is required.">*</asp:requiredfieldvalidator>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:DropDownList id="BirthYear" runat="server" CssClass="ddl">
                                                    <asp:ListItem Value="" selected="true">Birth Year</asp:ListItem>
                                                    <asp:ListItem Value="1997">1993</asp:ListItem>
                                                    <asp:ListItem Value="1996">1993</asp:ListItem>
                                                    <asp:ListItem Value="1995">1993</asp:ListItem>
                                                    <asp:ListItem Value="1994">1993</asp:ListItem>
                                                    <asp:ListItem Value="1993">1993</asp:ListItem>
                                                    <asp:ListItem Value="1992">1992</asp:ListItem>
                                                    <asp:ListItem Value="1991">1991</asp:ListItem>
                                                    <asp:ListItem Value="1990">1990</asp:ListItem>
                                                    <asp:ListItem Value="1989">1989</asp:ListItem>
                                                    <asp:ListItem Value="1988">1988</asp:ListItem>
                                                    <asp:ListItem Value="1987">1987</asp:ListItem>
                                                    <asp:ListItem Value="1986">1986</asp:ListItem>
                                                    <asp:ListItem Value="1985">1985</asp:ListItem>
                                                    <asp:ListItem Value="1984">1984</asp:ListItem>
                                                    <asp:ListItem Value="1983">1983</asp:ListItem>
                                                    <asp:ListItem Value="1982">1982</asp:ListItem>
                                                    <asp:ListItem Value="1981">1981</asp:ListItem>
                                                    <asp:ListItem Value="1980">1980</asp:ListItem>
                                                    <asp:ListItem Value="1979">1979</asp:ListItem>
                                                    <asp:ListItem Value="1978">1978</asp:ListItem>
                                                    <asp:ListItem Value="1977">1977</asp:ListItem>
                                                    <asp:ListItem Value="1976">1976</asp:ListItem>
                                                    <asp:ListItem Value="1975">1975</asp:ListItem>
                                                    <asp:ListItem Value="1974">1974</asp:ListItem>
                                                    <asp:ListItem Value="1973">1973</asp:ListItem>
                                                    <asp:ListItem Value="1972">1972</asp:ListItem>
                                                    <asp:ListItem Value="1971">1971</asp:ListItem>
                                                    <asp:ListItem Value="1970">1970</asp:ListItem>
                                                    <asp:ListItem Value="1969">1969</asp:ListItem>
                                                    <asp:ListItem Value="1968">1968</asp:ListItem>
                                                    <asp:ListItem Value="1967">1967</asp:ListItem>
                                                    <asp:ListItem Value="1966">1966</asp:ListItem>
                                                    <asp:ListItem Value="1965">1965</asp:ListItem>
                                                    <asp:ListItem Value="1964">1964</asp:ListItem>
                                                    <asp:ListItem Value="1963">1963</asp:ListItem>
                                                    <asp:ListItem Value="1962">1962</asp:ListItem>
                                                    <asp:ListItem Value="1961">1961</asp:ListItem>
                                                    <asp:ListItem Value="1960">1960</asp:ListItem>
                                                    <asp:ListItem Value="1959">1959</asp:ListItem>
                                                    <asp:ListItem Value="1958">1958</asp:ListItem>
                                                    <asp:ListItem Value="1957">1957</asp:ListItem>
                                                    <asp:ListItem Value="1956">1956</asp:ListItem>
                                                    <asp:ListItem Value="1955">1955</asp:ListItem>
                                                    <asp:ListItem Value="1954">1954</asp:ListItem>
                                                    <asp:ListItem Value="1953">1953</asp:ListItem>
                                                    <asp:ListItem Value="1952">1952</asp:ListItem>
                                                    <asp:ListItem Value="1951">1951</asp:ListItem>
                                                    <asp:ListItem Value="1950">1950</asp:ListItem>
                                                    <asp:ListItem Value="1949">1949</asp:ListItem>
                                                    <asp:ListItem Value="1948">1948</asp:ListItem>
                                                    <asp:ListItem Value="1947">1947</asp:ListItem>
                                                    <asp:ListItem Value="1946">1946</asp:ListItem>
                                                    <asp:ListItem Value="1945">1945</asp:ListItem>
                                                    <asp:ListItem Value="1944">1944</asp:ListItem>
                                                    <asp:ListItem Value="1943">1943</asp:ListItem>
                                                    <asp:ListItem Value="1942">1942</asp:ListItem>
                                                    <asp:ListItem Value="1941">1941</asp:ListItem>
                                                    <asp:ListItem Value="1940">1940</asp:ListItem>
                                                    <asp:ListItem Value="1939">1939</asp:ListItem>
                                                    <asp:ListItem Value="1938">1938</asp:ListItem>
                                                    <asp:ListItem Value="1937">1937</asp:ListItem>
                                                    <asp:ListItem Value="1936">1936</asp:ListItem>
                                                    <asp:ListItem Value="1935">1935</asp:ListItem>
                                                    <asp:ListItem Value="1934">1934</asp:ListItem>
                                                    <asp:ListItem Value="1933">1933</asp:ListItem>
                                                    <asp:ListItem Value="1932">1932</asp:ListItem>
                                                    <asp:ListItem Value="1931">1931</asp:ListItem>
                                                    <asp:ListItem Value="1930">1930</asp:ListItem>
                                                    <asp:ListItem Value="1929">1929</asp:ListItem>
                                                    <asp:ListItem Value="1928">1928</asp:ListItem>
                                                    <asp:ListItem Value="1927">1927</asp:ListItem>
                                                    <asp:ListItem Value="1926">1926</asp:ListItem>
                                                    <asp:ListItem Value="1925">1925</asp:ListItem>
                                                    <asp:ListItem Value="1924">1924</asp:ListItem>
                                                    <asp:ListItem Value="1923">1923</asp:ListItem>
                                                    <asp:ListItem Value="1922">1922</asp:ListItem>
                                                    <asp:ListItem Value="1921">1921</asp:ListItem>
                                                    <asp:ListItem Value="1920">1920</asp:ListItem>
                                                    <asp:ListItem Value="1919">1919</asp:ListItem>
                                                    <asp:ListItem Value="1918">1918</asp:ListItem>
                                                    <asp:ListItem Value="1917">1917</asp:ListItem>
                                                    <asp:ListItem Value="1916">1916</asp:ListItem>
                                                    <asp:ListItem Value="1915">1915</asp:ListItem>
                                                    <asp:ListItem Value="1914">1914</asp:ListItem>
                                                    <asp:ListItem Value="1913">1913</asp:ListItem>
                                                    <asp:ListItem Value="1912">1912</asp:ListItem>
                                                    <asp:ListItem Value="1911">1911</asp:ListItem>
                                                    <asp:ListItem Value="1910">1910</asp:ListItem>
                                                    <asp:ListItem Value="1909">1909</asp:ListItem>
                                                    <asp:ListItem Value="1908">1908</asp:ListItem>
                                                    <asp:ListItem Value="1907">1907</asp:ListItem>
                                                    <asp:ListItem Value="1906">1906</asp:ListItem>
                                                    <asp:ListItem Value="1905">1905</asp:ListItem>
                                                    <asp:ListItem Value="1904">1904</asp:ListItem>
                                                    <asp:ListItem Value="1903">1903</asp:ListItem>
                                                    <asp:ListItem Value="1902">1902</asp:ListItem>
                                                    <asp:ListItem Value="1901">1901</asp:ListItem>
                                                    <asp:ListItem Value="1900">1900</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:requiredfieldvalidator runat="server" controltovalidate="BirthYear" CssClass="failureNotification" tooltip="Birth Year is required."
                                                id="BirthYearRequired" validationgroup="RegisterUserValidationGroup" errormessage="Birth Year is required.">*</asp:requiredfieldvalidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:DropDownList id="Gender" runat="server" CssClass="ddl">
                                                    <asp:ListItem Value="" selected="true">Gender</asp:ListItem>
                                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:requiredfieldvalidator runat="server" controltovalidate="Gender" CssClass="failureNotification" tooltip="Gender is required."
                                                id="GenderRequired" validationgroup="RegisterUserValidationGroup" errormessage="Gender is required.">*</asp:requiredfieldvalidator>
                                            </td>
                                        </tr>
                                    </table>
                                    <center>
                                    <p>
                                        <asp:CheckBox ID="AcceptTermsCheckBox" CssClass="green" runat="server" TextAlign="right" Checked="False" Text="I agree to abide by Peashake House " />
                                        <a href="#" onclick="showDisclaimer()">rules</a>&nbsp;
                                        <skm:CheckBoxValidator runat="server" id="AcceptTermsValidator" ControlToValidate="AcceptTermsCheckBox" 
                                            Display="Dynamic" ErrorMessage='You must agree to the terms of service before you can continue.' 
                                            validationgroup="RegisterUserValidationGroup" AssociatedButtonControlId="CreateUserButton" 
                                            MustBeChecked="True">*</skm:CheckBoxValidator>
                                        <asp:ImageButton ID="CreateUserButton" runat="server" CommandName="MoveNext" ImageUrl="~/Images/Buttons/createuser.gif"  
                                                ValidationGroup="RegisterUserValidationGroup" style="vertical-align:middle;" />
                                    </p>
                                    <p>
                                        <span class="failureNotification">
                                            <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                                        </span>
                                        <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="failureNotification" 
                                                ValidationGroup="RegisterUserValidationGroup"/>
                                    </p>
                                    </center>
                                </div>
                            </ContentTemplate>
                            <CustomNavigationTemplate>
                            </CustomNavigationTemplate>
                        </asp:CreateUserWizardStep>
                    </WizardSteps>
                </asp:CreateUserWizard>
                </div>
            </div>
        </div>
        <uc1:Legal ID="Legal1" runat="server" />
        <uc2:privacy ID="Privacy" runat="server" />
    </form>
</body>
</html>
