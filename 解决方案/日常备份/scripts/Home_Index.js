$(function () {
    //去掉左margin
    $(".news-info-list li:nth-child(2n)").css("margin-right", 0);
    //隔行变色
    $(".pro-nav-list li:nth-child(2n)").css("background", "#f8f8f8");
    //绑定广告
    var size=$("#adSize").val();
    BindAd(0,size);
    //绑定逻辑库
    BindLogical(0, 4);
    //绑定新闻
    BindNewsType();
    //绑定图书
    BindRecommendBook(5, -1);
});

//新书推荐
var template_recommend_book = "<li>\
                        <a href='/PBook/Detail?doi={{Doi}}' title='{{Title}}' target='_blank'>\
                            <img src='/ShowPic/Show?vpath={{ImgPath}}&vtag={{VirtualPathtag}}&ptype=1' alt='' />\
                            <h3>{{Name}}</h3>\
                            <span></span>\
                            <p>{{EssenceDigest}}</p>\
                        </a>\
                    </li>";
function BindRecommendBook(type, size) {
    $.ajax({
        url: "/PBook/BindRecommendBook",
        type: "post",
        data: { flag: type, size: size },
        dataType: "json",
        success: function (json) {
            if (json.success) {
                var html = "<ul class='newbook-list clearfix'>";
                $.each(json.models, function (i, item) {
                    if (i % 5 == 0 && i != 0) {
                        html += "</ul><ul class='newbook-list clearfix'>";
                    }
                    html += Mustache.render(template_recommend_book, item);
                });
                $(".book-rec-list").empty().append(html);
                $(".book-rec-list ul").soChange({
                    btnPrev: ".recommend-left", //按钮上一个，默认为空
                    btnNext: ".recommend-right", //按钮下一个。默认为空
                    slideTime: 0,//平滑过渡间歇为0，意味着直接切换 
                    //slideTime:300000,
                });
            } else {
                $(".book-rec-list").empty();
            }
        }
    });
}

//广告
var template_ad = "{{#models}}<li>{{#IsGtFive}}<a href='/Home/AdContent?id={{Doi}}' target='_blank'>{{/IsGtFive}}{{^IsGtFive}}<a href='{{Url}}' target='_blank'>{{/IsGtFive}}<img src='/ShowPic/Show?vpath={{ImgPath}}&vtag={{VirtualPathtag}}&ptype=1' alt='' /></a></li>{{/models}}";
function BindAd(type, size) {
    $.ajax({
        url: "/Home/BindAd",
        type: "post",
        data: { type: type, size: size },
        dataType: "json",
        success: function (json) {
            if (json.success) {
                var html = Mustache.render(template_ad, json);
                $("#slide").empty().append(html);
                var ahtml = "";
                for (var i = 0; i < json.models.length;i++)
                {
                    ahtml += "<a href='javascript:;'></a>";
                }
                $(".slide-alist").empty().append(ahtml);
                $("#slide li").soChange({
                    thumbObj: ".slide-alist a",
                    thumbNowClass:"active"
                });
            } else {
                $("#slide").empty();
            }
        }
    });
}

//逻辑库
var template_logical = "{{#models}}<div class='lib-item'>\
        <a href='{{Url}}/LogicaDataBase/Detail?doi={{Doi}}' target='_blank'><img src='{{Url}}/ShowPic/Show?vpath={{ImgPath}}&vtag={{VirtualPathtag}}&ptype=1' alt='' />\
            <div class='lib-item-con'>\
                <h3 title='{{Title}}'>{{Name}}</h3>\
                <span></span>\
                <p>{{{Digest}}}</p>\
            </div>\
        </a>\
    </div>{{/models}}";
function BindLogical(flag, size) {
    $.ajax({
        url: "/Home/BindRecommendLogical",
        type: "post",
        data: { flag: flag, size: size },
        dataType: "json",
        success: function (json) {
            if (json.success) {
                var html = Mustache.render(template_logical, json);
                $(".library").empty().append(html);
            } else {
                $(".library").empty();
            }
        }
    });
}

//新闻类型
function BindNewsType() {
    $.ajax({
        url: "/Home/BindType",
        type: "post",
        dataType: "json",
        success: function (json) {
            if (json.success) {
                var html = "<ul class='h2-title-tabs simplified' style='display:none'>";
                $.each(json.models, function (i, item) {
                    html += "<li data-type='" + item.Type + "' data-flag='" + item.Flag + "'>" + item.Value + "</li>";
                });
                html += "</ul>";
                html += "<ul class='h2-title-tabs traditional' style='display:none'>";
                $.each(json.models, function (i, item) {
                    html += "<li data-type='" + item.Type + "' data-flag='" + item.Flag + "'>" + item.TrValue + "</li>";
                });
                html += "</ul>";
                html += "<ul class='h2-title-tabs english' style='display:none'>";
                $.each(json.models, function (i, item) {
                    html += "<li data-type='" + item.Type + "' data-flag='" + item.Flag + "'>" + item.EnValue + "</li>";
                });
                html += "</ul>";
                $(".news-nav").empty().append(html);
                var action = getCookie("changeAction") || "simplified";
                $(".news-nav ." + action + "").show();
                $("." + action + " li:first").addClass("active");
                var flag = $("." + action + " li:first").data("flag");
                BindRecommendNews(flag, 4);
                changeNews();
            } else {
                $(".h2-title-tabs").empty();
            }
        }
    });
}

//推荐新闻
var template_news = "{{#models}}<li>\
                <div class='news-info-con'>\
                    <h3><a href='/News/Detail?doi={{Doi}}' data-doi='{{Doi}}' title='{{Title}}' target='_blank'>{{Name}}</a></h3>\
                    <p>{{Digest}}</p>\
                </div>\
                <div class='high-mask'>\
                    <strong>{{Day}}</strong><span>{{YearMonth}}</span>\
                </div>\
            </li>{{/models}}";
function BindRecommendNews(flag, size) {
    $.ajax({
        url: "/Home/BindRecommendNews",
        type: "post",
        data: { flag: flag, size: size },
        dataType: "json",
        success: function (json) {
            if (json.success) {
                var html = Mustache.render(template_news, json);
                $(".news-info-list").empty().append(html);
            } else {
                $(".news-info-list").empty();
            }
        }
    });
}

//推荐图书
//var template_book = "{{#models}}<li>\
//                <div class='rec-reading-con'>\
//                    <span class='reading-head'></span>\
//                    <h3 title='{{Title}}'><a href='/PBook/Detail?doi={{Doi}}' target='_blank'>{{Name}}</a></h3>\
//                    {{#AuthorNew}}<h4>{{authorName}}  {{authorForm}}</h4>{{/AuthorNew}}\
//                    <h4><span>{{&EssenceDigest}}</span></h4>\
//                    <p>{{&ExecutiveEditor}}</p>\
//                <span class='relater-link'>相关文章：{{#linkInfo}}<a href='{{LinkUrl}}' title='{{LinkName}}' target='_blank' class='out-link'>{{LinkName}}</a>{{/linkInfo}}</span>\
//                    <div class='pub-about'>出版社： {{Issuedep}} -- ISBN：{{ISBN}} -- 出版时间：{{IssueDate}}</div>\
//                </div>\
//                <a href='/PBook/Detail?doi={{Doi}}' target='_blank'><img src='/ShowPic/Show?vpath={{ImgPath}}&vtag={{VirtualPathtag}}&ptype=1' alt='' /></a>\
//            </li>{{/models}}";
//function BindRecommendBook(flag, size) {
//    $.ajax({
//        url: "/Home/BindRecommendBook",
//        type: "post",
//        data: { flag: flag, size: size },
//        dataType: "json",
//        success: function (json) {
//            if (json.success) {
//                var html = Mustache.render(template_book, json);
//                $(".slider-list").empty().append(html);
//                $(".slider-list li").soChange({
//                    btnPrev: ".special-left", //按钮上一个，默认为空
//                    btnNext: ".special-right", //按钮下一个。默认为空
//                    slideTime: 0//平滑过渡间歇为0，意味着直接切换
//                });
//            } else {
//                $(".slider-list").empty();
//            }
//        }
//    });
//}
