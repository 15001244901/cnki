$(function(){
	if(especial_public){
		$("#divheader").load(projectname + "/page/include/header.html"+timestamps);
	}else{
		$("#divheader").remove();
	}
	//热门问答推荐
	hotQuestions();
	$('span:contains("Powered by")').parent().hide();
});

/* 提问前先登录 */
function toAddQuestions(){
	if(isLogin()){
		window.location.href=qapath + "/questions/toadd";
	}else{
		lrFun();
	}
}

// 模糊查询

$('#is_search').click(function(){
	if($('#is_search_title').val() == ''){
		return;
	}
	$("input[name='questions.title']").val($('#is_search_title').val());
	submitForm(0,'type')
});

/**
 * 不同条件查询问答
 * @param type order排序 status等待回答 type(课程问答,学习分享) questionsTagId 问答标签id
 */
function submitForm(keyWord,type){
	if(type=="order"){
		if("status0"==keyWord){
			$("input[name='questions.status']").val(0);
			$("input[name='questions.orderFalg']").val(keyWord);
		}else{
			$("input[name='questions.orderFalg']").val(keyWord);
		}
	}else if(type=="type"){
		$("input[name='questions.type']").val(keyWord);
	}else if(type=="questionsTagId"){
		$("input[name='questions.questionsTagId']").val(keyWord);
	}
	$("input[name='queryCourse.courseName']").val('');
	$("#searchForm").submit();
}

/**
 *热门问答
 */
function hotQuestions(){
	$.ajax({
		url:qapath + "/questions/ajax/hotRecommend",
		data:{
		},
		type:"post",
		dataType:"json",
		async:true,
		success:function(result){
			if(result.success==true){
				var resultList=result.entity;
				var str="";
				for(var i=0;i<resultList.length;i++){
					str+='<li>'
						+'	<aside class="q-r-r-num">'
						+'		<div class="replyNum">'
						+'			<span class="r-b-num">'+resultList[i].replyCount+'</span>'
						+'			<p class="hLh20">'
						+'				<span class="c-999 f-fA">回答数</span>'
						+'			</p>'
						+'		</div>'
						+'	</aside>'
						+'	<h4 class="hLh30 txtOf">'
						+'		<em class="icon16 q-tw">&nbsp;</em>'
						+'		<a href="'+urlpath +'/qa/questions/info/'+resultList[i].id+'" title="" class="fsize14 c-333 ml5">'+resultList[i].title+'</a>'
						+'	</h4>'
						+'</li>';
				}
				$("#hotQuestions").html(str);
			}
		}
	});
}
