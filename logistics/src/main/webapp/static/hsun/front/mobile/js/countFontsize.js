var docElementFontSize = document.documentElement.style.fontSize;

//html 最终的 font-size
var finalDocElementFontSize = window.getComputedStyle(window.document.documentElement).getPropertyValue("font-size");

/*
* 适用于获取屏幕宽度等分设置html的font-size情况，比如 flexible.js库
*/
//计算最终html font-size
function modifileRootRem () {
    var root = window.document.documentElement;
    var fontSize = parseFloat(root.style.fontSize);
    var finalFontSize = parseFloat(window.getComputedStyle(root).getPropertyValue("font-size"));
    if(finalFontSize === fontSize) return;
    root.style.fontSize = fontSize+(fontSize-finalFontSize) + "px";
}
if(typeof window.onload === 'function'){
    var oldFun = window.onload;
    window.onload = function(){
        oldFun();
        modifileRootRem();
    }
}else{
    window.onload = modifileRootRem;
}