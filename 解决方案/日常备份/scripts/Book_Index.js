$(function () {
    //绑定广告
    var size = $("#adSize").val();
    BindAd(1, size);

    //绑定书讯
    BindBookNews(12, 6);

    //绑定推荐图书
    BindRecommendBook(4, -1);

    //书目管理
    //年度书目
    //BindFormatDate("menu-book-year");
    $(".menu-book-year li").click(function () {
        var name = $(this).data("year");
        var childEm = $(".menu-book-year").siblings().children("em");
        if (name != "请选择") {
            childEm.html(name + "年");
        } else {
            childEm.html(name);
        }
        childEm.attr("data-type", name);
    });

    //馆配书目
    BindFormatDate("menu-library-year");

    //绑定特定书目分类
    BindTypeBookCatalog(2, 20, "year_book");
    BindTypeBookCatalog(3, 20, "special_book");
    BindTypeBookCatalog(4, 20, "award_book");
    BindTypeBookCatalog(5, 20, "library_book");

    //年度书目下载
    $(".year-down").click(function () {
        $("input[name=TYPE]").val(2);
        var year = $(".book-year").attr("data-type");
        $("input[name=YEAR]").val(year);
        console.log(year);
        if (isNull(year)) {
            layer.alert("请完整选项！");
        } else {
            $("#form_bookcatalog").submit();
        }
    });

    //馆配书目下载
    $(".library-down").click(function () {
        $("input[name=TYPE]").val(5);
        var year = $(".library-year").attr("data-type");
        $("input[name=YEAR]").val(year);
        if (isNull(year)) {
            layer.alert("请完整选项！");
        } else {
           $("#form_bookcatalog").submit();
        }
    });

    //绑定资源
    BindResource("1", 6);

    //绑定精品教材
    BindRecommendTextBook("9", -1);


    //绑定特色精品
    var type = $(".h2-title-tabs li.active").data("type");
    BindRecommendSpecialBook(type, -1);

    $(".h2-title-tabs li").click(function () {
        var type = $(this).data("type");
        $(this).addClass("active").siblings().removeClass("active");
        BindRecommendSpecialBook(type, -1);
    });

    //绑定目录
    var type = $(".book-theme h2.cur").data("type");
    var bookType = $(".book-theme h2.cur").data("index")||"";
    BindTheme(type, bookType);

    $(".book-theme h2").click(function () {
        var type = $(this).data("type");
        $(this).addClass("cur").siblings().removeClass("cur");
        var bookType = $(this).data("index")||"";
        BindTheme(type,bookType);
    });

    //绑定销售图书
    var type = $(".sale-book h2.cur").data("type")||10;
    BindSaleBook(type, 10);
    $(".sale-book h2").click(function () {
        $(this).addClass("cur").siblings().removeClass("cur");
       var type= $(this).data("type");
        BindSaleBook(type, 10);
    });

    $(".sale-type span").click(function () {
        var type = $(this).attr("data-type");
        $(this).addClass("select").siblings().removeClass("select");
        BindSaleBook(type, 10);
    });
    $(".sale-type2 span").click(function () {
        var type = $(this).attr("data-type");
        $(this).addClass("select").siblings().removeClass("select");
        BindSaleBook(type, 10);
    });
});
//广告
var template_ad = "{{#models}}<li><a href='{{Url}}'><img src='/ShowPic/Show?vpath={{ImgPath}}&vtag={{VirtualPathtag}}&ptype=1' alt='' /></a></li>{{/models}}";
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
                for (var i = 0; i < json.models.length; i++) {
                    ahtml += "<a href='javascript:;'></a>";
                }
                $(".slide-alist").empty().append(ahtml);
                $("#slide li").soChange({
                    thumbObj: ".slide-alist a",
                    thumbNowClass: "active"
                });
            } else {
                $("#slide").empty();
            }
        }
    });
}

//书讯
var template_book_news = "{{#models}}<li><a href='/News/Detail?doi={{Doi}}' title='{{Title}}' data-id='{{Doi}}' target='_blank'>{{Name}}</a></li>{{/models}}";
function BindBookNews(type, size) {
    $.ajax({
        url: "/PBook/BindBookNews",
        type: "post",
        data: { flag: type, size: size },
        dataType: "json",
        success: function (json) {
            if (json.success) {
                var html = Mustache.render(template_book_news, json);
                $(".book-news-list").empty().append(html);
            } else {
                $(".book-news-list").empty();
            }
        }
    });
}

//推荐图书
//var template_recommend_book = "<li>\
//                        <a href='/PBook/Detail?doi={{Doi}}' title='{{Title}}' target='_blank'>\
//                            <img src='/ShowPic/Show?vpath={{ImgPath}}&vtag={{VirtualPathtag}}&ptype=1' alt='' />\
//                            <h3>{{Name}}</h3>\
//                            <span></span>\
//                            <p>{{EssenceDigest}}</p>\
//                        </a>\
//                    </li>";
//function BindRecommendBook(type, size) {
//    $.ajax({
//        url: "/PBook/BindRecommendBook",
//        type: "post",
//        data: { flag: type, size: size },
//        dataType: "json",
//        success: function (json) {
//            if (json.success) {
//                var html = "<ul class='newbook-list clearfix'>";
//                $.each(json.models, function (i, item) {
//                    if (i % 3 == 0 && i != 0) {
//                        html += "</ul><ul class='newbook-list clearfix'>";
//                    }
//                    html += Mustache.render(template_recommend_book, item);
//                });
//                $(".book-rec-list").empty().append(html);
//                $(".book-rec-list ul").soChange({
//                    btnPrev: ".recommend-left", //按钮上一个，默认为空
//                    btnNext: ".recommend-right", //按钮下一个。默认为空
//                    slideTime: 0,//平滑过渡间歇为0，意味着直接切换 
//                    //slideTime:300000,
//                });
//            } else {
//                $(".book-rec-list").empty();
//            }
//        }
//    });
//}

var template_type = "{{#models}}<a href='{{FILEURL}}' data-id='{{DOI}}' target='_blank'>{{NAME}}</a>{{/models}}";
//绑定特定分类下的书目
function BindTypeBookCatalog(type, size, style) {
    $.ajax({
        url: "/Download/BindTypeBookCatalog",
        type: "post",
        data: { type: type, size: size },
        dataType: "json",
        success: function (data) {
            if (data.success) {
                var html = Mustache.render(template_type, data);
                $("." + style + "").empty().append(html);
                $("." + style + " a:gt(3)").hide();
            }
            else {
                $("." + style + "").empty();
            }
        }
    });
}

var template_resource = "{{#models}}<li>\
                        <div class='li-item'>\
                            <span title='{{Title}}'>{{Name}}</span><a href='/Download/DownFileResource?id={{Doi}}&type=1' target='_blank'>下载></a></div>\
                        </li>{{/models}}";
//绑定资源
function BindResource(type, size) {
    $.ajax({
        url: "/PBook/BindResource",
        type: "post",
        data: { type: type, size: size },
        dataType: "json",
        success: function (data) {
            if (data.success) {
                var html = Mustache.render(template_resource, data);
                $(".resouce-list").empty().append(html);
            }
            else {
                $(".resouce-list").empty();
            }
        }
    });
}

//特色精品
var template_special_book = "<li>\
                        <a href='/PBook/Detail?doi={{Doi}}' target='_blank'><img src='/ShowPic/Show?vpath={{ImgPath}}&vtag={{VirtualPathtag}}&ptype=1' alt='' /></a>\
                        <h4><a href='/PBook/Detail?doi={{Doi}}' title='{{Title}}' target='_blank'>{{Name}}</a></h4>\
                        <p title='{{NoSubAuthor}}'>作 者：{{Author}}</p>\
                        <p>出版时间：{{Date}}</p>\
                    </li>";
function BindRecommendSpecialBook(type,size) {
    $.ajax({
        url: "/PBook/BindRecommendBook",
        type: "post",
        data: { flag: type, size: size },
        dataType: "json",
        success: function (json) {
            if (json.success) {
                var html = "<ul class='rec-list clearfix'>";
                $.each(json.models, function (i, item) {
                    if (i % 5 == 0 && i != 0) {
                        html += "</ul><ul class='rec-list clearfix'>";
                    }
                    html += Mustache.render(template_special_book, item);
                });
                $(".fea-book-list").empty().append(html);
                $(".fea-book-list ul").soChange({
                    btnPrev: ".special-left", //按钮上一个，默认为空
                    btnNext: ".special-right", //按钮下一个。默认为空
                    slideTime: 0//平滑过渡间歇为0，意味着直接切换 
                });
            } else {
                $(".fea-book-list").empty();
            }
        }
    });
}

//精品教材
function BindRecommendTextBook(type, size) {
    $.ajax({
        url: "/PBook/BindRecommendBook",
        type: "post",
        data: { flag: type, size: size },
        dataType: "json",
        success: function (json) {
            if (json.success) {
                var html = "<ul class='text-list clearfix'>";
                $.each(json.models, function (i, item) {
                    if (i % 5 == 0 && i != 0) {
                        html += "</ul><ul class='text-list clearfix'>";
                    }
                    html += Mustache.render(template_special_book, item);
                });
                $(".text-book-list").empty().append(html);
                if (json.models.length < 6) {
                    $(".text-left").hide();
                    $(".text-right").hide();

                }
                $(".text-book-list ul").soChange({
                    btnPrev: ".text-left", //按钮上一个，默认为空
                    btnNext: ".text-right", //按钮下一个。默认为空
                    slideTime: 0//平滑过渡间歇为0，意味着直接切换 
                });
            } else {
                $(".text-book-list").empty();
            }
        }
    });
}

//特色精品
var template_theme = "{{#models}}<li>\
                <dl>\
                    <dt data-id='{{id}}'>{{#IsUrl}}<a href='/PBook/List?ThemeFirst={{id}}' data-id={{id}} target='_blank'>{{/IsUrl}}{{^IsUrl}}<a href='javascript:;' data-id={{id}}>{{/IsUrl}}<span>{{name}}</span></a></dt>\
                    <dd>{{#SecondList}}{{#IsUrl}}<a href='/PBook/List?ThemeFirst={{id}}' data-id={{id}} target='_blank'>{{/IsUrl}}{{^IsUrl}}<a href='javascript:;' data-id={{id}}>{{/IsUrl}}{{name}}</a>{{/SecondList}}</dd>\
                </dl>\
            </li>{{/models}}";

var template_series = "{{#models}}<li>\
                <dl>\
                    <dt data-id='{{id}}'><a href='/PBook/List?ThemeFirst={{id}}' data-id={{id}} target='_blank'><span>{{name}}</span></a></dt>\
                    <dd></dd>\
                </dl>\
            </li>{{/models}}";
function BindTheme(type, bookType) {
        $.ajax({
            url: "/PBook/BindTheme",
            type: "post",
            data: { type: type },
            dataType: "json",
            success: function (json) {
                if (json.success) {
                    var html = "";
                    if (bookType != "series") {
                        html += Mustache.render(template_theme, json);
                    } else {
                        html = Mustache.render(template_series, json);
                    }
                    $(".pro-nav-list").empty().append(html);
                    $(".pro-nav-list li:gt(5)").hide();
                } else {
                    $(".pro-nav-list").empty();
                }
            }
        });
    //else {
    //    $.ajax({
    //        url: "/SeriesBook/BindSeriesBook",
    //        type: "post",
    //        dataType: "json",
    //        data:{isInter:true},
    //        success: function myfunction(data) {
    //            if (data.success) {
    //                var html = Mustache.render(template_series, data);
    //                $(".pro-nav-list").empty().append(html);
    //            } else {
    //                $(".pro-nav-list").empty();
    //            }
    //        }
    //    });
    //}
}

//销售排行/月度榜单
var template_sale_book = "{{#models}}<li><em>{{Num}}</em><a href='/PBook/Detail?doi={{Doi}}' title='{{Title}}' target='_blank'>{{Title}}</a></li>{{/models}}";
function BindSaleBook(type, size) {
    $.ajax({
        url: "/PBook/BindRecommendBook",
        type: "post",
        data: { flag: type, size: size },
        dataType: "json",
        success: function (json) {
            if (type == 10|| type==16) {
                $(".sale-type2").show();
                $(".sale-type").hide();
            } else {
                $(".sale-type").show();
                $(".sale-type2").hide();
            }
            if (json.success) {
                var html = Mustache.render(template_sale_book, json);
                $(".book-ranking-list").empty().append(html);
            } else {
                $(".book-ranking-list").empty();
            }
        }
    });
}

//绑定时间
function BindFormatDate(type) {
    var date = new Date();
    var arr = new Array();
    var currentYear = date.getFullYear();
    for (var i = 0; i < 8; i++) {
        arr.push(currentYear - i);
    }
    //var lastDateYear = currentYear - 1;
    //arr.push(currentYear, currentYear - 1, currentYear - 2, currentYear - 3, currentYear - 4);
    var str = " <li data-year='请选择'><a href='javascript:;'>请选择</a></li>";
    $.each(arr, function (i) {
        str += " <li data-year='" + arr[i] + "'><a href='javascript:;'>" + arr[i] + "年</a></li>";
    });
    $("." + type + "").empty().append(str);
    $("." + type + " li").click(function () {
        var name = $(this).data("year");
        var childEm = $("." + type + "").siblings().children("em");
        if (name != "请选择") {
            childEm.html(name + "年");
        } else {
            childEm.html(name);
        }
        childEm.attr("data-type", name);
    });


}

//推荐图书
var template_recommend_book = "{{#models}}<li>\
                <div class='rec-reading-con'>\
                    <h3 title='{{Title}}'><a href='/PBook/Detail?doi={{Doi}}' target='_blank'>{{Name}}</a></h3>\
                    {{#AuthorNew}}<h4>{{authorName}}  {{authorForm}}</h4>{{/AuthorNew}}\
                    <h4><span>{{&EssenceDigest}}</span></h4>\
                    <p>{{&ExecutiveEditor}}</p>\
                <span class='relater-link'>相关文章：{{#linkInfo}}<a href='{{LinkUrl}}' title='{{LinkName}}' target='_blank' class='out-link'>{{LinkName}}</a>{{/linkInfo}}</span>\
                    <div class='pub-about'>出版社： {{Issuedep}} -- ISBN：{{ISBN}} -- 出版时间：{{IssueDate}}</div>\
                </div>\
                <a href='/PBook/Detail?doi={{Doi}}' target='_blank'><img src='/ShowPic/Show?vpath={{ImgPath}}&vtag={{VirtualPathtag}}&ptype=1' alt='' /></a>\
            </li>{{/models}}";
function BindRecommendBook(flag, size) {
    $.ajax({
        url: "/Home/BindRecommendBook",
        type: "post",
        data: { flag: flag, size: size },
        dataType: "json",
        success: function (json) {
            if (json.success) {
                var html = Mustache.render(template_recommend_book, json);
                $(".slider-list").empty().append(html);
                $(".slider-list li").soChange({
                    btnPrev: ".special-left", //按钮上一个，默认为空
                    btnNext: ".special-right", //按钮下一个。默认为空
                    slideTime: 0//平滑过渡间歇为0，意味着直接切换
                });
            } else {
                $(".slider-list").empty();
            }
        }
    });
}

function isNull(name) {
    if (name == "" || name == undefined || name == null || name == "请选择") {
        return true
    } else {
        return false;
    }
}