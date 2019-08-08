/*
 * 分页
 */
function pageSet(count, submitEvent, tag, recordCount) {
    var c = Number(count),
        r = Number(recordCount == undefined ? 0 : recordCount),
        i = Number($("input[name='Page']").val());
    var fun = function (pNo) {
        $("input[name='Page']").val(pNo);
        submitEvent.call();
    };
    var href_tag = (tag == 1 ? "#show" : "#");
    (function (c, i, fun) {
        if (isNaN(c) || c == 1 || c == 0) {
            $("#pages").html("");
            return;
        }

        var strPre = "",
            strPage = "",
            strSuf = "",
            strGoto = "";

        //起始页
        var s = 1;
        if (i < 4 || c < 6) {
            s = 1;
        } else if (i > c - 3) {
            s = c - 4;
        } else {
            s = i - 2;
        }

        //添加 首页，上一页，...
        if (1 == i) {
            if (r == 0) {
                strPre += "<span>共<span style='color:#ae0e16'>" + c + "</span>页</span> <a href='" + href_tag + "' class='page-bd'>首页</a> <a href='" + href_tag + "' class='page-bd'>上一页</a>";
            } else {
                strPre += "<span>共<span style='color:#ae0e16'>" + r + "</span>条数据</span> <span>共<span style='color:#ae0e16'>" + c + "</span>页</span> <a href='" + href_tag + "' class='page-bd'>首页</a> <a href='" + href_tag + "' class='page-bd'>上一页</a>";
            }
        } else {
            if (r == 0) {
                strPre += "<span>共<span style='color:#ae0e16'>" + c + "</span>页</span> <a href='" + href_tag + "' data-page='" + 1 + "' class='page-bd'>首页</a> <a href='" + href_tag + "'  data-page='" + (i - 1) + "' class='page-bd'>上一页</a>";
            } else {
                strPre += "<span>共<span style='color:#ae0e16'>" + r + "</span>条数据</span> <span>共<span style='color:#ae0e16'>" + c + "</span>页</span> <a href='" + href_tag + "' data-page='" + 1 + "' class='page-bd'>首页</a> <a href='" + href_tag + "'  data-page='" + (i - 1) + "' class='page-bd'>上一页</a>";
            }
        }
        if (s > 1 && c > 5) {
            strPre += "<a href='" + href_tag + "' data-page='" + (s > 3 ? s - 3 : 1) + "'>...</a>";
        }

        //添加 页码
        for (var j = s, len = 5 + s; j <= c && j < len; j++) {
            strPage += j == i ? ("<a class='cur_page nolink' href='" + href_tag + "'>" + j + "</a>") :
                ("<a href='" + href_tag + "' data-page='" + j + "'>" + j + "</a>");
        }

        //添加 ...，下一页，尾页
        if (s < c - 4) {
            strSuf += "<a href='" + href_tag + "' data-page='" + (s + 7 > c ? c : s + 7) + "'>...</a><a href='" + href_tag + "' data-page='" + c + "'>" + c + "</a>";
        }
        if (i == c) {
            strSuf += "<a href='" + href_tag + "' class='page-bd'>下一页</a> <a href='" + href_tag + "' class='page-bd'>末页</a>";
        } else {
            strSuf += "<a href='" + href_tag + "' data-page='" + (i + 1) + "' class='page-bd'>下一页</a> <a href='" + href_tag + "' data-page='" + c + "' class='page-bd'>末页</a>";
        }

        //添加 跳转
        strGoto = "<span>跳转到</span> <input type='text' class='txt-page'/> <span>页</span> <button>跳转</button>";

        //页面点击
        $("#pages").html(strPre + strPage + strSuf + strGoto).unbind().click(function (e) {
            var t = (e || window.event).target;
            if (t && t.nodeName == "A") {
                var page = Number($(t).data("page") || $(t).attr("data-page"));
                if (!isNaN(page)) {
                    $(this).unbind();
                    fun.call(this, page);
                }
            }
            if (t && t.nodeName == "BUTTON") {
                var page = Number($(".txt-page").val());
                if (page > 0 && page <= c) {
                    $(this).unbind();
                    fun.call(this, page);
                    scroll($("#pages").offset().top, $("#pages").offset().left);
                }
                else {
                    alert("超出索引");
                }
            }
        });
    })(c, i, fun);
}