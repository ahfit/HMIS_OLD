<%@ Page Language="C#" %>

<%@ Register Assembly="OnBarcode.Barcode.ASPNET" Namespace="OnBarcode.Barcode.ASPNET"
    TagPrefix="cc1" %>
<%@ Import Namespace="OnBarcode.Barcode.ASPNET" %>
<%
	LinearWebStream.drawBarcode(Request, Response);
%>

