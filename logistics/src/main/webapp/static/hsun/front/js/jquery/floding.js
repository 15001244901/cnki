$(document).ready(function () {
    var aMenuOneLi = $(".menu-one > li");
    var aMenuTwo = $(".menu-two");
    $(".menu-one > li > .header").each(function (i) {
        $(this).click(function () {
            if ($(aMenuTwo[i]).css("display") == "block") {
                $(aMenuTwo[i]).slideUp(300);
                $(aMenuOneLi[i]).removeClass("menu-closelist")
            } else {
              for (var j = 0; j < aMenuTwo.length; j++) {
                  $(aMenuTwo[j]).slideUp(300);
                  $(aMenuOneLi[j]).removeClass("menu-closelist");
              }
                $(aMenuTwo[i]).slideDown(300);
                $(aMenuOneLi[i]).addClass("menu-closelist")
            }
        });
    });
});