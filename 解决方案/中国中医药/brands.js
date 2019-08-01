$(function () {
    //获得导航
    GetBrands();
    
    //详情
    $("#smenu").on("click", "a", function () {
        $(this).addClass("selected").siblings().removeClass("selected");
        $(this).parent().siblings().children('a').removeClass('selected')
        var id = $(this).data("cls");
        BrandsGetContent(id)
    })
})
//导航
var template_cls = "<a href='javascript:void(0);' data-cls='{{id}}'class='' >{{name}}</a>";
function GetBrands() {
    $.ajax({
        url: "/Brands/GetBrands",
        dataType: "json",
        type: "post",
        success: function (data) {
            if (data != null && data.length > 0) {
                var str = "<div class='soChange'>"
                $.each(data, function (i, item) {
                    if (i % 4 == 0 && i != 0) {
                        str += "</div><div class='soChange'>";
                    }
                    str += Mustache.render(template_cls, item);
                })
                $("#smenu").append(str);
                $("#smenu .soChange").soChange({
                    thumbOverEvent: true,
                    slideTime: 0, //对象平滑过渡持续时间，默认为1000ms,
                    autoChange: false,
                    botPrev: ".arrow-l",//按钮上一个，默认为空
                    botNext: ".arrow-r",//按钮下一个。默认为空
                })
                if (data.length < 5) {
                    $(".arrow-l").hide();
                    $(".arrow-r").hide();
                } else {
                    $(".arrow-l").show();
                    $(".arrow-r").show();
                }
                $("#smenu").find("a").eq(0).addClass("selected");
                BrandsGetContent($("#smenu").find("a").eq(0).data("cls"))
            } else {
                $("#smenu").empty();
                $(".arrow-l").hide();
                $(".arrow-r").hide();
            }
        }
    })
}

function BrandsGetContent(id) {
    $.ajax({
        url: "/Brands/GetContent",
        dataType: "json",
        type: "post",
        data: { cls: id },
        success: function (data) {
            if (data != null) {
                $("#content").empty().html(data.Content)
            } else {
                $("#content").empty().html("<p style='text-align:center'>没有相关信息</p>");
            }
        }
    })
}
