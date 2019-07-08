var especial_public = true;
// true为pc，false为移动
if(/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
    especial_public = false;
    var esp_urlpath = $('<script></script>');
    esp_urlpath.prop('src',urlpath+'/static/hsun/front/js/especial_mobile/especial_urlpath.js');
    var esp_header = $('<script></script>');
    esp_header.prop('src',urlpath+'/static/hsun/front/js/especial_mobile/especial_header.js');
    var especial_css = $('<link rel="stylesheet" type="text/css">');
    especial_css.prop('href',urlpath+'/static/hsun/front/js/especial_mobile/especial_public.css');
    var font_style = $('<link rel="stylesheet" type="text/css">');
    font_style.prop('href',urlpath+'/static/hsun/front/mobile/font/iconfont.css');
    $('#totalPath').after(especial_css);
    $('#totalPath').after(esp_header);
    $('#totalPath').after(esp_urlpath);
    $('#totalPath').after(font_style);

    if($('#courses_list').length>0){
        $('#courses_list').remove();
    }

}else{
    especial_public = true;
    var window_url = window.location.pathname;

    var esp_urlpath = $('<script></script>');
    esp_urlpath.prop('src',urlpath+'/static/hsun/front/js/urlpath.js');
    var esp_header = $('<script></script>');
    esp_header.prop('src',urlpath+'/static/hsun/front/js/header.js');

    if(window_url.match('myCourses') || window_url.match('myFavourites') || window_url.match('myqa') || window_url.match('myrepqa') || window_url.match('user/info') || window_url.match('user/modifyPwd')){

    }else{
        $('#totalPath').after(esp_header);
        $('#totalPath').after(esp_urlpath);
    }


}
