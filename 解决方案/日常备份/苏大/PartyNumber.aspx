<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/WebMaster.Master" AutoEventWireup="true" CodeBehind="PartyNumber.aspx.cs" Inherits="SZUOfficalWebsite.Pages.PartyNumber" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(function () {
            selectNav(11);
            $(".rellists p a").click(function () {
                var url = $(this).attr("class");
                $("#ifrAboutus").attr("src", url);
                $(this).closest("p").addClass("actived").siblings().removeClass("actived");
            })

            $(".rellists p:nth-child(" +<%=id%> + ")").children("a").click();
        })
        function setIframeHeight(iframe) {
            if (iframe) {
                var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow;
                if (iframeWin.document.body) {
                    iframe.height = iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight;
                }
            }
        };
    </script>

    <link href="../css/Entry.css" rel="stylesheet" type="text/css" />
    <link href="../css/pagecontrol.css" rel="stylesheet" type="text/css" />
    <script src="../js/base.js"></script>
    <style>
        .Block_Left_Head a {
            cursor: pointer;
        }

        .bct-right p {
            text-indent: 2em;
        }

        .bct-right {
            color: #3F3F3F;
            font-size: 12px;
            line-height: 26px;
            padding: 15px 0 0;
            text-align: justify;
            border: 1px solid #d3d3d3;
            /*text-indent: 2em;*/
        }

        body a p {
            font-family: "宋体","Times New Roman",Times,serif;
        }

        .Block_Left_Head h3 {
            background:url("../images/classify.png") no-repeat scroll 0 0;
            color: #fff;
            font-family: "微软雅黑";
            font-size: 16px;
            height: 30px;
            line-height: 30px;
            text-align: center;
        }
        .inner-left {
        padding:0px !important;
        }
        .ZHindex_Container {
            width: 1000px;
            margin-top: 15px;
        }

        .inner-left {
            width: 170px !important;
            margin-left: 25px;
        }
        .Block_Left {
            border: 1px solid #E3E4E8;
        }
        .rellists {
            padding-bottom: 7px;
            /*padding-left: 6px;*/
            width: 170px;
        }

            .rellists p {
                font-size: 14px;
                /*margin-left: 25px;*/
                border-top: 1px solid #E3E4E8;
                height: 47px;
            }

            .rellists a {
                color:#848484;
                font-size: 14px;
                height: 35px;
                line-height: 47px;
                margin-left: 45px;
                padding-right: 5px;
            }
        .actived {
            background:url("../images/classify_icon.jpg") no-repeat scroll 138px center;
        }
            .actived a {
                color:#3F3F3F;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Button ID="btnSub" runat="server" Text="Button" OnClick="btnSub_Click" Style="display: none" />
    <asp:HiddenField ID="hidType" runat="server" />
    <div class="wrapper ZHindex_Container">
        <div id="TemContent">
            <div class="inner wrapper">
                <div class="inner-left">
                    <div class="Block_Left">
                        <div class="Block_Left_Head">
                            <h3>党员驿站</h3>
                            <div class="rellists">
                                <asp:Literal ID="ltNav" runat="server"></asp:Literal>

                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="bct-right">
                    <iframe id="ifrAboutus" name="ifrAboutus" scrolling="no" frameborder="no" onload="setIframeHeight(this)" border="0" width="100%"></iframe>
                    <%--<uc1:ZDAboutUsView runat="server" ID="ZDAboutUsView" />--%>
                </div>
            </div>
        </div>
    </div>
    <div style="clear: both;"></div>
</asp:Content>
