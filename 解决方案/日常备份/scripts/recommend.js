$(function () {
    ///初始化推荐分类
    if ($(".recommendtree").hasClass("Actives")) {
        var flag = $(".themeTree .Actives").data("flag");
        getChildList(flag);
    }
    ///选中推荐的分类，展示推荐的具体内容
    $(".recommendtree").each(function (i, item) {
        $(this).on("click", function () {
            $(this).siblings().removeClass("Actives");
            $(this).addClass("Actives");
            var flag = $(this).data("flag");
            getChildList(flag);

        })
    })

    $("#btnAdd").on("click", function () {
        var type = $(".themeTree .Actives").data("type");
        var flag = $(".themeTree .Actives").data("flag");
        var key = "";
        getResourceList(flag, type, 1, key);
    })

    $("#btnClose").on("click", function () {
        $("#dialog-recommend-box").hide();
        $(".checkBoxList input[type='checkbox']").attr("checked", false);
    });

    $("#btnYes").on("click", function () {
        $("#dialog-recommend-box").hide();
        var arr = new Array();
        $(".checkBoxList input[type=checkbox]:checked").each(function (i, item) {
            var ResData = new ResDetail();
            ResData.doi = $(this).data("doi");
            ResData.name = $(this).data("text");
            arr.push(ResData);
        });
        if (arr.length > 0) {
            for (var i = 0; i < arr.length; i++) {
                $("#ChildList").append("<li data-name='" + arr[i].name + "' data-doi='" + arr[i].doi + "'>" + arr[i].name + "</li>")
            }
        }
        $(".checkBoxList input[type='checkbox']").attr("checked", false);
    });

    $("#btnNo").on("click", function () {
        $("#dialog-recommend-box").hide();
        $(".checkBoxList input[type='checkbox']").attr("checked", false);
    });

    $("#btnOk").on("click", function () {
        var arr = new Array();
        var length = $("#ChildList li").length;
        var flag = $(".themeTree .Actives").data("flag");
        if (length > 0) {
            $("#ChildList li").each(function (i, item) {
                var name = $(this).data("name");
                var doi = $(this).data("doi");
                var json = "{'order':" + i + ",'name':'" + name + "','doi':'" + doi + "'}";
                arr.push(json);
            })
            saveRecommend(arr, flag);
        } else {
            saveRecommend(arr, flag);
        }
    })
    //添加窗口的检索
    $(".hzsch-btn").click(function () {
        var type = $(".themeTree .Actives").data("type");
        var flag = $(".themeTree .Actives").data("flag");
        var key = $("#keyword").val();
        getResourceList(flag, type, 1, key);
    });
    //$("#sevenListTree").each(function (i, item) {
    //    $(this).on("click", function () {
    //        $(this).siblings().removeClass("Actives");
    //        $(this).addClass("Actives");
    //    })
    //})

    //绑定事件到父节点，因为是请求后Append的数据，直接写click事件不触发
    $("#sevenListTree").click(function () {
        //获取第一个参数
        var event = arguments[0];
        if (event) {
            var target = event.target;
            //当前点击的节点为Input时候
            if (target && target.nodeName.toLowerCase() == 'li') {
                //var obj = $(target);
                $(target).addClass("Actives").siblings().removeClass("Actives");;
            }
        }
    });

    //清空
    $("#btnDelAll").click(function () {
        $("#ChildList").empty();
    });

    //删除
    $("#btnDel").click(function () {
        $("#ChildList .Actives").remove()
    });

})

///获取推荐分类子节点
function getChildList(flag) {
    $("#ChildList").empty();
    $.ajax({
        url: "/admin/Recommend/GetListInfo",
        type: "post",
        data: { flag: flag },
        dataType: "json",
        success: (function (data) {
            if (data.Success) {

                $.each(data.Models.Models, function (i) {
                    $("#ChildList").append("<li data-name='" + data.Models.Models[i].name + "' data-order='" + data.Models.Models[i].order + "' data-doi='" + data.Models.Models[i].doi + "'>" + data.Models.Models[i].name + "</li>");
                })
            }
        })
    })
}
///获取选中的资源
function getResourceList(flag, type, page, key) {
    $.ajax({
        url: "/admin/Recommend/SearchResourceList",
        type: "post",
        data: { flag: flag, type: type, page: page, key: key },
        dataType: "json",
        success: (function (data) {
            if (data.Success) {
                $("#dialog-recommend-box").show();
                $(".checkBoxList").empty();
                $("#pageList").empty();
                $.each(data.Models.Models, function (i) {
                    if (data.Models.Models[i].IsChecked == 1) {
                        $(".checkBoxList").append("<label class='lbresource'><input checked='checked' type='checkbox' style='border: medium none;'  data-doi='" + data.Models.Models[i].Doi + "' data-text='" + data.Models.Models[i].Title + "'>" + data.Models.Models[i].Name + "</label>")
                    } else {
                        $(".checkBoxList").append("<label class='lbresource'><input type='checkbox' style='border: medium none;'  data-doi='" + data.Models.Models[i].Doi + "' data-text='" + data.Models.Models[i].Title + "'>" + data.Models.Models[i].Name + "</label>")
                    }
                })
                if (Number(data.Models.PageCount) > 2) {
                    var pageNo = page;
                    var nextPage = Number(pageNo) + 1;
                    if (parseInt(nextPage) > parseInt(data.PageCount)) {
                        nextPage = Number(pageNo);
                    }
                    if (parseInt(beforePage) <= 1) {
                        var beforePage = Number(pageNo);
                    }
                    var beforePage = Number(pageNo) - 1;
                    $("#pageList").append("<tr style='float:right;margin-right:30px;' id='pagination'><td  colspan='2'><a href='javascript:void(0);' onclick=\"getResourceList(" + flag + "," + type + ",1,'" + key + "')\">首页</a> <a href='javascript:void(0);' onclick=\"getResourceList(" + flag + "," + type + "," + beforePage + ",'" + key + "')\">上一页</a> <a href='javascript:void(0);' onclick=\"getResourceList(" + flag + "," + type + "," + nextPage + ",'" + key + "')\">下一页</a> <a href='javascript:void(0);' onclick=\"getResourceList(" + flag + "," + type + "," + data.Models.PageCount + ",'" + key + "')\">末页</a></td></tr>");
                }
                else {
                    $("#pageList").append("<tr style='float:right;margin-right:30px;' id='pagination'><td colspan='2'> <a href='javascript:void(0);' onclick=\"getResourceList(" + flag + "," + type + ",1,'" + key + "')\">首页</a>  <a href='javascript:void(0);' onclick=\"getResourceList(" + flag + "," + type + "," + data.Models.PageCount + ",'" + key + "')\">末页</a></td></tr>");
                }
            }
        })
    })
}

function ResDetail() {
    var doi = "";
    var name = "";
}

function saveRecommend(json, flag) {
    json = "[" + json.join(",") + "]";
    $.ajax({
        url: "/admin/Recommend/SaveRecommend",
        type: "post",
        data: { json: json, flag: flag },
        dataType: "json",
        success: (function (data) {
            if (data.Success) {
                alert("推荐成功！");
            }
        })
    })
}

function Change(index) {
    var obj = $("[id$=ChildList]")
    var len = $('[id$=ChildList] li').length;
    var selectitem = $("[id$=ChildList] .Actives");
    var checkIndex = selectitem.index() + 1; //获取Select选择的索引值
    if (index == 0) {
        if (checkIndex == 1) {
            layer.alert("当前推荐已是第一条！");
            return;
        }
    }
    if (index == 2) {
        if (checkIndex == len) {
            layer.alert("当前推荐已是最后一条！");
            return;
        }
    }
    if (index == -1) {
        if (checkIndex > 0) {
            selectitem.insertBefore(selectitem.prev());
        }
    }
    else if (index == 1) {
        //alert(checkIndex);
        if (checkIndex < len - 1) {
            selectitem.insertAfter(selectitem.next());
        }
    } else if (index == 0) {
        selectitem.insertBefore($("[id$=ChildList] li:eq(1)").prev());

    } else if (index == 2) {
        selectitem.insertAfter($("[id$=ChildList] li:eq(" + (len - 2) + ")").next());
    }
}