$(function(){
	var errorCorrection = function(){
		var that        = this;
		var templateString = $('#template').html();  //获取列表模板
		this.jiucuo        = $('#jiucuo');                   //列表容器
		this.pagehtml      = $('#pagehtml');          //获取分页容器

		this.onload = function(){
			$.ajax({
				url: urlpath_a + '/exam/question/comment.jhtml?ctype=3',
				type: "GET",
				// async: false,
				success: function(ret){
					// console.log(ret);
					var domString;
					for(var j in ret.data.list){
 						var dictionary = ret.data.list[j]; // 获取数据
							// 字典修正，构造一个字段
							if(dictionary.delFlag === "2"){
								dictionary.errstate = "审核中";
							}else if(dictionary.delFlag === "0"){
								dictionary.errstate = "已审核";
							}else if(dictionary.delFlag === "1"){
								continue;
							}


							dictionary.href = 'error_replay.html?id=' + dictionary.qid;
					    domString += that.comPile(templateString , dictionary); //数据绑定
					}


					that.jiucuo.html(domString);
					that.pagehtml.html(ret.data.frontPageHtml);
					if(top.hei){
						top.hei();
					}
				},
				error:function(){

				}
			});
			// var height = window.parent.document.getElementByIdx_x("center_iframe");
			// alert($("#center_iframe", parent.document).css('height','400px'));
		}

		//数据正则匹配方法
		this.comPile = function(templateString , dictionary){
			return templateString.replace(/\{{([A-Za-z]+)\}}/g , function(match,$1,index,string){
				return dictionary[$1];
			});
		}
		this.init = function(){
			this.onload();
		}
	}

	var errorcorrection = new errorCorrection();
	errorcorrection.init();

});	