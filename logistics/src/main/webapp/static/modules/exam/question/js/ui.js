$(function () {

    /*  //延时为了 在加载动态数据后执行此功能；
     setTimeout(function () {
     is_top_down();//题型的第一题不出上移，最后一个不出下移
     }, 500);
     */

    /*显示几个蓝色按钮*/
    // $(document).on("mouseover",".question_fck007",function(){
    //     var _this = $(this).parent().parent();
    //     _this.children(".question_quesopmenu").show();
    //     _this.css("border", "1px solid #1887e3");
    // });

    $(document).on("mouseover",".question_quesbox",function(){
        var _this = $(this);
        _this.children(".question_quesopmenu").show();
        _this.css("border", "1px solid #1887e3");
    });
    $(document).on("mouseleave",".question_quesbox",function(){
        $(this).children(".question_quesopmenu").hide();
        $(this).css("border", "1px solid #fff");
        // $(this).children().children(".question_quesTxt2").hide();
        //$(this).children().children(".question_showAnswer").hide();
    });
    //显示报错
    $(document).on("mouseover",".question_quesdiv",function(){
        $(this).find('font.question_reportError').css("display", "block");
    });
    //隐藏报错
    $(document).on("mouseleave",".question_quesdiv",function(){
        $(this).find('font.question_reportError').css("display", "none");
    });

    /**
     * 答案隐藏/显示
     */
    $(document).on("click",".question_quesopmenu .question_answer",function(){
        var answerTxt = $(this).parent().parent().children().children(".question_quesTxt2");
        answerTxt.slideToggle("slow"); //toggleClass("showAnswer") 2015.12.18 zyp
    });

    /*题型内容试题的上下移部分----开始*/
    $(document).on("click",".question_moveup",function(){
        var onthis = $(this).parent().parent().parent();
        var spanNum1 = parseFloat(onthis.find(".question_quesindex b span").html()) + "."
        var spanNum2 = parseFloat(onthis.prev().find(".question_quesindex b span").html()) + "."
        var getUp = onthis.prev();
        if (onthis.prev().html() == null) {
            //alert("顶级元素不能上移");
            return;
        }
        onthis.prev().find(".question_quesindex b span").html(spanNum1);
        onthis.find(".question_quesindex b span").html(spanNum2);
        $(onthis).after(getUp);
        onthis.fadeOut(500).fadeIn(500);
        is_top_down(); //题型的第一题不出上移，最后一个不出下移
    });
    $(document).on("click",".question_movedn",function(){
        var onthis = $(this).parent().parent().parent();
        var spanNum1 = parseFloat(onthis.find(".question_quesindex b span").html()) + "."
        var spanNum2 = parseFloat(onthis.next().find(".question_quesindex b span").html()) + "."
        var getdown = onthis.next();
        if (onthis.next().html() == null) {
            //alert("最底部元素不能下移");
            return;
        }
        onthis.next().find(".question_quesindex b span").html(spanNum1);
        onthis.find(".question_quesindex b span").html(spanNum2);
        $(this).parent().hide();
        $(this).parent().parent().css("border", "1px solid #fff");
        $(this).parent().parent().find(".question_quesTxt2").hide();
        $(this).parent().parent().find(".question_showAnswer").hide();
        $(getdown).after(onthis);
        onthis.fadeOut(500).fadeIn(500);
        is_top_down(); //题型的第一题不出上移，最后一个不出下移
    });
    /*题型内容试题的上下移部分----结束*/


});
//题型的第一题不出上移，最后一个不出下移 
function is_top_down() {
    $(".question_questypebody").each(function () {
        var _this = $(this);
        //默认让其全显示
        _this.find("ul li").find("div[class=question_quesopmenu]").find("a[class=question_moveup]").show();
        _this.find("ul li").find("div[class=question_quesopmenu]").find("a[class=question_movedn]").show();
        //判断如果是第一个或最后一个则让其隐藏
        _this.find("ul li:first-child").find("div[class=question_quesopmenu]").find("a[class=question_moveup]").hide();
        _this.find("ul li:last-child").find("div[class=question_quesopmenu]").find("a[class=question_movedn]").hide();
    });
}