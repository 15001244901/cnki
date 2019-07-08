$(document).ready(function () {
    var aMenuOneLi = $(".menu-one > li");
    var aMenuTwo = $(".menu-two");
    var iii = $(".menu-one > li > .header > i");
    $(".menu-one > li > .header > i").each(function (i) {
        $(this).click(function () {
            if ($(aMenuTwo[i]).css("display") == "block") {
                $(aMenuTwo[i]).slideUp(300);
                $(aMenuOneLi[i]).removeClass("menu-show");
                $(iii)[i].className = "fa fa-plus-square";
            } else {
              for (var j = 0; j < aMenuTwo.length; j++) {
                 $(aMenuTwo[j]).slideUp(300);
                  $(aMenuOneLi[j]).removeClass("menu-show");
                  $(iii)[j].className = "fa fa-plus-square";
              }
                $(aMenuTwo[i]).slideDown(300);
                $(aMenuOneLi[i]).addClass("menu-show");
                $(iii)[i].className = "fa fa-minus-square";
            }
        });
    });
});