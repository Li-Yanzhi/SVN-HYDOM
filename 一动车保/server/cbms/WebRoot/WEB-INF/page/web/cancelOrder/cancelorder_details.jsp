<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/taglib.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 	<meta http-equiv="content-type" content="text/html;charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=8" />
	<title>取消订单详情</title>
	<link href="${pageContext.request.contextPath}/resource/chain/css/style.css" type="text/css" rel="stylesheet" />	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/chain/js/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/chain/js/function.js"></script>
	<style type="text/css">
		/******form*******/
		.divselectcon {clear: both; padding: 10px 0 20px; position: relative; }
		.divselect {float: left; }
		.divselectcon input {width:238px; height: 35px; margin: 0 20px; position:relative; z-index:10000; border: 1px solid #b1b1b1; border-top: 2px solid #b1b1b1; line-height:35px; display:inline-block; color:#807a62; font-style:normal; background:url(images/corners2.png) no-repeat right center;}
		.divselectcon input.input1 {border:1px solid #ffae00; border-top: 2px solid #ffae00; margin-left: 0; width: 228px; height:35px;line-height:35px; display:inline-block; color:#807a62; font-style:normal; background:url(images/corners1.png) no-repeat right center;}
		#button2 button {float: right; width: 169px; height: 43px; background: url(images/go.png) 0 0 no-repeat; border: none; position: absolute; top: 9px;  cursor: pointer; }
		.bdsug_copy{display:none;}		
	</style>
	<script src="${pageContext.request.contextPath}/resource/chain/js/jquery-1.11.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/chain/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/chain/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/chain/js/modernizr.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/chain/js/pace.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/chain/js/retina.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/chain/js/jquery.cookies.js"></script>
	<script src="${pageContext.request.contextPath}/resource/chain/js/custom.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/myform.js" type="text/javascript"></script>
  </head>
  
  <body>
    <!--上部开始-->
<jsp:include page="../header.jsp"></jsp:include>
<!--上部结束-->
<hr>
<!--中部开始-->
<div class="box3">
<div class="mid box0">
	<div class="steward1-content">
		<div class="steward1-menu" id="steward1-menu">
			<div class="menu-title menu-order active">
				<h3>订单中心</h3>
			</div>
			<ul class="menu-list">
				<li class="menu-item myOrder">
					<a href="${pageContext.request.contextPath}/user/order/list">我的订单</a>
				</li>
				<li class="menu-item cancelOrder on">
					<a href="${pageContext.request.contextPath}/user/order/cancellist">已取消的订单</a>
				</li>
				<li class="menu-item myCoupon">
					<a href="${pageContext.request.contextPath}/user/myCoupon/list">我的优惠券</a>
				</li>
				<li class="menu-item couponPackage">
					<a href="${pageContext.request.contextPath}/user/couponPackage/list">我的会员卡</a>
				</li>
			</ul>
			<div class="menu-title menu-home">
				<h3>我的车管家</h3>
			</div>
			<ul class="menu-list">
				<li class="menu-item myCarModel">
					<a href="${pageContext.request.contextPath}/user/carSteward/list">我的车型库</a>
				</li>
			</ul>
			<div class="menu-title menu-center">
				<h3>账户中心</h3>
			</div>
			<ul class="menu-list">
				<li class="menu-item accountBal">
					<a href="${pageContext.request.contextPath}/user/balance/view">账户余额</a>
				</li>
				<li class="menu-item basicInfo">
					<a href="${pageContext.request.contextPath}/user/information/info">基本信息</a>
				</li>
				<!-- <li class="menu-item changePass">
					<a href="#">修改密码</a>
				</li> -->
				<li class="menu-item feedBack">
					<a href="${pageContext.request.contextPath}/user/feedback/add">意见反馈</a>
				</li>
			</ul>
		</div>
		<div class="steward1-detail" id="steward1-detail">
			<div id="myOrderContent" class="myOrderContent myOrderDetail" style="border: none; ">
				<div class="orderDetails">
					<div class="orderDetailsTop">
						<div class="left">
							<img src="${pageContext.request.contextPath}/resource/page/images/steward_4.png" /><span class="span1">|</span><span>订单详情</span>
						</div>
						<div class="right"><a href="${pageContext.request.contextPath}/user/order/cancellist?memberId=${order.member.id}">返回订单列表&gt;&gt;</a></div>
					</div>
					<div class="orderDetailsContent">
						<div class="left">
						<c:if test="${order.type==1 }"><img src="${pageContext.request.contextPath}/resource/page/images/myOrder1.png" height="165" width="165" /></c:if>
						<c:if test="${order.type==2 }"><img src="${pageContext.request.contextPath}/resource/page/images/myOrder3.png" height="165" width="165" /></c:if>
						<c:if test="${order.type==3 }"><img src="${pageContext.request.contextPath}/resource/page/images/myOrder3.png" height="165" width="165" /></c:if>
						</div>
						<div class="right">
							<ul>
								<li><b>订单编号：</b>${order.num }</li>
								<li><b>订单状态：</b>
												<c:if test="${order.status==31 }">待审核</c:if>
												<c:if test="${order.status==32 }">审核中</c:if>
												<c:if test="${order.status==33 }">退款中</c:if>
												<c:if test="${order.status==34 }">已退款</c:if>
												<c:if test="${order.status==35 }">未通过</c:if>
												</li>
								<li><b>下单时间：</b>${order.createDate }</li>
							</ul>
							<ul>
								<li><b>服务车型：</b>${order.car.name }</li>
								<li><b>车身颜色：</b>${order.carColor }</li>
								<li><b>车&nbsp;牌&nbsp;&nbsp;号：</b>${order.carNum }</li>
							</ul>
							<ul>
								<li><b>支付方式：</b><c:if test="${order.payWay==1 }">货到付款</c:if>
													<c:if test="${order.payWay==2 }">支付宝</c:if>
													<c:if test="${order.payWay==3 }">银联</c:if>
													<c:if test="${order.payWay==4 }">微信</c:if>
													</li>
								<li><b>商品金额：</b><i>￥${productPrice }</i></li>
								<li><b>服务费用：</b><i>￥${serverPrice }</i></li>
								<li><b>优&nbsp;惠&nbsp;&nbsp;券：</b><i>-￥${order.amount_paid }</i></li>
								<li><b>实付金额：</b><i>￥${productPrice+serverPrice-order.amount_paid }</i></li>
							</ul>
							<ul>
								<li><b>服务方式：</b><c:if test="${order.serverWay==1 }">上门服务</c:if>
					                               <c:if test="${order.serverWay==2 }">到门店</c:if>							
								</li>
								<li><b>预约时间：</b><fmt:formatDate value="${order.makeStartDate }" type="both"/></li>
								<li><b>服务地址：</b>${order.address }</li>
							</ul>
							<c:forEach items="${order.serverOrder }" var="serverOrder">
								<%-- <ul>
									<li><b>服务名称：</b>${serverOrder.name }</li>
									<li><b>服务评分：</b><em ></em><em></em><em></em><em></em><em class="no"></em></li>
									<li><b>服务评论：</b>${serverOrder.comment.scontent}</li>
								</ul> --%>
							</c:forEach>
							<c:forEach items="${order.serverOrderDetail }" var="serverOrderDetail">						
								<ul>
									<li><b>商品名称：</b>${serverOrderDetail.name }</li>
									<li><b>价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格：</b>￥${serverOrderDetail.price }</li>
									<li><b>数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量：</b>${serverOrderDetail.count }</li>
								</ul>
								<%-- <ul>
								<li><b>商品评分：</b><em ></em><em></em><em></em><em></em><em class="no"></em></li>
								<li><b>商品评论：</b>${serverOrderDetail.comment.pcontent }</li>
							</ul> --%>
							</c:forEach>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
	$(function(){
	function tabs(tabTit,on,active,tabCon){ 
		$(tabCon).each(function(){ 
			$(this).children().eq(0).show();  
		});
		$(tabTit).each(function(){
			//$(this).children().eq(0).addClass(on);
		});
		$(tabTit).children().click(function(){ 
			$(this).addClass(on).siblings().removeClass(on);
			var index = $(tabTit).children().index(this);
			$(tabCon).children().eq(index).show().siblings().hide();
			$(this).siblings().addClass(on);			
			$(this).siblings().removeClass(on);
			$(this).parent().siblings().children().removeClass(on);
			
			$(this).parent().siblings().removeClass(active);
			$(this).parent().prev().addClass(active);			
		});
	}	
	tabs(".menu-list","on","active","#steward1-detail");
	})


	$(function(){
		function tabs(tabTit,liSelected,tabCon){ 
			$(tabCon).each(function(){ 
				$(this).children().eq(0).show();  
			});
			$(tabTit).each(function(){
				//$(this).children().eq(0).addClass(liSelected);
			});
			$(tabTit).children().click(function(){ 
				$(this).addClass(liSelected).siblings().removeClass(liSelected);
				var index = $(tabTit).children().index(this);
				$(tabCon).children().eq(index).show().siblings().hide();
				$(this).siblings().addClass(liSelected);			
				$(this).siblings().removeClass(liSelected);
				$(this).parent().siblings().children().removeClass(liSelected);				
			});
		}
		tabs(".totalTitle","liSelected",".orderListsContent");
	})
	
	
	
			
	$(document).ready(function(){
		$(".selectInput").focus(function(){
			$(this).addClass("selected");
		});
		$(".selectInput").blur(function(){
			$(this).removeClass("selected");
		});
	});
		
	$(function(){  
 
		//判断浏览器是否支持placeholder属性
		supportPlaceholder='placeholder'in document.createElement('input'),
 
		placeholder=function(input){
	 
			var text = input.attr('placeholder'),
			defaultValue = input.defaultValue;
		 
			if(!defaultValue){
		 
			  input.val(text).addClass("phcolor");
			}
	 
			input.focus(function(){
		 
			  if(input.val() == text){
		   
				$(this).val("");
			  }
			});
	 
	  
			input.blur(function(){
		 
			  if(input.val() == ""){
			   
				$(this).val(text).addClass("phcolor");
			  }
			});
	 
			//输入的字符不为灰色
			input.keydown(function(){
		  
			  $(this).removeClass("phcolor");
			});
		  };
 
		  //当浏览器不支持placeholder属性时，调用placeholder函数
		  if(!supportPlaceholder){
		 
			$('input').each(function(){
		 
			  text = $(this).attr("placeholder");
		 
			  if($(this).attr("type") == "text"){
		 
				placeholder($(this));
			  }
			});
		  }
 
	});	
	</script>
</div>
</div>
<!--中部结束-->
<!--底部开始-->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部结束-->
  </body>
</html>
