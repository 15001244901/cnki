$(function () {
    BindFundType();
    $(".change-info span").click(function () {
        $(this).addClass("cur").siblings().removeClass("cur");
        var index = $(this).index();
        $(".con_" + index + "").show().siblings("div").hide();
    })
});
//基金项目
var template_type = "{{#models}}<li data-id='{{Doi}}'><a href='javascript:;'>{{Name}}</a></li>{{/models}}";
function BindFundType(type, size) {
    $.ajax({
        url: "/PBook/BindFundType",
        type: "post",
        data: { type: type, size: size },
        dataType: "json",
        success: function (json) {
            if (json.success) {
                var html = Mustache.render(template_type, json);
                $(".fund-aside").empty().append(html);
                $(".fund-aside li:first").addClass("active");
                var doi = $(".fund-aside li.active").data("id");
                BindFundContent(doi);
                BindFundBook(doi);

                $(".fund-aside li").click(function () {
                    var doi = $(this).data("id");
                    $(this).addClass("active").siblings().removeClass("active");
                    BindFundContent(doi);
                    BindFundBook(doi);
                });

            } else {
                $(".fund-aside").empty();
            }
        }
    });
}
//项目内容
function BindFundContent(id) {
    $.ajax({
        url: "/PBook/BindFundContent",
        type: "post",
        data: { id:id},
        dataType: "json",
        success: function (json) {
            if (json.success) {
                $(".fund-banner").empty().append("<img src='/ShowPic/Show?vpath=" + json.model.ImgPath + "&vtag=1&ptype=1' alt='' />");
                $(".fund-info-con").empty().append("" + json.model.TopicalDes + "");
                $(".con_0").empty().append("" + json.model.EditBoard + "");
                $(".con_2").empty().append("" + json.model.Bibliography + "");
                $(".con_4").empty().append("" + json.model.Preface + "");
            } else {
            }
        }
    });
}
var template_book="<li>\
                     <a href='/PBook/Detail?doi={{Doi}}' data-id='{{Doi}}' target='_blank'><img src='/ShowPic/Show?vpath={{ImgPath}}&vtag={{VirtualPathtag}}&ptype=1' alt='' /></a>\
                     <h4 title='{{Name}}'><a href='/PBook/Detail?doi={{Doi}}' target='_blank'>{{Name}}</a></h4>\
                  </li>";
//项目图书
function BindFundBook(id) {
    $.ajax({
        url: "/PBook/BindFundBook",
        type: "post",
        data: { id: id },
        dataType: "json",
        success: function (json) {
            if (json.success) {
                var html = "<a href='javascript:;' class='arr-left'></a><ul class='pro-result-list clearfix'>";
                $.each(json.models, function (i, item) {
                   // html = "class='arr-left";
                    if (i % 4 == 0 && i != 0) {
                        html += "</ul><ul class='pro-result-list clearfix'>";
                    }
                    html += Mustache.render(template_book, item);
                });
                   
               // html += "class='arr-left left</ul>";
                $(".fund-book").empty().append(html);
                $(".fund-book").append("<a href='javascript:;' class='arr-right'></a>");
                $(".fund-book ul").soChange({
                    btnPrev: ".arr-left", //按钮上一个，默认为空
                    btnNext: ".arr-right", //按钮下一个。默认为空
                    slideTime: 0//平滑过渡间歇为0，意味着直接切换 
                });
            } else {
                $(".fund-book").empty();
            }
        }
    });
}