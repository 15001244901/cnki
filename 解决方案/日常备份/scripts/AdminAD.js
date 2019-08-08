$(function () {
    //删除单个
    $(".delete").click(function () {
        var id = $(this).attr("data-id");
        if (id != '' && id != null) {
            if (confirm("您确定要删除此项吗？")) {
                searchADDelete(id);
            }
        }
    });
    //批量删除
    $(".lxbAllDel").click(function () {
        var ids = GetSelectedValues();
        if (ids.length > 0) {
            if (confirm("您确定要删除所有选中项吗？")) {
                DeleteSelected(ids);
            }
        }
    });
    //单个启用
    $(".reuse").click(function () {
        var id = $(this).attr("data-id");
        if (id != '' && id != null) {
            ResetState(id, 1);
        }
    });

    //单个禁用
    $(".nouse").click(function () {
        var id = $(this).attr("data-id");
        if (id != '' && id != null) {
            ResetState(id, 0);
        }
    });

    //图书出版页广告
    $("#adBook").click(function () {
        var PAGEPALCE = $(this).data("pagepalce");
        location.href = "/Admin/AD/List?PAGEPALCE='" + PAGEPALCE + "'";
    })
    //首页广告
    $("#adHome").click(function () {
        var PAGEPALCE = $(this).data("pagepalce");
        location.href = "/Admin/AD/List?PAGEPALCE='" + PAGEPALCE + "'";
    })

    //上移书单列表
    $(".up").click(function () {
        var id = $(this).data("id");
        var PAGEPALCE = $(this).data("pagepalce");
        if (PAGEPALCE == "首页") {
            PAGEPALCE = "0";
        } else {
            PAGEPALCE = "1";
        }
        if (id != null && id != '') {
            SingleADUp(id,PAGEPALCE);
        }
    });
    //下移书单列表
    $(".down").click(function () {
        var id = $(this).data("id");
        var PAGEPALCE = $(this).data("pagepalce");
        if (PAGEPALCE == "首页") {
            PAGEPALCE = "0"
        } else {
            PAGEPALCE = "1";
        }
        if (id != null && id != '') {
            SingleADDown(id,PAGEPALCE);
        }
    });

})
///删除单个
function searchADDelete(id) {
    $.post("/Admin/AD/Delete", { id: id }, function (data) {
        if (data.Success) {
            $(".table-checkbox[value=" + id + "]").closest("tr").remove();
            alert("删除成功！");
        } else {
            alert("删除失败，请重试");
        }
    })
}
///获取批量删除选择项
function GetSelectedValues() {
    var videoidlist = new Array();
    var idArray = new Array()
    $('input[type=checkbox]').each(function (i, item) {
        if (this.checked == true) {
            var userid = $(item).attr("value");
            videoidlist.push(userid);
            idArray = videoidlist.join(";");
        }
    })
    return idArray;
}
///调用批量删除方法
function DeleteSelected(ids) {
    var uArray = new Array();
    $.ajax({
        url: "/Admin/AD/AllDelete",
        type: "POST",
        dataType: "json",
        data: { ids: ids },

        success: function myfunction(json) {
            if (json.Success) {
                uArray = ids.split(';');
                $.each(uArray, function (i) {
                    $(".table-checkbox[value=" + uArray[i] + "]").closest("tr").remove();
                });
                alert("删除成功！");
            } else {
                alert("删除失败，请重试");
            }
        }
    });
}
///设置状态
function ResetState(id, state) {
    $.ajax({
        url: "/Admin/AD/UpdateAttr",
        type: "POST",
        dataType: "json",
        data: { id: id, AttrValue: state },
        success: function myfunction(json) {
            if (json.Success) {
                if (state == 1) {
                    alert("启用成功！");
                    window.location.reload();
                }
                else {
                    alert("禁用成功！");
                    window.location.reload();
                }
            } else {
                if (state == 1) {
                    alert("启用失败！");
                }
                else {
                    alert("禁用失败！");
                }
            }
        }
    });
}

//上移
function SingleADUp(id, PAGEPALCE) {
    $.ajax({
        url: "/Admin/AD/AdUp",
        type: "POST",
        dataType: "json",
        data: { id: id, PAGEPALCE: PAGEPALCE },
        success: function myfunction(json) {
            if (json.success) {
                window.location.reload();
            } else {
                if (json.msg == "1") {
                    layer.alert("当前项目位于第一个！");
                } else {
                    layer.alert("上移失败，请重试");
                }
            }
        }
    });
}
//下移
function SingleADDown(id,PAGEPALCE) {
    $.ajax({
        url: "/Admin/AD/AdDown",
        type: "POST",
        dataType: "json",
        data: { id: id, PAGEPALCE: PAGEPALCE },
        success: function myfunction(json) {
            if (json.success) {
                window.location.reload();
            } else {
                if (json.msg == "1") {
                    layer.alert("当前项目位于最后一个！");
                } else {
                    layer.alert("下移失败，请重试");
                }
            }
        }
    });
}
