$(document).ready(function () {
    var aMenuOneLi = $(".one > li");
    var aMenuTwo = $(".two");
    $(".one > li > .header1").each(function (i) {
        $(this).click(function () {
            if ($(aMenuTwo[i]).css("display") == "block") {
                $(aMenuTwo[i]).slideUp(300);
                $(aMenuOneLi[i]).removeClass("menu-show")
            } else {
                for (var j = 0; j < aMenuTwo.length; j++) {
                    $(aMenuTwo[j]).slideUp(300);
                    $(aMenuOneLi[j]).removeClass("menu-show");
                }
                $(aMenuTwo[i]).slideDown(300);
                $(aMenuOneLi[i]).addClass("menu-show")
            }
        });
    });
});