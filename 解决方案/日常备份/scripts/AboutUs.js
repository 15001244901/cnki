$(function () {
    SelectNav("aboutUs");
    //绑定分类
    BindTheme();
    $(".aside-list").on("click", "li", function () {
        var id = $(this).data("id");
        var type = $(this).data("type");
        $(this).addClass("current").siblings().removeClass("current");
        if (type == "top") {
            $(".about-info-con").eq(0).show().siblings(".about-info-con").hide();
            BindContent(id);
        } else if (type == "department") {
            $(".about-info-con").eq(2).show().siblings(".about-info-con").hide();
            BindDepart();
        } else if(type=="company"){
            $(".about-info-con").eq(1).show().siblings(".about-info-con").hide();
            BindCompany();
            //BindAwardBook();
        } else {
            $(".about-info-con").eq(3).show().siblings(".about-info-con").hide();
            BindAwardBook();
        }
    });
    $(".top-content").hide();

});
function BindTheme() {
    $.ajax({
        url: "/AboutUs/BindTheme",
        type: "post",
        success: function (json) {
            if (json.success) {
                var html = "";
                $.each(json.result, function (i, item) {
                    html += "<li data-id='" + item.ID + "' data-type='top'><span>" + item.Name + "</span></li>";
                });
                html += "<li data-type='department'><span>编辑部门</span></li><li data-type='company'><span>企业荣誉</span></li><li data-type='awardbook'><span>获奖图书</span></li>";
                $(".aside-list").empty().html(html);
                $(".aside-list li:first").addClass("current");
                var type = $(".aside-list li.current").data("type");
                var id = $(".aside-list li.current").data("id");
                if (type == "top") {
                    $(".about-info-con").eq(0).show().siblings(".about-info-con").hide();
                    BindContent(id);
                } else if (type == "department") {
                    $(".about-info-con").eq(2).show().siblings(".about-info-con").hide();
                    BindDepart();
                } else if (type == "company") {
                    $(".about-info-con").eq(1).show().siblings(".about-info-con").hide();
                    BindCompany();
                   // BindAwardBook();
                } else {
                    $(".about-info-con").eq(3).show().siblings(".about-info-con").hide();
                    BindAwardBook();
                }
            } else {
                $(".aside-list").empty();
            }
        }
    });
}
function BindContent(id) {
    $.ajax({
        url: "/AboutUs/BindContent",
        type: "post",
        data: { id: id },
        success: function (json) {
            if (json.success) {
                var msg = eval(json).result;
                if (msg.UseEditor == "0") {
                    window.location.href = msg.Url;
                } else {
                    $(".top-content").empty().html((function () {
                        return "" + msg.Content + "";
                    }));
                }
            } else {
                $(".top-content").empty();
            }
        }
    });
}
var countpage = 1;
//部门分类
function BindDepart() {
    $.ajax({
        url: "/AboutUs/BindDepartmentTheme",
        type: "post",
        success: function (json) {
            if (json.success) {
                var html = "";
                var html2="";
                //一级
                $.each(json.result, function (i, item) {
                    html += "<li data-id='" + item.ID + "' class='"+item.ID+"'><span>" + item.Name + "</span></li>";
                });
                $(".edit-department .con-list ul").empty().html(html);
                //二级
                $.each(json.infoList, function (i, item) {
                    html2 = "<li data-id='" + item.ID + "' class='" + item.ID + "'><span id='spanrank' data-id='" + item.ID + "'>" + item.Name + "</span></li>";
                    //$(".edit-department .con-list ul ." + item.PID + "").appendTo(html2);
                    // $(html2).appendTo(".edit-department .con-list ul ." + item.PID + "")
                    $(".edit-department .con-list ul ." + item.PID + "").after(html2);
                })
               
               

                $(".edit-department .con-list ul li:first").addClass("active");
                BindDepartmentContent($(".edit-department .con-list ul li:first").data("id"));

                $(".edit-department .con-list ul").on("click", "li", function () {
                    $(this).addClass("active").siblings().removeClass("active");
                    // $(this).addClass("active").children().siblings().removeClass("active");
                    var id = $(this).data("id");
                    BindDepartmentContent(id, countpage);
                });

            } else {
                $(".edit-department .con-list ul").empty();
                $(".depart-content").empty();
            }
        }
    });
}

var template = "{{#result}}<div class='depart-digest'>{{{Content}}}</div>\
            <div class='depart-book' style='position: relative;'><h2>部门好书</h2>\
                <ul class='clearfix'>\
                    {{#AboutBook}}<li><a href='/PBook/Detail?doi={{DOI}}' title='{{BookName}}' target='_blank'><img src='/ShowPic/Show?vpath={{ImgUrl}}&vtag={{VirtualPath}}&ptype=1' /><span>{{BookName}}</span></a></li>{{/AboutBook}}\
                </ul>\
            <a href='javascript:;' class='arr-left special-left' data-page='1'></a>\
            <a href='javascript:;' class='arr-right special-right'></a>\
            </div>{{/result}}";
function BindDepartmentContent(id, page) {
    var count = 1;
    $.ajax({
        url: "/AboutUs/BindDepartmentContent",
        type: "post",
        data: { id: id, page: page },
        success: function (json) {
            if (json.success) {
                var html = Mustache.render(template, json);
                $(".depart-content").empty().html(html);
                $(".special-left").click(function () {
                    count = count - 1;
                    if (count <= 0) {
                        count = 1;
                    }
                    BindDepartmentContent(id, count);
                })
                $(".special-right").click(function () {
                    count = count + 1;
                    BindDepartmentContent(id, count);
                })
            } else {
                $(".depart-content").empty();
            }
        }
    });
}

//企业荣誉
function BindCompany() {
    $.ajax({
        url: "/AboutUs/BindCompanyTheme",
        type: "post",
        success: function (json) {
            if (json.success) {
                var html = "";
                $.each(json.result, function (i, item) {
                    html += "<li data-id='" + item.ID + "'><span>" + item.Name + "</span></li>";
                });
                $(".bottom-content>.con-list ul").empty().html(html);
                $(".bottom-content>.con-list ul li:first").addClass("active");
                BindCompanyContent($(".bottom-content>.con-list ul li.active").data("id"));

                $(".bottom-content>.con-list ul").on("click", "li", function () {
                    $(this).addClass("active").siblings().removeClass("active");
                    var id = $(this).data("id");
                    BindCompanyContent(id);
                });

            } else {
                $(".bottom-content>.con-list ul").empty();
                $(".bottom-content .con-list").empty();
            }
        }
    });
}
function BindCompanyContent(id) {
    $.ajax({
        url: "/AboutUs/BindCompanyContent",
        type: "post",
        data: { id: id },
        success: function (json) {
            if (json.success) {
                var num = Math.ceil(Math.random() * 10);
                var html = "<ul class='company-honor'>";
                $.each(json.result.ImgList, function (i, item) {
                    html += "<li><a href='javascript:;'><img src='/ShowPic/Show?vpath=" + item + "'/></a></li>";
                });
                html += "</ul>";
                html += "<p class='indicator change_"+num+"'>";
                json.result.ImgList.map(function (item, i) {
                    html+= "<a></a>";
                });
                html += "</p>";
                $(".bottom-content .con-content").empty().html(html);
                $(".company-honor li").soChange({
                    slideTime: 0,//平滑过渡间歇为0，意味着直接切换 
                    //slideTime:300000,
                    thumbObj: '.change_'+num+' a',
                    thumbNowClass: 'now',
                });
            } else {
                $(".depart-content").empty();
            }
        }
    });
}

//获奖图书
function BindAwardBook() {
    $.ajax({
        url: "/AboutUs/BindAwardBookTheme",
        type: "post",
        success: function (json) {
            if (json.success) {
                var html = "";
                $.each(json.result, function (i, item) {
                    html += "<li data-id='" + item.ID + "'><span>" + item.Name + "</span></li>";
                });
                $(".con-book>.con-list ul").empty().html(html);
                $(".con-book>.con-list ul li:first").addClass("active");
                BindAwardBookContent($(".con-book>.con-list ul li.active").data("id"));

                $(".con-book>.con-list ul").on("click", "li", function () {
                    $(this).addClass("active").siblings().removeClass("active");
                    var id = $(this).data("id");
                    BindAwardBookContent(id);
                });

            } else {
                $(".con-book>.con-list ul").empty();
                $(".con-book-award").empty();
            }
        }
    });
}
var template_book = "{{#result}}<div class='con-award-img'><img src='/ShowPic/Show?vpath={{Url}}'></div>\{{/result}}";
                //{{#AboutBook}}<div class='con-award-detail'>\
                //    <a href='/PBook/Detail?doi={{DOI}}' title='{{BookName}}' target='_blank'><img src='/ShowPic/Show?vpath={{ImgUrl}}&vtag={{VirtualPath}}&ptype=1' /></a>\
                //    <div class='award-content'>\
                //        <a href='/PBook/Detail?doi={{DOI}}' title='{{BookName}}' target='_blank'><span>{{BookName}}</span></a>\
                //        <ul>\
                //            <li>作者：{{Author}}</li>\
                //            <li>定价：{{Price}}</li>\
                //            <li>ISBN：{{ISBN}}</li>\
                //            <li>出版日期：{{Date}}</li>\
                //        </ul>\
                //    </div>\
                //    <div class='award-digest'><p>{{{Digest}}}</p><a href='/PBook/Detail?doi={{DOI}}' title='{{BookName}}' target='_blank'>详情>></a></div></div>{{/AboutBook}}\
                //</div>{{/result}}";
var template_book2 = "{{#result}}{{#AboutBook}}<div class='con-award-detail'>\
                    <a href='/PBook/Detail?doi={{DOI}}' title='{{BookName}}' target='_blank'><img src='/ShowPic/Show?vpath={{ImgUrl}}&vtag={{VirtualPath}}&ptype=1' /></a>\
                    <div class='award-content'>\
                        <a href='/PBook/Detail?doi={{DOI}}' title='{{BookName}}' target='_blank'><span>{{BookName}}</span></a>\
                        <ul>\
                            <li>作者：{{Author}}</li>\
                            <li>定价：{{Price}}</li>\
                            <li>ISBN：{{ISBN}}</li>\
                            <li>出版日期：{{Date}}</li>\
                        </ul>\
                    </div>\
                    <div class='award-digest'><p>{{{Digest}}}</p><a href='/PBook/Detail?doi={{DOI}}' title='{{BookName}}' target='_blank'>详情>></a></div></div>{{/AboutBook}}\
                </div>{{/result}}";
function BindAwardBookContent(id) {
    $.ajax({
        url: "/AboutUs/BindAwardBookContent",
        type: "post",
        data: { id: id },
        success: function (json) {
            if (json.success) {
                var num = Math.ceil(Math.random() * 10);
                var html = Mustache.render(template_book, json);
               
                html += "<p class='indicator detail_" + num + "'>";
                json.result.AboutBook.map(function (item, i) {
                    html += "<a></a>";
                });
                html += "</p>";
                $(".con-book-award").empty().html(html);
                var html2 = Mustache.render(template_book2, json);
                $(".con-book-award").append(html2);
                $(".con-book-award .con-award-detail").soChange({
                    slideTime: 0,//平滑过渡间歇为0，意味着直接切换 
                    //slideTime:300000,
                    thumbObj: '.detail_' + num + ' a',
                    thumbNowClass: 'now',
                });
            } else {
                $(".con-book-award").empty();
            }
        }
    });
}