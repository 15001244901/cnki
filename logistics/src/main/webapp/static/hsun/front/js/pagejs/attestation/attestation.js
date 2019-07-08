// $(function(){
	var attestation = function(){
		var that = this;
		this.keyword = $('#keyword');          // 输入的关键词
		this.search_btn = $('#search_btn');  //搜索按钮

        this.container = $('#contents');
        this.pageSinglehtml = $('#pageSinglehtml');

		this.loadData = function(key,id,pagenum){
            $('#contents').removeClass('nodata');
			nowLoadData('#contents');
            if(id){
                var jsondata = {'doctype':'3','keywords':(key || ''),'pageSize':10,'pageNo':pagenum,'directory.id':(id || '')};
            }else{
                var jsondata = {'doctype':'3','keywords':(key || ''),'pageSize':10,'pageNo':pagenum};
            }
			$.ajax({
				'url':urlpath +'/a/doc/docInfo/list.jhtml',
				'type':'get',
				data: jsondata,
				'dataType': "json",
				success:function(ret){
                    // console.log(ret);
                    var datas = ret.data;
                    if(!datas.list){
                        setTimeout(function(){
                            $('#contents').html(' ');
                            that.pageSinglehtml.html(' ');
                            $('#contents').addClass('nodata');
                        },300);
                        return;
                    }

                    var lhtml = [];
                    var lists =  datas.list;
                    for(var i = 0; i < lists.length; i++){
                        lhtml.push('<div class="section">');
                        lhtml.push(' <div class="div5">');
                        lhtml.push('  <span class="three1">');
                        lhtml.push('   <a href="'+urlpath+'/page/attestation/attestationCont.html?id='+lists[i].id+'" style="color:#30bf89" target="_blank" title="点击查看">'+lists[i].title+'</a>');
                        lhtml.push('  </span>');
                        lhtml.push('  <span class="three2">实施日期 : '+(lists[i].publicdate || '未录入')+'</span>');
                        lhtml.push(' </div>');
                        lhtml.push(' <div class="div6">');
                        lhtml.push('  <span class="one6">文件编号：'+(lists[i].fileno || '未录入')+'&nbsp;&nbsp;&nbsp;版次：'+(lists[i].edition || '未录入')+'</span>');
                        if(lists[i].content){
                            lhtml.push('  <span class="two6" onclick="upData(\''+lists[i].content+'\')">下载 </span>');
                        }
                        lhtml.push(' </div>');
                        lhtml.push('</div>');
                    }

                    that.container.html(lhtml.join(""));
                    that.pageSinglehtml.html(datas.frontPageHtml);
                    delDisabled();

				},
				error:function(){
					loadFail("#contents");
				}
			});

		};
		
		this.searchBtn = function (key) {
            $('i.selected').addClass('select').removeClass('selected');
			that.loadData(that.keyword.val());
            // var keyword = $("#keyword").val();
            // if(!keyword)
             //    return;
            // window.open(projectname+'/page/searchResult/library_result.html?keyword='+ keyword,'_blank');
		};

        upData = function(cont){
            if(!validateUser()){
                validateLogin();
                return;
            }

            window.location.href = cont.replace('|','');
        }

		this.hoverTitle = function(){
			var old_x = $('#section .active').position().left;
			$('#bottom_line').css({'left':old_x,'display':'block'} );
			$('#section span').hover(function(){
				var pos_x = $(this).position().left;
				$('#bottom_line').stop().animate({
					'left':pos_x
				},100);
			},function(){
				$('#bottom_line').stop().animate({
					'left':old_x
				},100);
			});
		};

		this.init = function(){
			$("#divheader").load(projectname + "/page/include/header.html"+timestamps);
			this.hoverTitle();
            this.loadData();
			this.search_btn.off('click').on('click',this.searchBtn);

		}

	};
	var atteStation = new attestation;
	atteStation.init();



	//树
	var subTree = function(){
		var that = this;
		this.onecontainer = $('#onecontainer');  //第一层容器
		this.model        = $('#model').html();   //第一层末班
		this.model2        = $('#model_2').html();   //第二层末班

		//初始化树
		this.loadTree = function(){


			$.ajax({
				'url':urlpath +'/a/doc/docInfoDirectory/treeData.jhtml?dtype=3',
				'type':'get',
				'dataType': "json",
				success:function(ret){
					// console.log(ret);
					var datas = ret.data;
					var domString;
					that.onecontainer.append(domString);
					for(var i in datas){
						var dictionary = datas[i];
						if(dictionary.pId == '0' || !datas[i].pId){
                            dictionary.isleaf = that.haveChild(datas,dictionary.id);
							if(dictionary.isleaf){
								dictionary.bg = 'title_radio2';
							}else{
								dictionary.bg = 'title_dash';
							}
							dictionary.title = dictionary.name;
							dictionary.name = structString(dictionary.name);
							domString = that.comPile(that.model,dictionary);
							that.onecontainer.append(domString);

							if(dictionary.isleaf){
                                // $('#sub-'+datas[i].id).find('.select').remove();
								that.chirldData(ret.data,dictionary.id);
							}
						}
					}
				}
			})
		};

		//判断是否有下级
        this.haveChild = function(obj,id){
            var datas = obj;
            var hasleaf = false;
            for(var i in datas){
                var dictionary = datas[i];
                if(dictionary.pId == id){
                    hasleaf = true;
                }
                if(hasleaf){
                    break;
                }
            }
            return hasleaf;
        };

		this.chirldData = function(obj,id){
			var datas = obj;
			for(var i in datas){
				var dictionary = datas[i];
				if(dictionary.pId == id){
                    dictionary.isleaf = that.haveChild(datas,dictionary.id);
					if(dictionary.isleaf){
						dictionary.bg = 'title_radio2';
					}else{
						dictionary.bg = 'title_dash';
					}
					dictionary.title = dictionary.name;
					dictionary.name = structString(dictionary.name);
					domString = that.comPile(that.model2,dictionary);
					$('#sub-'+id).next('ul').append(domString);

					if(dictionary.isleaf){
                        // $('#sub-'+datas[i].id).find('.select').remove();
						that.chirldData(datas,dictionary.id);
					}
				}
			}

		};

		toggerClick = function(is){
			if($(is).hasClass('title_dash')){
				return;
			}
			var is_next = $(is).parent('.one_title').next('ul');
			if(is_next.css('display') == 'none'){
				is_next.slideDown();
				$(is).removeClass('title_radio2').addClass('title_radio1');
			}else{
				is_next.slideUp();
				$(is).removeClass('title_radio1').addClass('title_radio2');
			}
		};

		selClick = function(is){
			$('.selected').removeClass('selected');
			$(is).find('.sel').addClass('selected');

			var idarr = $(is).parent('.one_title').data('id');
			if(idarr == 'all'){
				atteStation.loadData();
			}else{
				atteStation.loadData('',idarr);
			}
		};

		structString = function(str){
			if(!str){
				return str;
			}
			var maxwidth=10;
			var islength = str.length;
			if(islength>maxwidth){
				str = str.substring(0,maxwidth)+'...';
			}

			return str;
		};

		//数据正则匹配方法
		this.comPile = function(templateString , dictionary){
			return templateString.replace(/\{{([A-Za-z]+)\}}/g , function(match,$1,index,string){
				return dictionary[$1];
			});
		};

		// 滚动条快滚动到底部时，知识点窗口折叠
		this.slideUpTopic = function(){
			function BottomJumpPage() {
				var scrollTop = $(this).scrollTop();
				var scrollHeight = $(document).height()-300;
				var windowHeight = $(this).height();
				if (scrollTop + windowHeight >= scrollHeight) { //滚动到底部执行事件
					$('.divlist_fl_list ').slideUp();
				}else{
					$('.divlist_fl_list ').slideDown();
				}
			}
			// $(window).scroll(BottomJumpPage);
			$(window).scroll(function () {
				BottomJumpPage();
				if ($(window).scrollTop() > 205) {
					$('.divlist_fl').addClass('pos');

				} else {
					$('.divlist_fl').removeClass('pos');
				}
			});
		};

		this.init = function(){
			var slim_scroll_height = $(window).height()-80;
			console.log(slim_scroll_height);
			$(".divlist_fl_list").height(slim_scroll_height);
			$(".divlist_fl_list").slimScroll({
				color:'#E4E4E4'
			});
			this.loadTree();
			this.slideUpTopic();
        }
	}

	var subtree = new subTree;
	subtree.init();


	function delDisabled(){
		var length = $('#pagehtml a').length;
		for(var i=0;i<length;i++ ){
			if($('#pagehtml a').eq(i).html() == '...'){
				$('#pagehtml a').eq(i).removeClass('disabled');
			}
		}
	}

    function page(pageno, pagesize) {
        var isid = $('#nowid').val();
        atteStation.loadData('',isid,pageno);
    }
    function delDisabled(){
        var length = $('#pageSinglehtml a').length;
        for(var i=0;i<length;i++ ){
            if($('#pageSinglehtml a').eq(i).html() == '...'){
                $('#pageSinglehtml a').eq(i).removeClass('disabled');
            }
        }
    }

// });
