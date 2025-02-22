<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<meta name="description" content="">

<title>服务类型添加</title>
<link
	href="${pageContext.request.contextPath}/resource/chain/css/style.default.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resource/chain/css/morris.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resource/chain/css/select2.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resource/css/manage.common.css"
	rel="stylesheet">

<script
	src="${pageContext.request.contextPath}/resource/chain/js/jquery-1.11.1.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/chain/js/jquery-migrate-1.2.1.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/chain/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/chain/js/modernizr.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/chain/js/pace.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/chain/js/retina.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/chain/js/jquery.cookies.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/chain/js/custom.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/chain/js/select2.min.js"></script>
	
<!-- 验证框架 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/jquery.maskedinput-1.0.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/validate/account.js"></script>

<!-- 公共JS -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/myform.js"></script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
        <script src="${pageContext.request.contextPath}/resource/chain/js/html5shiv.js"></script>
        <script src="${pageContext.request.contextPath}/resource/chain/js/respond.min.js"></script>
        <![endif]-->
<STYLE type="text/css">
.form-bordered div.form-group {
	width: 49%;
	padding: 5px 10px;
	border-top: 0px dotted #d3d7db;
}

.img_div{
	display: inline-block;
	height: 60px;
	width: 60px;
}
.img_div img{
	display: inline-block;
	height: 60px;
	width: 60px;
}
span.from-span{
	position: absolute;
   top: 10px;
   right: 15px;
}
.payTypeDiv label{
	margin-top: 8px;
    margin-right: 15px;
}
</STYLE>
</head>
<body>
	<header>
		<%@ include file="/WEB-INF/page/common/head.jsp"%>
	</header>

	<section>
		<div class="mainwrapper">
			<%@ include file="/WEB-INF/page/common/left.jsp"%>

			<div class="mainpanel">
				<div class="pageheader">
					<div class="media">
						<div class="media-body">
							<ul class="breadcrumb">
								<li><a href=""><i class="glyphicon glyphicon-home"></i></a></li>
								<li><a href=""><c:if test="${!empty entity}">服务类型编辑</c:if><c:if test="${empty entity}">服务类型添加</c:if></a></li>
							</ul>
						</div>
					</div>
					<!-- media -->
				</div>
				<!-- pageheader -->

				<div class="contentpanel">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">基本信息</h4>
						</div>
						<form class="form-horizontal form-bordered" id="inputForm"
							action="<%=basePath%>manage/serviceType/save" method="POST">
							<input type="hidden" name="id" value="${entity.id }"/>
							<div class="panel-body nopadding">
								<%-- <div class="form-group">
									<label class="col-sm-4 control-label">服务类型</label>
									<div class="col-sm-8">
										<select id="serviceType" name="type">
											<option value="1" <c:if test="${entity.type eq 1}">selected="selected"</c:if> >产品服务</option>
											<option value="2" <c:if test="${entity.type eq 2}">selected="selected"</c:if> >美容服务</option>
										</select>
									</div>
								</div> --%>
								<div class="form-group">
									<label class="col-sm-4 control-label">服务名称</label>
									<div class="col-sm-8">
										<input type="text" name="name" class="form-control" maxlength="200" value="${entity.name }"  onchange="checkName();"/>
										<label id="labelName">
										
										</label>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-4 control-label">服务图片</label>
									<div class="col-sm-8">
										<div class="img_div">
											<img alt="" src="
											<c:if test="${!empty entity}"><%=basePath %>/${entity.imgPath }</c:if>
											" onerror="<%=basePath %>/resource/image/default.png" id="show_img">
											<input type="hidden" name="imgPath" value="${entity.imgPath }"/>
										</div>
										<label> <%-- style="position: absolute;  float: right;  margin-left: 20%;" --%>
											<span id="spanButtonPlaceholder"></span>
										</label>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-4 control-label">简介</label>
									<div class="col-sm-8">
										<input type="text" name="remark" class="form-control" value="${entity.remark }" placeholder="20字以内" maxlength="20"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-4 control-label">服务车型简介</label>
									<div class="col-sm-8">
										<input type="text" name="remark1" class="form-control" value="${entity.remark1 }" placeholder="200字以内" maxlength="200"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-4 control-label">服务介绍</label>
									<div class="col-sm-8">
										<input type="text" name="remark2" class="form-control" value="${entity.remark2 }" placeholder="200字以内" maxlength="200"/>
									</div>
								</div>
								<%-- <div class="form-group">
									<label class="col-sm-4 control-label">服务时间</label>
									<div class="col-sm-8">
										<input type="text" name="serviceTime" class="form-control" value="${entity.serviceTime }" style="width: 90%;"/><span class="from-span">分钟</span>
									</div>
								</div> --%>
								<div class="form-group">
									<label class="col-sm-4 control-label">服务单价(元)</label>
									<div class="col-sm-8">
										<input type="text" name="price" class="form-control" value="${entity.price }"/>
									</div>
								</div>
								<%-- <div class="form-group">
									<label class="col-sm-4 control-label">服务方式</label>
									<div class="col-sm-8 payTypeDiv">
										<label><input type="radio" name="payType" value="1" <c:if test="${entity.payType eq 1 || empty entity.payType}">checked="checked"</c:if> />全部</label>
										<label><input type="radio" name="payType" value="2" <c:if test="${entity.payType eq 2 }">checked="checked"</c:if> />上门服务</label>
										<label><input type="radio" name="payType" value="3" <c:if test="${entity.payType eq 3 }">checked="checked"</c:if> />门店服务</label>
									</div>
								</div> --%>
								<div class="form-group">
									<label class="col-sm-4 control-label">排序</label>
									<div class="col-sm-8">
										<input type="text" name="order" class="form-control" value="${entity.order}"   ${entity.type==1?"":"readonly='readonly'"} />
									</div>
								</div>
							</div>
							<div class="panel-footer">
								<div class="row">
									<div class="col-sm-9 col-sm-offset-3">
										<button id="addCate" class="btn btn-primary mr5"
											onclick="saveType()" type="button">提交</button>
										<button class="btn btn-dark" type="reset">重置</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="bottomwrapper">
					<%@ include file="/WEB-INF/page/common/bottom.jsp"%>
				</div>
			</div>
			<!-- mainpanel -->
		</div>
		<!-- mainwrapper -->
	</section>
	<!-- 上传图片页面 -->
	<jsp:include page="../common/imgUpload.jsp"></jsp:include>
	<script type="text/javascript">
		var username = "${entity.name}";
		$('[data-toggle="tooltip"]').popover();
		$(document).ready(function(){
			$("#serviceType").select2({
				minimumResultsForSearch : -1,
				allClear : true
			});
		});
		function saveType(){
			
			var name = $("input[name='name']").val();
			if(name == ""){
				alert("请输入服务名称");
				return;
			}
			
			if(username != name){
				var m = $("#labelName").find("span.success");
				if(m.length<=0){
					alert("该名称已存在，请重新输入名称");
					return;
				}
			}
			
			var price = $("input[name='price']").val();
			if(isNaN(price)){
				alert("服务价格请输入数字");
				return;
			}
			
			$("#inputForm").submit();
		}
		
		function setErrorMessage(value,type){
			if(type == 1){
				var html = "<span style='color:red' class='error'>"+value+"</span>";
				$("#labelName").html(html);
			}else if (type == 2){
				var html = "<span style='color:green' class='success'>"+value+"</span>";
				$("#labelName").html(html);
			}
		}
		
		function checkName() {
			setErrorMessage("", 2 );
			
			var name = $("input[name='name']").val();
			if(name == ""){
				return;
			}
			
			if(name == username){
				return;
			}
			
			var url = "<%=basePath%>manage/serviceType/checkName";
			var data = {
				name:name
			}
			$.post(url,data,function(result){
				if(result.status == "success"){
					setErrorMessage(result.message,2);
				}else{
					setErrorMessage(result.message,1);
				}
			},"json");
		}
		
	</script>
</body>
</html>
