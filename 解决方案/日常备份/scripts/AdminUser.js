
$(function () {


    //删除单个用户
    $(".delete").click(function () {
        var id = $(this).attr("data-id");
        if (id != '' && id != null) {
            if (confirm("您确定要删除此项吗？")) {
                searchUserDelete(id);
            }
        }
    });

    //密码重置
    $(".resetPwd").click(function () {
        var id = $(this).attr("data-id");
        if (id != '' && id != null) {
            if (confirm("您确定要重置密码为jncb0000吗？")) {
                searchUserResetPwd(id);
            }
        }
    });

    //批量删除
    $(".lxbAllDel").click(function () {
        var ids = GetSelectedUserValues();
        if (ids.length>0) {
            if (confirm("您确定要删除所有选中项吗？")) {
           
                DeleteSelectedUser(ids);
            }
        }
    });
    $(".modify").click(function () {
        var id = $(this).attr("data-id");
        window.open("/Admin/User/Edit?UserName=" + id);
    });
})

///删除单个用户
function searchUserDelete(id) {
    $.ajax({
        url: "/Admin/User/Delete",
        type: "POST",
        dataType: "json",
        data: { UserName: id },
      
        success: function myfunction(json) {
            if (json.Success) {
                    $(".table-checkbox[value=" + id + "]").closest("tr").remove();
                    alert("删除成功！");
            } else {
               alert("删除失败，请重试");
            }
        }
    });
}



///用户重置密码
function searchUserResetPwd(id) {
    $.ajax({
        url: "/Admin/User/ResetPwd",
        type: "POST",
        dataType: "json",
        data: { UserName: id },

        success: function myfunction(json) {
            if (json.Success) {
                alert("密码重置成功！");
            } else {
                alert("密码重置失败，请重试");
            }
        }
    });
}

///获取批量删除选择项
function GetSelectedUserValues() {

    var useridlist = new Array();
    var idArray = new Array()
    $('input[type=checkbox]').each(function (i, item) {
        if (this.checked == true) {
            var userid = $(item).attr("value");
            useridlist.push(userid);
            idArray = useridlist.join(",");
        }
    })
    return idArray;
}

///调用批量删除方法
function DeleteSelectedUser(ids) {
    var uArray =new Array();
    $.ajax({
        url: "/Admin/User/AllDelete",
        type: "POST",
        dataType: "json",
        data: { UserNames: ids },
       
        success: function myfunction(json) {
            if (json.Success) {
                uArray = ids.split(',');
                $.each(uArray, function (i) {
                    $(".table-checkbox[value=" + uArray[i] + "]").closest("tr").remove();
                });
            } else {
                alert("删除失败，请重试");
            }
        }
    });
}

function AddValidator()
{
    ///添加自定义用户验证
    $.validator.addMethod("isusername", function (value, element) {
        return this.optional(element) || /^([a-zA-Z0-9]{6,30}|[_]{6,30}|[\u4E00-\u9FA5]{6,15})$/.test(value);
    }, "用户名必须在6-30个字符间,不能有特殊字符");
    $.validator.addMethod("isrealname", function (value, element) {
        return this.optional(element) || /^([a-zA-Z0-9]{2,30}|[_]{2,30}|[\u4E00-\u9FA5]{1,15})$/.test(value);
    }, "真实姓名必须在2-30个字符间,不能有特殊字符");
    ///validate插件，登陆验证
    $("#User_form").validate({
        event: "blur",
        submitHandler: function (form) {
            form.submit();
        },
        onfocusout: function (element) {
            $(element).parents(".form-group:first").removeClass("has-error");
            $(element).valid();
        },
        onkeyup: false,
        focusInvalid: false,
        rules: {
            UserName: {
                required: true,
                isusername: true,
                remote: {
                    url: "/User/ExistsUserName",
                    cache: false,
                    dataType: "text"
                    //data: {
                    //    username: $("#username").val()
                    //}
                }
            },
            NickName: {
                required: true,
                isusername: true
            },
            RealName: {
                isrealname: true,
                required: true
            },
            Email: {
                required: true,
                email: true
            },
            TelePhone: {
                required: true
            }

        },
        messages: {
            UserName: {
                required: "用户名不能为空",
                remote: "用户名已经存在"
            },
            NickName: {
                required: "昵称不能为空"
            },
            RealName: {
                required: "真实姓名不能为空"
            },
            Email: {
                required: "请填写有效的电子邮件地址",
                email: "请输入正确格式的电子邮件"

            },
            TelePhone: {
                required: "请填写有效的电话号码"
            }
        },

        errorPlacement: function (error, element) {

            var errorText = $(error).text();
            if (errorText == "false") {
                if ($(element).parent().children().hasClass("help-inline")) {
                    $(element).parent().append("");
                }
                else {
                    $(element).parent().append("<span class='help-inline'>用户名已经存在</span>");
                }
            } else {
                $(element).parent().append(error);
            }
        }

    });


}