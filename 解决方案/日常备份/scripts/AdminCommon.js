$(function () {
    //弹出检索对话框
    $(".shortcut-buttons-set > li#record-filter > a").click(function () {
        $("#dialog-condition-box").dialog({
            autoOpen: false,
            modal: true,
            width: 600,
            hide: 'puff', //blind,clip,drop,explode,fold,puff,slide,scale,size,pulsate
            show: 'puff',
            buttons: {
                "提交": function () {
                    $(this).dialog("close");
                    $("#MainForm").submit();
                },
                "取消": function () {
                    $(this).dialog("close");
                }
            }
        });
        $("#dialog:ui-dialog").dialog("destroy");
        $("#dialog-condition-box").dialog('open');
        return false;
    });

    //弹出图书编辑对话框
    $(".addbought").click(function () {
        var doi = $(this).data("id");
        $.ajax({
            url: "/admin/Book/GetDetail",
            type: "get",
            data: { id: doi },
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    $("input[name=OtherLiable]").val(data.model.OtherLiable);
                    $("input[name=OtherLiableDesc]").val(data.model.OtherLiableDesc);
                    $("input[name=OtherLiableForm]").val(data.model.OtherLiableForm);
                    $("input[name=ENLiabilityForm]").val(data.model.ENLiabilityForm);
                }
            }
        });
        $("#edit-book").dialog({
            autoOpen: false,
            modal: true,
            width: 600,
            hide: 'puff', //blind,clip,drop,explode,fold,puff,slide,scale,size,pulsate
            show: 'puff',
            buttons: {
                "提交": function () {

                    $(this).dialog("close");
                    $("#AddForm").submit();
                },
                "取消": function () {
                    $(this).dialog("close");
                }
            }
        });
        $("input[name=Doi]").val(doi);
        $("#dialog:ui-dialog").dialog("destroy");
        $("#edit-book").dialog('open');
        return false;
    });


    //管理纸质图书 设置图书分类
    $(".CLASSFICATION").click(function () {
        $this = $(this);
        var i = $this.context.children[1].id;
        var j = $this.context.children[2].id;
        // console.log($("#CLASSFICATIONDOI").val());
        console.log($this.context.children[1].attributes[3].nodeValue)
        var classficationdoi = $this.context.children[1].attributes[3].nodeValue;
        layer.open({
            type: 2,
            title: '分类列表',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['550px', '600px'],
            btn: ['确认', '取消'],
            offset: 'auto', //右下角弹出
            shift: 2,
            content: ['/Admin/Theme/ChooseList?type=1&dois=' + classficationdoi+'&i='+i+'&j='+j, 'yes'], //iframe的url，no代表不显示滚动条
            cancel: function (index) {
                window.location.reload();
                layer.close(index);
                //this.content.show();
                //closeall();
            },
            yes: function (index) {
                //var classifyId = $("#CLASSFICATIONDOI").val();
                var classifyId = $("#" + i + "").val();
                // var classifyId = classficationdoi
                var doi = $this.data("doi");
                $.ajax({
                    url: '/Admin/Book/Classification',
                    async: false,
                    data: { Doi: doi, Id: classifyId },
                    success: function (data) {
                        if (data.success) {
                            $(".table-checkbox[value=" + doi + "]").closest("tr").remove();
                            layer.alert('设置分类成功！', function () {
                                window.location.reload();
                            });
                        } else {
                            layer.alert("设置分类失败！");
                        }
                    }
                });
                layer.close(index);
            },
            btn2: function (index) {
                window.location.reload();
                layer.closeAll(index); //关闭当前窗口
            },
            no: function (index) {
                layer.close(index);
            }
        });
    });


})